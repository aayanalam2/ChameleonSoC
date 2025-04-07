module tb();
	reg clk;
	reg rst;
	wire[15:0] test;
	wire [7:0] GPIO;
	reg a;
	reg b;
	wire c;
	wire pReset;
	wire set;
	reg r_pReset;
	reg r_set;
	initial begin
		r_set = 1'b0;
	end
initial
	begin
		r_pReset = 1'b1;
	#3.333333492	r_pReset = 1'b0;
	end
	assign pReset = r_pReset;
	assign set = r_set;
	RISCV instan(clk,test,rst,GPIO, pReset, set);
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
	#2
	clk = ~clk;
	end
	end
	initial begin
	rst = 0;
	#3;
	rst = 1;
	a = 1;
	b = 0;
	#400000;
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
endmodule
