module Program_memory( Counter_value, Instruction_code);

input [31:0] Counter_value;
output reg [31:0] Instruction_code;
reg [7:0] Registers[99:0];

initial 
begin
  $readmemh("TestInstructions/FCBTest.txt", Registers);
end

always @(Counter_value) begin
	Instruction_code = {Registers[Counter_value], Registers[Counter_value + 1], Registers[Counter_value + 2], Registers[Counter_value+3]};
end

endmodule
	
