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
    output op_clk
);

reg [31:0] FCB_control_reg;
reg [31:0] FCB_status_reg;
reg [31:0] Bitstream_write_reg;
reg [31:0] Bitstream_read_reg;
reg [31:0] Bitstream_lenght_reg;
reg [31:0] Bitstream_checksum_reg;

reg [5:0] count_value_write;
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
  
reg [3:0] checksum_counter;
reg [15:0] regA;
reg [15:0] regB;
reg [7:0] addler_data;
reg [7:0] bitmask;
reg addler_flag;
reg first_bit; // Flag to track if we're processing the first bit
  
assign op_clk = bitstream_complt & clk;
assign gReset = ~bitstream_complt;

// Initialize outputs to avoid X
initial begin
    fpga_head = 1'b0;
    prog_clk = 1'b0;
    first_bit = 1'b1;
end

always @(posedge clk or negedge reset) begin
    if (!reset) begin
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
    FCB_status_reg[0] <= word_complt;
    FCB_status_reg[1] <= bitstream_complt;
    FCB_status_reg[2] <= checksum_match;
    FCB_status_reg[3] <= checksum_nmatch;
end

always @ (*) begin
    if (wb_stb & !wb_we) begin
        case (wb_address)
            3'b000: wb_data_out = FCB_control_reg;
            3'b001: wb_data_out = Bitstream_write_reg;
            3'b010: wb_data_out = Bitstream_lenght_reg;
            3'b011: wb_data_out = Bitstream_checksum_reg;
            3'b100: wb_data_out = FCB_status_reg;
            3'b101: wb_data_out = Bitstream_read_reg;
            default: wb_data_out = 32'h0000;
        endcase
    end
    else begin
        wb_data_out = 32'h0000;
    end
end

// Generate prog_clk only when actively transmitting bits
always @(clk) begin
    if (clkflag && (state == TRANSMIT) && !first_bit) // Don't enable clock for first bit 
        prog_clk = clk;
    else 
        prog_clk = 0;    
end

localparam IDLE = 0;
localparam WAIT = 1;
localparam TRANSMIT = 2;
localparam STOP = 3;
localparam READ = 4;
localparam CHK = 5;

reg [31:0] temp;

