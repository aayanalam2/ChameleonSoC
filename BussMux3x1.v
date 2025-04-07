module BussMux3x1 (
	A, 
	B,
	C,
	sel,
	Out
	);

input [31:0] A;
input [31:0] B;
input [31:0] C;
input [2:1]sel;
output reg [31:0] Out; 
always @(*)
begin
	case(sel)
		0: Out = A;
		1: Out = B;
		2: Out = C;
		default: Out = 0;
	endcase 
end
endmodule