module BussMux2x1 (
	A, 
	B,
	sel,
	Out
	);

input [31:0] A;
input [31:0] B;
input sel;
output [31:0] Out ;
assign Out = sel?(B):(A);
endmodule