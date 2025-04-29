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
    wire [0:95] gfpga_pad_GPIO_PAD;
    wire [0:0] ccff_head;
    wire [0:0] ccff_tail;
    
    // UART Receiver signals
    wire [0:0] i_clk;          // UART clock
    reg [0:0] i_rst;           // UART reset
    reg [0:0] r_DATA_SER;      // Serial data input
    
    // UART Receiver outputs
    wire [0:0] recv_DATA_0;    // Received data bit 0
    wire [0:0] recv_DATA_1;    // Received data bit 1
    wire [0:0] recv_DATA_2;    // Received data bit 2
    wire [0:0] recv_DATA_3;    // Received data bit 3
    wire [0:0] t_DATA_SER;     // Transmit data serial
    wire [0:0] rec_done;       // Receive done flag
    wire [0:0] t_done;         // Transmit done flag
    
    // Reset signals
    reg [0:0] __prog_reset__;
    reg [0:0] __set__;
    reg [0:0] __greset__;
    
    // Monitoring variables
    integer bit_counter = 0;
    integer test_counter = 0;
    integer pass_counter = 0;
    integer fail_counter = 0;
    
    // Create clock for UART and connect to FPGA
    assign i_clk = instan.FabricB.op_clk;
    
    // Force initial output state to avoid X propagation
    initial begin
        force gfpga_pad_GPIO_PAD[14] = 1'b0; // recv_DATA_0
        force gfpga_pad_GPIO_PAD[12] = 1'b0; // recv_DATA_1
        force gfpga_pad_GPIO_PAD[8] = 1'b0;  // recv_DATA_2
        force gfpga_pad_GPIO_PAD[10] = 1'b0; // recv_DATA_3
        force gfpga_pad_GPIO_PAD[13] = 1'b0; // rec_done
        force gfpga_pad_GPIO_PAD[66] = 1'b0; // t_DATA_SER
        force gfpga_pad_GPIO_PAD[67] = 1'b0; // t_done
        #1;
        release gfpga_pad_GPIO_PAD[14];
        release gfpga_pad_GPIO_PAD[12];
        release gfpga_pad_GPIO_PAD[8];
        release gfpga_pad_GPIO_PAD[10];
        release gfpga_pad_GPIO_PAD[13];
        release gfpga_pad_GPIO_PAD[66];
        release gfpga_pad_GPIO_PAD[67];
    end
    
    // Time-zero initialization
    initial begin
        // Initialize variables
        __prog_reset__ = 1'b1;  // Start with prog_reset active
        __set__ = 1'b0;         // Start with set signal inactive
        __greset__ = 1'b1;      // Start with global reset active
        i_rst = 1'b0;           // Initialize UART reset
        r_DATA_SER = 1'b1;      // Initialize serial data line idle high
        
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
        
        // UART reset sequence
        i_rst = 1'b1;   // Assert UART reset
        #10;
        i_rst = 1'b0;   // Deassert UART reset
        #10;
        
        // Begin UART testing
        $display("\n=== UART RECEIVER TESTS ===");
        
        // Test 1: Send byte 0xA (binary 1010)
        send_uart_byte(4'b1010);
        
        // Test 2: Send byte 0x5 (binary 0101)
        send_uart_byte(4'b0101);
        
        // Test 3: Send byte 0xF (binary 1111)
        send_uart_byte(4'b1111);
        
        // Test 4: Send byte 0x0 (binary 0000)
        send_uart_byte(4'b0000);
        
        // Print test results
        $display("\n=== TEST RESULTS ===");
        $display("Total tests:   %0d", test_counter);
        $display("Passed tests:  %0d", pass_counter);
        $display("Failed tests:  %0d", fail_counter);
        if (fail_counter == 0)
            $display("OVERALL: PASS - All tests passed!\n");
        else
            $display("OVERALL: FAIL - %0d tests failed!\n", fail_counter);
        
        $display("Test completed");
        $finish;
    end
    
    // Task to send a UART byte (4 bits with start and stop bits)
    task send_uart_byte;
        input [3:0] data;
        
        integer i;
        reg [3:0] expected_data;
        begin
            test_counter = test_counter + 1;
            expected_data = data;
            
            $display("\nTest %0d: Sending UART data: %b", test_counter, data);
            
            // Start bit (low)
            r_DATA_SER = 1'b0;
            #16000; // Wait for 16 clock cycles (assuming baud rate is clk/16)
            
            // Send 4 data bits LSB first
            for (i = 0; i < 4; i = i + 1) begin
                r_DATA_SER = data[i];
                #16000; // Wait for 16 clock cycles
            end
            
            // Stop bit (high)
            r_DATA_SER = 1'b1;
            #16000; // Wait for 16 clock cycles
            
            // Wait for receive done signal
            wait(rec_done == 1'b1);
            #1000; // Additional wait to allow signals to stabilize
            
            // Verify received data
            verify_uart_data(expected_data);
        end
    endtask
    
    // Task to verify received UART data
    task verify_uart_data;
        input [3:0] expected;
        
        begin
            // Check if received data matches expected data
            if ({recv_DATA_3, recv_DATA_2, recv_DATA_1, recv_DATA_0} === expected) begin
                $display("Test %0d: Received data: %b%b%b%b (expected %b) - PASS", 
                         test_counter, recv_DATA_3, recv_DATA_2, recv_DATA_1, recv_DATA_0, expected);
                pass_counter = pass_counter + 1;
            end
            else begin
                $display("Test %0d: Received data: %b%b%b%b (expected %b) - FAIL", 
                         test_counter, recv_DATA_3, recv_DATA_2, recv_DATA_1, recv_DATA_0, expected);
                fail_counter = fail_counter + 1;
            end
        end
    endtask
    
    // Count bits on programming clock
    always @(posedge prog_clk) begin
        bit_counter = bit_counter + 1;
    end
    
    // Clock generation for RISC-V core
    initial begin
        clk = 1'b0;
        forever begin
            #1.666666746 clk = ~clk;
        end
    end
    
    // Reset for RISC-V processor
    initial begin
        rst = 1'b0;
        #3 rst = 1'b1;
    end
    
    // Connect reset signals to FPGA
    assign pReset[0] = __prog_reset__;
    assign set[0] = __set__;
    assign reset[0] = __greset__;
    
    // Connect UART signals to FPGA GPIO pads
    assign gfpga_pad_GPIO_PAD[9] = i_clk;            // UART clock
    assign gfpga_pad_GPIO_PAD[17] = i_rst;           // UART reset
    assign gfpga_pad_GPIO_PAD[61] = r_DATA_SER;      // Serial data input
    
    // Get UART outputs from FPGA GPIO pads
    assign recv_DATA_0 = gfpga_pad_GPIO_PAD[14];     // Received data bit 0
    assign recv_DATA_1 = gfpga_pad_GPIO_PAD[12];     // Received data bit 1
    assign recv_DATA_2 = gfpga_pad_GPIO_PAD[8];      // Received data bit 2
    assign recv_DATA_3 = gfpga_pad_GPIO_PAD[10];     // Received data bit 3
    assign t_DATA_SER = gfpga_pad_GPIO_PAD[66];      // Transmit data serial
    assign rec_done = gfpga_pad_GPIO_PAD[13];        // Receive done flag
    assign t_done = gfpga_pad_GPIO_PAD[67];          // Transmit done flag
    
    // Initialize all unused GPIO pads to 0
    genvar gpio_idx;
    generate
        for (gpio_idx = 0; gpio_idx < 96; gpio_idx = gpio_idx + 1) begin: gpio_init
            if (gpio_idx != 9 && gpio_idx != 17 && gpio_idx != 61 && 
                gpio_idx != 14 && gpio_idx != 12 && gpio_idx != 8 && 
                gpio_idx != 10 && gpio_idx != 66 && gpio_idx != 13 && 
                gpio_idx != 67) begin
                assign gfpga_pad_GPIO_PAD[gpio_idx] = 1'b0;
            end
        end
    endgenerate
    
    // RISC-V processor instantiation
    RISCV instan(
        clk,                      // Input clock to RISC-V
        test,                     // Output test signals 
        rst,                      // RISC-V reset
        ccff_head,                // Configuration chain head
        ccff_tail,                // Configuration chain tail
        prog_clk,                 // Programming clock (generated by FCB)
        instan.FabricB.op_clk,    // Operating clock (generated by FCB)
        reset                     // Global reset signal
    );
    
    // FPGA top-level instantiation
    fpga_top fabric(
        pReset[0],                // Programming reset
        prog_clk[0],              // Programming clock
        set[0],                   // Set signal
        reset[0],                 // Global reset
        instan.FabricB.op_clk,    // Operating clock
        gfpga_pad_GPIO_PAD[0:95], // GPIO pins - now with 96 pads
        ccff_head,                // Configuration chain head
        ccff_tail                 // Configuration chain tail
    );
    
    // Waveform dumping
    initial begin
        $dumpfile("uart_receiver_test.vcd");
        $dumpvars(0, tb);
        
        // Explicitly dump important UART signals
        $dumpvars(0, i_clk);
        $dumpvars(0, i_rst);
        $dumpvars(0, r_DATA_SER);
        $dumpvars(0, recv_DATA_0);
        $dumpvars(0, recv_DATA_1);
        $dumpvars(0, recv_DATA_2);
        $dumpvars(0, recv_DATA_3);
        $dumpvars(0, rec_done);
        $dumpvars(0, t_DATA_SER);
        $dumpvars(0, t_done);
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