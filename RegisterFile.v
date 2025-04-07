
module RegisterFile(r1Read, r2Read, r1Addr, r2Addr, writeEn, clk, rst , writeAddr, dataIn, reg_4);
	output reg [31:0] r1Read;
	output reg [31:0] r2Read;
	input clk;
	input rst;
	input writeEn;
	input [4:0] writeAddr;
	input [4:0] r1Addr;
	input [4:0] r2Addr;
	input [31:0] dataIn;
	
	output reg[31:0] reg_4;
	
	reg [31:0] regFile [31:0];
	integer i;
	initial 
	begin
		
		for (i=0; i<32; i=i+1)
			regFile[i] = 0;
	end
	
	always@(posedge clk or negedge rst)
	begin
		if(!rst) begin
			for (i=0; i<32; i=i+1)
			regFile[i] = 0;
		end
		if(writeEn)
		
			if(writeAddr!=0) regFile[writeAddr] <= dataIn;
			if(writeAddr == 0) regFile[0] <= 0;
	end
	always@(*)
	begin
		r1Read = regFile[r1Addr];
		r2Read = regFile[r2Addr];
		reg_4 = regFile[4];
	end
endmodule
