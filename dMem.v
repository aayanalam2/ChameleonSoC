module dMem(dataOut, clk, dMemWE, dMemWMode, address, dataIn, rst);

output reg [31:0] dataOut;
input clk;
input dMemWE;
input [2:0] dMemWMode;
input [31:0] address;
input [31:0] dataIn;
input rst;

reg [7:0] register [0:2999];

initial 
begin
	$readmemh("output.txt", register);
end
always @(*) begin
	if(!dMemWE)
	begin 
			case (dMemWMode)										//Case Data Memory Write Mode
			3'b000:														//Byte (Signed)
			begin
				dataOut = {{24{register[address][7]}},register[address]};
			end
			3'b001:														//Half Word (Signed)
			begin
				dataOut = {{16{register[address][7]}},register[address],register[address+1]};
			end
			3'b010:														//Full Word
			begin
				dataOut = {register[address],register[address+1],register[address+2],register[address+3]};
			end
			3'b011:														//Byte (Unsigned)
			begin
				dataOut = {24'h000,register[address]};
			end
			3'b100:														//Half Word (Unsigned)
			begin
				dataOut = {16'h00,register[address],register[address+1]};
			end
		endcase
		end
	else dataOut = 0;
end
always @(posedge clk or negedge rst)
begin
	if(!rst)															//Asynchronous Reset (Active Low)
	begin
$readmemh("output.txt", register);
	end
	
	else
	begin
		if (dMemWE == 1)											
		begin
			case (dMemWMode)										//Case Data Memory Write Mode
			3'b000:														//Byte (Signed)
			begin
				register[address+3] <= {dataIn[7:0]};
				register[address+2] <= {8{dataIn[7]}};
				register[address+1] <= {8{dataIn[7]}};
				register[address] <= {8{dataIn[7]}};
			end
			3'b001:														//Half Word (Signed)
			begin
				register[address+3] <= {dataIn[7:0]};
				register[address+2] <= {dataIn[15:8]};
				register[address+1] <= {8{dataIn[7]}};
				register[address]   <= {8{dataIn[7]}};
			end
			3'b010:														//Full Word
			begin
				register[address+3] <= {dataIn[7:0]};
				register[address+2] <= {dataIn[15:8]};
				register[address+1] <= {dataIn[23:16]};
				register[address]   <= {dataIn[31:17]};
			end
			3'b011:														//Byte (Unsigned)
			begin
				register[address+3] <= {dataIn[7:0]};
				register[address+2] <= 8'h00;
				register[address+1] <= 8'h00;
				register[address] <= 8'h00;
			end
			3'b100:														//Half Word (Unsigned)
			begin
				register[address+3] <= {dataIn[7:0]};
				register[address+2] <= {dataIn[15:8]};
				register[address+1] <= 8'h00;
				register[address]   <= 8'h00;
			end
		endcase
		end
		
	end
end



endmodule
