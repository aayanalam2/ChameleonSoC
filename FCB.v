module FCB (
    input clk,
    input reset,
    
    input [2:0] wb_address,
    input [31:0] wb_data_in,
    input [3:0] wb_select,
    input wb_stb,
    input wb_we,
    input wb_bus_cycle,
    output reg [31:0] wb_data_out,

    input fpga_tail,
    output reg prog_clk,
    output reg fpga_head,
    output gReset,
    output op_clk,
    output prset
);
reg programming_reset;
reg [31:0] FCB_control_reg;
reg [31:0] FCB_status_reg;
reg [31:0] Bitstream_write_reg;
reg [31:0] Bitstream_read_reg;
reg [31:0] Bitstream_lenght_reg;
reg [31:0] Bitstream_checksum_reg;

reg [6:0] count_value_write;
reg [31:0] bitstream_count;
reg word_complt, bitstream_complt;


 
reg [31:0] pre_checksum_reg;
reg [31:0] post_checksum_reg;


reg pre_chksum;
reg post_chksum;
reg [2:0] state;
reg clkflag;
  
  
reg checksum_match;
reg checksum_nmatch;
  
  
reg [3:0]checksum_counter;
reg [15:0] regA;
reg [15:0] regB;
reg[7:0] addler_data;
reg [7:0] bitmask;
reg addler_flag;
  

  
assign prset = programming_reset;
assign op_clk = (bitstream_complt) & (clk);
assign gReset = 1;
always @(posedge clk or negedge reset) begin
    if (!reset) begin
        programming_reset <= 1;
        FCB_control_reg <= 32'h0000;
        Bitstream_write_reg <= 32'h0000;
     
        Bitstream_lenght_reg <= 32'h0000;
		  FCB_status_reg <= 32'h0000;
      
    end else begin
        if (wb_stb & wb_we & wb_bus_cycle) begin
            case (wb_address)
                3'b000: begin
               
                    if (wb_select[0]) FCB_control_reg[7:0] <= wb_data_in[7:0];
                    if (wb_select[1]) FCB_control_reg[15:8] <= wb_data_in[15:8];
                    if (wb_select[2]) FCB_control_reg[23:16] <= wb_data_in[23:16];
                    if (wb_select[3]) FCB_control_reg[31:24] <= wb_data_in[31:24];
                end
                3'b001: begin
                    
                    if (wb_select[0]) Bitstream_write_reg[7:0] <= wb_data_in[7:0];
                    if (wb_select[1]) Bitstream_write_reg[15:8] <= wb_data_in[15:8];
                    if (wb_select[2]) Bitstream_write_reg[23:16] <= wb_data_in[23:16];
                    if (wb_select[3]) Bitstream_write_reg[31:24] <= wb_data_in[31:24];
                end
                     3'b010: begin
                    if (wb_select[0]) Bitstream_lenght_reg[7:0] <= wb_data_in[7:0];
                    if (wb_select[1]) Bitstream_lenght_reg[15:8] <= wb_data_in[15:8];
                    if (wb_select[2]) Bitstream_lenght_reg[23:16] <= wb_data_in[23:16];
                    if (wb_select[3]) Bitstream_lenght_reg[31:24] <= wb_data_in[31:24];
                end
                     3'b011: begin
                    if (wb_select[0]) Bitstream_checksum_reg[7:0]   <= wb_data_in[7:0];
                    if (wb_select[1]) Bitstream_checksum_reg[15:8]  <= wb_data_in[15:8];
                    if (wb_select[2]) Bitstream_checksum_reg[23:16] <= wb_data_in[23:16];
                    if (wb_select[3]) Bitstream_checksum_reg[31:24] <= wb_data_in[31:24];
                end
            endcase
        end
          
          end 
  FCB_status_reg [0] <= word_complt;
  FCB_status_reg [1] <= bitstream_complt;
  FCB_status_reg [2] <= checksum_match ;
  FCB_status_reg [3] <= checksum_nmatch;  
    

end
always @ (*) begin
           if (wb_stb & !wb_we ) begin
            case (wb_address)
                3'b000: wb_data_out <= FCB_control_reg;
                3'b001: wb_data_out <= Bitstream_write_reg;
                3'b010: wb_data_out <= Bitstream_lenght_reg;
                3'b011: wb_data_out <= Bitstream_checksum_reg;
                3'b100: wb_data_out <= FCB_status_reg;
                3'b101: wb_data_out <= Bitstream_read_reg;
            endcase
          end

end
always @(clk) begin //look again
        if(clkflag && count_value_write<32 && bitstream_count != 0 ) prog_clk = clk;
        else prog_clk = 0;    
end

localparam IDLE = 0;
localparam WAIT = 1;
localparam TRANSMIT = 2;
localparam STOP = 3;
localparam READ = 4;
localparam CHK = 5;

reg [31:0] temp;


always @(negedge clk or negedge reset)
begin
    case(state)
    TRANSMIT:
            fpga_head = temp[31];
    READ:
            fpga_head = fpga_tail;
