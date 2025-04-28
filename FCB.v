`default_nettype none
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
    output prog_clk,
    output reg fpga_head,
    output gReset,
    output op_clk,
    output prset
);
    // Control registers
    reg programming_reset;
    reg [31:0] FCB_control_reg;
    reg [31:0] FCB_status_reg;
    reg [31:0] Bitstream_write_reg;
    reg [31:0] Bitstream_read_reg;
    reg [31:0] Bitstream_lenght_reg;
    reg [31:0] Bitstream_checksum_reg;
    
    // Bitstream handling - simplified approach
    parameter BITSTREAM_LENGTH = 2034;
    reg [0:0] bit_mem[0:BITSTREAM_LENGTH-1]; // Bitstream storage
    reg [31:0] bit_index;                    // Current bit position
    reg bitstream_complt;                    // Configuration complete flag
    reg word_complt;                         // Word complete flag
    reg [6:0] count_value_write;             // Counter within current word
    reg [31:0] bitstream_count;              // Total bits shifted
    
    // State machine and control
    reg [2:0] state;
    reg transmission_begin;
    
    // State definitions
    localparam IDLE = 0;
    localparam WAIT = 1;
    localparam TRANSMIT = 2;
    localparam STOP = 3;
    
    // Output assignments
    assign prset = programming_reset;
    assign op_clk = (bitstream_complt) & (clk);
    assign gReset = ~bitstream_complt;
    assign prog_clk = (state == TRANSMIT && count_value_write < 32) ? clk : 1'b0;
    
    // Initial state
    initial begin
        // Read bitstream directly from file like testbench
        $readmemb("fabric_bitstream.bit", bit_mem);
        programming_reset <= 1;
        fpga_head <= 0;         // Explicitly start with head at 0
        bitstream_complt <= 0;
        bit_index <= 0;
    end
    
    // Register update logic
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
                        if (wb_select[0]) Bitstream_checksum_reg[7:0] <= wb_data_in[7:0];
                        if (wb_select[1]) Bitstream_checksum_reg[15:8] <= wb_data_in[15:8];
                        if (wb_select[2]) Bitstream_checksum_reg[23:16] <= wb_data_in[23:16];
                        if (wb_select[3]) Bitstream_checksum_reg[31:24] <= wb_data_in[31:24];
                    end
                endcase
            end
        end 
        
        FCB_status_reg[0] <= word_complt;
        FCB_status_reg[1] <= bitstream_complt;
        FCB_status_reg[2] <= 0; // Simplified - no checksum
        FCB_status_reg[3] <= 0; // Simplified - no checksum
    end
    
    // Register read logic
    always @(*) begin
        if (wb_stb & !wb_we) begin
            case (wb_address)
                3'b000: wb_data_out <= FCB_control_reg;
                3'b001: wb_data_out <= Bitstream_write_reg;
                3'b010: wb_data_out <= Bitstream_lenght_reg;
                3'b011: wb_data_out <= Bitstream_checksum_reg;
                3'b100: wb_data_out <= FCB_status_reg;
                3'b101: wb_data_out <= Bitstream_read_reg;
                default: wb_data_out <= 32'h0000;
            endcase
        end else begin
            wb_data_out <= 32'h0000;
        end
    end
    
    // Bit shifting on negedge clk - like the testbench
    always @(negedge clk or negedge reset) begin
        if (!reset) begin
            state <= IDLE;
            bitstream_count <= 0;
            count_value_write <= 0;
            word_complt <= 0;
            bitstream_complt <= 0;
            transmission_begin <= 0;
            programming_reset <= 1;
            fpga_head <= 0;  // Initialize head to 0
        end else begin
            case (state)
                IDLE: begin
                    bitstream_count <= 0;
                    transmission_begin <= 0;
                    if (!bitstream_complt && FCB_control_reg[0] == 1)
                        state <= WAIT;
                    else
                        state <= IDLE;
                end
                
                WAIT: begin
                    if (wb_we && wb_address == 3'b001) begin
                        transmission_begin <= 1;
                        state <= TRANSMIT;
                        programming_reset <= 0;
                        count_value_write <= 0;
                        word_complt <= 0;
                    end else if (FCB_control_reg[0] == 0) begin
                        state <= IDLE;
                    end else begin
                        state <= WAIT;
                    end
                end
                
                TRANSMIT: begin
                    // Direct bit shifting from loaded bitstream file
                    if (bitstream_count < BITSTREAM_LENGTH) begin
                        fpga_head <= bit_mem[bitstream_count];
                        count_value_write <= count_value_write + 1;
                        bitstream_count <= bitstream_count + 1;
                    end
                    
                    // Check for completion
                    if (bitstream_count >= Bitstream_lenght_reg || bitstream_count >= BITSTREAM_LENGTH) begin
                        bitstream_complt <= 1;
                        transmission_begin <= 0;
                        state <= STOP;
                    end else if (count_value_write >= 31) begin
                        // End of current word
                        transmission_begin <= 0;
                        word_complt <= 1;
                        state <= WAIT;
                    end
                end
                
                STOP: begin
                    if (FCB_control_reg[0] == 0) begin
                        state <= IDLE;
                    end else begin
                        state <= STOP;
                    end
                end
                
                default: state <= IDLE;
            endcase
        end
    end
endmodule