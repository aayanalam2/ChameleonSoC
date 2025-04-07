module FabricControlBlock (
    input clk,
    input reset,
    
    input [2:0] wb_address,
    input [31:0] wb_data_in,
    input [3:0] wb_select,
    input wb_stb,
    input wb_we,
    input wb_bus_cycle,
    output reg [31:0] wb_data_out,
    output wb_ack,

    input fpga_tail,
    output reg prog_clk,
    output reg fpga_head
);

reg [31:0] FCB_control_reg;
reg [31:0] FCB_status_reg;
reg [31:0] Bitstream_write_reg;
reg [31:0] Bitstream_read_reg;
reg [31:0] Bitstream_lenght_reg;
reg [31:0] Bitstream_checksum_reg;

  
reg [31:0] Bitstream_write_reg_shift;
reg [31:0] Bitstream_read_reg_shift;

  
reg [4:0] count_value_write;
reg [4:0] count_value_read;
reg [31:0] bitstream_count;
  
reg bitstream_write_req ;
reg bitstream_read_req;
reg valid;

reg word_complt, bitstream_complt;

reg bitstream_read_pending;
reg bitstream_read_ack;
 
reg [31:0] pre_checksum_reg;
reg [31:0] post_checksum_reg;
reg pre_check_match;
reg post_check_match;
reg chksum_status;
reg pre_chksum;
reg post_chksum;


assign wb_ack = wb_stb & wb_bus_cycle;


always @(posedge clk or negedge reset) begin
    if (!reset) begin
        FCB_control_reg <= 32'h0000;
        Bitstream_write_reg <= 32'h0000;
        Bitstream_lenght_reg <= 32'h0000;
       // Bitstream_checksum_reg <= 32'h0000;
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
		  
		  else if (wb_stb & !wb_we ) begin
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
end

reg [3:0] state;
localparam IDLE = 0;
localparam Writing = 1;
localparam Reading = 2;
localparam WordComplete = 3;
localparam BitstreamComplete = 4;
localparam Reset = 5;
	always @(posedge clk)
	begin
		if(!reset) state <= reset;
		case(state)
		
		
		endcase
	
	end
endmodule