endcase
end

always @(negedge clk or negedge reset)
begin
	if (!reset) begin
    fpga_head = 1;  	
		state <= IDLE;
		bitstream_count <=0;
		word_complt <= 0;
		bitstream_complt <= 0;
		count_value_write <= 0;
        checksum_match <= 0;
        checksum_nmatch <=0;
        Bitstream_read_reg <= 32'h0000;
        checksum_counter <= 4'hf;
        regA = 1;
        regB =0;
        post_checksum_reg = 0;
        addler_flag <= 0;
	end
    case (state)
        IDLE:
        begin
           // clkflag <= 0;
            bitstream_count <= 0;
            if(!bitstream_complt && FCB_control_reg[0] == 1) state <= WAIT;
          else if(FCB_control_reg[0] && FCB_control_reg[1]) state <= IDLE;
          else if(FCB_control_reg[1]) begin 
            count_value_write <= 0;
            checksum_match <= 0;
            checksum_nmatch <=0;
            bitstream_complt <= 0;
            bitstream_count <=0;
            Bitstream_read_reg <= 32'h0000;
            state <= READ;
            checksum_counter <= 4'hf;
          end
            else state <= IDLE;
        end
        WAIT:
        begin
          if (wb_we && wb_address == 3'b001) begin 
                state <= TRANSMIT;
                programming_reset <= 0;
                if (wb_select[0]) temp[7:0] <= wb_data_in[7:0];
                if (wb_select[1]) temp[15:8] <= wb_data_in[15:8];
                if (wb_select[2]) temp[23:16] <= wb_data_in[23:16];
                if (wb_select[3]) temp[31:24] <= wb_data_in[31:24];
                count_value_write <= 0;
                word_complt <= 0;
            end
            else if  (FCB_control_reg[0] == 0) state <= IDLE;
            else state <= WAIT;
        end
        TRANSMIT:
        begin
            temp <= temp << 1;
          if(count_value_write != 32)
           begin
            count_value_write <= count_value_write + 1;
            bitstream_count <= bitstream_count + 1;
           end
            if(bitstream_count == Bitstream_lenght_reg) begin
                bitstream_complt <= 1;
                state <= STOP;
            end

            else if (count_value_write < 32)   state <= TRANSMIT;
            else begin
                word_complt <= 1;
                state <= WAIT;
            end
        end
    	STOP:
          begin
            if (FCB_control_reg[0] == 0 && FCB_control_reg[1] == 0) state <= IDLE;
            else if (FCB_control_reg[1] == 1) 
              begin
                if (post_checksum_reg == Bitstream_checksum_reg) checksum_match <= 1;
                else checksum_nmatch <= 1;

              end
            else state <= STOP;
            
          end
      	READ:
          begin
            Bitstream_read_reg <= {Bitstream_read_reg[30:0], fpga_tail};
            checksum_counter <= checksum_counter + 1;
            if(checksum_counter == 7)
              begin
               checksum_counter <= 0;
               addler_flag <= 1;
              end
             else  addler_flag <= 0;
            if(addler_flag)
              begin
                regA <= (regA + addler_data[7:0]) % 65521;
                regB <= (((regA + addler_data[7:0]) % 65521) + regB) % 65521;
                 
            end
           // post_checksum_reg <= post_checksum_reg + fpga_tail;
            bitstream_count <= bitstream_count + 1;
            if (bitstream_count == Bitstream_lenght_reg ) begin
              if(!addler_flag)
                begin
                regA <= (regA + addler_data[7:0]) % 65521;
                regB <= (((regA + addler_data[7:0]) % 65521) + regB) % 65521;
                end
              state <= CHK;
            end
          end
      CHK:begin
        post_checksum_reg <= (regB  << 16) + regA;
        state <= STOP;
      end
    endcase 

end
  

  always @(*) begin
    if (!reset)begin
     

     bitmask = 0;
    end
    if(state == TRANSMIT)
    begin
        if(bitstream_count == Bitstream_lenght_reg) clkflag = 0;
      else if (count_value_write < 32) begin 
        clkflag = 1;
        
      end
    end
    else if (state == READ) begin 
      clkflag = 1;
      if (bitstream_count == Bitstream_lenght_reg | addler_flag) begin
        addler_data = Bitstream_read_reg[7:0];
        case (checksum_counter)
          4'b0000: bitmask = 8'h00;
          4'b0001: bitmask = 8'h01;
          4'b0010: bitmask = 8'h03;
          4'b0011: bitmask = 8'h07;
          4'b0100: bitmask = 8'h0f;
          4'b0101: bitmask = 8'h1f;
          4'b0110: bitmask = 8'h3f;
          4'b0111: bitmask = 8'h7f;
          default: bitmask = 8'h00;
        endcase
        if (!addler_flag)
        addler_data = addler_data & bitmask;
        else
        addler_data = addler_data;
   
      end

    end
    else clkflag = 0;
end
endmodule