always @(negedge clk or negedge reset) begin
    if (!reset) begin
        fpga_head <= 1'b0;
        state <= IDLE;
        bitstream_count <= 0;
        word_complt <= 0;
        bitstream_complt <= 0;
        count_value_write <= 0;
        checksum_match <= 0;
        checksum_nmatch <= 0;
        Bitstream_read_reg <= 32'h0000;
        checksum_counter <= 4'hf;
        regA <= 16'h0001;
        regB <= 16'h0000;
        post_checksum_reg <= 0;
        addler_flag <= 0;
        temp <= 32'h0000;
        first_bit <= 1'b1;
    end else begin
        case (state)
            IDLE: begin
                fpga_head <= 1'b0;
                bitstream_count <= 0;
                count_value_write <= 0;
                word_complt <= 0;
                first_bit <= 1'b1;
                
                if (!bitstream_complt && FCB_control_reg[0] == 1) begin
                    state <= WAIT;
                end
                else if (FCB_control_reg[0] && FCB_control_reg[1]) begin
                    state <= IDLE;
                end
                else if (FCB_control_reg[1]) begin 
                    count_value_write <= 0;
                    checksum_match <= 0;
                    checksum_nmatch <= 0;
                    bitstream_complt <= 0;
                    bitstream_count <= 0;
                    Bitstream_read_reg <= 32'h0000;
                    state <= READ;
                    checksum_counter <= 4'hf;
                end
                else begin
                    state <= IDLE;
                end
            end
            
            WAIT: begin
                fpga_head <= 1'b0;
                
                if (wb_stb & wb_we & wb_bus_cycle & wb_address == 3'b001) begin
                    // Use Bitstream_write_reg which may have already been loaded
                    if (wb_select == 4'b1111) begin  // Full word write
                        temp <= wb_data_in;
                    end else begin
                        // Selective bytes - start with existing register value
                        temp <= Bitstream_write_reg;
                        if (wb_select[0]) temp[7:0] <= wb_data_in[7:0];
                        if (wb_select[1]) temp[15:8] <= wb_data_in[15:8];
                        if (wb_select[2]) temp[23:16] <= wb_data_in[23:16];
                        if (wb_select[3]) temp[31:24] <= wb_data_in[31:24];
                    end
                    
                    count_value_write <= 0;
                    word_complt <= 0;
                    state <= TRANSMIT;
                end
                else if (FCB_control_reg[0] == 0) begin
                    state <= IDLE;
                end
                else begin
                    state <= WAIT;
                end
            end
            
            TRANSMIT: begin
                // First check if we should stop transmission (ensuring we send exactly bitstream_lenght_reg bits)
                if (bitstream_count >= Bitstream_lenght_reg) begin
                    bitstream_complt <= 1;
                    state <= STOP;
                end
                else begin
                    // Output the current bit and shift
                    if (first_bit) begin
                        // Skip the extra zero bit at the start
                        first_bit <= 1'b0;
                        // Don't increment bit counter for the skipped bit
                    end
                    else begin
                        // Normal bit transmission
                        fpga_head <= temp[31];
                        bitstream_count <= bitstream_count + 1;
                    end
                    
                    // Always shift and increment count_value_write
                    temp <= {temp[30:0], 1'b0};
                    count_value_write <= count_value_write + 1;
                    
                    // Check if we've reached the bitstream length
                    if (!first_bit && (bitstream_count + 1 == Bitstream_lenght_reg)) begin
                        // We're sending the last bit now
                        bitstream_complt <= 1;
                        state <= STOP;
                    end
                    // Check if we've sent all bits in this word
                    else if (count_value_write == 30) begin
                        // We're sending the 31st bit (0-indexed)
                        word_complt <= 1;
                    end
                    else if (count_value_write == 31) begin
                        // We've sent all 32 bits, go back to WAIT for the next word
                        state <= WAIT;
                    end
                end
            end
            
            STOP: begin
                fpga_head <= 1'b0;
                
                if (FCB_control_reg[0] == 0 && FCB_control_reg[1] == 0) begin
                    state <= IDLE;
                end
                else if (FCB_control_reg[1] == 1) begin
                    if (post_checksum_reg == Bitstream_checksum_reg) begin
                        checksum_match <= 1;
                    end
                    else begin
                        checksum_nmatch <= 1;
                    end
                end
                else begin
                    state <= STOP;
                end
            end
            
            READ: begin
                fpga_head <= fpga_tail;
                Bitstream_read_reg <= {Bitstream_read_reg[30:0], fpga_tail};
                checksum_counter <= checksum_counter + 1;
                
                if (checksum_counter == 7) begin
                    checksum_counter <= 0;
                    addler_flag <= 1;
                end
                else begin
                    addler_flag <= 0;
                end
                
                if (addler_flag) begin
                    regA <= (regA + addler_data[7:0]) % 65521;
                    regB <= (((regA + addler_data[7:0]) % 65521) + regB) % 65521;
                end
                
                bitstream_count <= bitstream_count + 1;
                if (bitstream_count == Bitstream_lenght_reg) begin
                    if (!addler_flag) begin
                        regA <= (regA + addler_data[7:0]) % 65521;
                        regB <= (((regA + addler_data[7:0]) % 65521) + regB) % 65521;
                    end
                    state <= CHK;
                end
            end
            
            CHK: begin
                post_checksum_reg <= (regB << 16) + regA;
                state <= STOP;
            end
        endcase
    end
end
  
always @(*) begin
    if (!reset) begin
        bitmask = 8'h00;
        clkflag = 0;
    end
    
    if (state == TRANSMIT) begin
        clkflag = 1;
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
            if (!addler_flag) begin
                addler_data = addler_data & bitmask;
            end
        end
    end
    else begin
        clkflag = 0;
    end
end
endmodule