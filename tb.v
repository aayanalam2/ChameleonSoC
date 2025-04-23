`default_nettype none
`timescale  1ns/1ps
module tb();
	reg clk;
	reg rst;
	wire[15:0] test;
	wire [7:0] GPIO;
	reg a;
	reg b;
	wire c;
	wire pReset;
	reg set;
	reg r_pReset;
	reg r_set;
	initial begin
	 set = 0;
	end
	wire head;
	wire programming_clock;
	RISCV instan(clk,test,rst,GPIO, set, head, programming_clock);
		assign GPIO[7] = a;
	assign GPIO[6] = b;
	assign c = GPIO[3];
		assign GPIO[0] = 1'b0;
	assign GPIO[1] = 1'b0;
	assign GPIO[2] = 1'b0;
	assign GPIO[4] = 1'b0;
	assign GPIO[5] = 1'b0;
	initial begin
	clk = 0;
	forever begin
	#1.666666746
	clk = ~clk;
	end
	end
	initial begin
	#6811.3;
	a = 0;
	b = 1;
	#1;
	a = 1;
	b = 0;
	#1;
	a = 0;
	b = 0;
	#1;
	a = 1;
	b = 1;
	end
	initial begin
	rst = 0;
	a = 1;
	b = 0;
	#3;
	rst = 1;
	a = 0;
	b = 1;
	#20000;
		a = 0;
			b = 0;
			#10;
			a = 1;
			b = 0;
			#10;
			a = 0;
			b = 1;
			#10;
			a = 1;
			b = 1;
			#10;
	$stop;
	$finish;
	end
initial begin 
$dumpfile("waves.vcd");
$dumpvars(0);
end
    // File to store output of head at each negedge of programming_clock
    integer file;
    
    // Open file at the start of simulation
    initial begin
        file = $fopen("head_output.txt", "w");
        if (file == 0) begin
            $display("Error opening file!");
            $finish;
        end
    end

    // Write head value to file at each negedge of programming_clock
    always @(negedge programming_clock) begin
        $fwrite(file, "%b\n", head);
    end

    // Close the file at the end of simulation
    initial begin
        #1000000;  // Adjust time to ensure simulation ends
        $fclose(file);
    end

endmodule
