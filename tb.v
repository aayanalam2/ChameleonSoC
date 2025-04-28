`default_nettype none
`timescale 1ns/1ps

module tb();
    // RISC-V processor signals
    reg clk;
    reg rst;
    wire [15:0] test;
    
    // FPGA signals
    wire [0:0] pReset;
    wire [0:0] prog_clk;
    wire [0:0] set;
    wire [0:0] reset;
    wire [0:7] gfpga_pad_GPIO_PAD;
    wire [0:0] ccff_head;
    wire [0:0] ccff_tail;
    
    // Input/output signals for OR2 gate
    reg [0:0] a;
    reg [0:0] b;
    wire [0:0] c;
    
    // Reset signals
    reg [0:0] __prog_reset__;
    reg [0:0] __set__;
    reg [0:0] __greset__;
    
    // Bit counter
    integer bit_counter = 0;
    
    // Force output to 0 at time 0 for visualization
    initial begin
        force gfpga_pad_GPIO_PAD[3] = 1'b0;
        #1;
        release gfpga_pad_GPIO_PAD[3];
    end
    
    // Time-zero initialization
    initial begin
        // Initialize variables
        __prog_reset__ = 1'b1;
        __set__ = 1'b0;
        __greset__ = 1'b1;
        a = 1'b0;
        b = 1'b0;
        
        // Programming reset sequence
        #4 __prog_reset__ = 1'b0;
        
        // Wait for configuration to complete
        wait(instan.FabricB.bitstream_complt == 1'b1);
        
        // Print configuration summary
        $display("\n=== CONFIGURATION SUMMARY ===");
        $display("Total bits shifted: %0d", bit_counter);
        $display("=== END CONFIGURATION SUMMARY ===\n");
        
        // Global reset sequence after configuration
        #2 __greset__ = 1'b1;
        #4 __greset__ = 1'b0;
        
        // Test sequence
        #10;
        a = 1'b0; b = 1'b0;
        #10;
        $display("@%0t: TEST A=0 B=0 → Y=%b", $time, c);
        
        a = 1'b1; b = 1'b0;
        #10;
        $display("@%0t: TEST A=1 B=0 → Y=%b", $time, c);
        
        a = 1'b0; b = 1'b1;
        #10;
        $display("@%0t: TEST A=0 B=1 → Y=%b", $time, c);
        
        a = 1'b1; b = 1'b1;
        #10;
        $display("@%0t: TEST A=1 B=1 → Y=%b", $time, c);
        
        #20;
        $display("Test completed");
        $finish;
    end
    
    // Count bits on programming clock
    always @(posedge prog_clk) begin
        bit_counter = bit_counter + 1;
    end
    
    // Clock generation
    initial begin
        clk = 1'b0;
        forever begin
            #1.666666746 clk = ~clk;
        end
    end
    
    // Reset for RISC-V
    initial begin
        rst = 1'b0;
        #3 rst = 1'b1;
    end
    
    // Connect signals
    assign pReset[0] = __prog_reset__;
    assign set[0] = __set__;
    assign reset[0] = __greset__;
    assign gfpga_pad_GPIO_PAD[7] = a[0];
    assign gfpga_pad_GPIO_PAD[6] = b[0];
    assign c[0] = gfpga_pad_GPIO_PAD[3];
    assign gfpga_pad_GPIO_PAD[0] = 1'b0;
    assign gfpga_pad_GPIO_PAD[1] = 1'b0;
    assign gfpga_pad_GPIO_PAD[2] = 1'b0;
    assign gfpga_pad_GPIO_PAD[4] = 1'b0;
    assign gfpga_pad_GPIO_PAD[5] = 1'b0;
    
    // RISC-V processor instantiation
    RISCV instan(
        clk,
        test,
        rst,
        ccff_head,
        ccff_tail,
        prog_clk,
        instan.FabricB.op_clk,
        reset
    );
    
    // FPGA top-level instantiation
    fpga_top fabric(
        pReset[0],
        prog_clk[0],
        set[0],
        reset[0],
        instan.FabricB.op_clk,
        gfpga_pad_GPIO_PAD[0:7],
        ccff_head,
        ccff_tail
    );
    
    // Waveform dumping
    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, tb);
    end
    
    // File for raw bit dump
    integer file;
    initial begin
        file = $fopen("fcb_bitstream.bit", "w");
        if (file == 0) begin
            $display("Error opening file!");
            $finish;
        end
    end
    
    // Write raw bits to file - no text, just the bit value
    always @(posedge prog_clk) begin
        $fwrite(file, "%b\n", ccff_head);
    end
    
    // Close file
    initial begin
        #1000000;
        $fclose(file);
    end
endmodule