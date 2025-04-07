module immediateGenerator(instruction, select, reset, immediate);
	input reset;
	input [31:0] instruction;
	input [3:0] select;
	output reg [31:0] immediate;

	//0 I-Type	
	//1 S-Type
	//2 B-Type
	//3 J-Type
	//4 U-Type

	//Immeidate Logic
	always @(*) begin
		if (!reset) immediate = 0;
		else begin
			case(select)
				//I type immediate
				0: 
				begin
					immediate = {{21{instruction[31]}},instruction[30:25],instruction[24:20]};
				end
				//S type Immediate:
				1:
				begin
					immediate = {{21{instruction[31]}},instruction[30:25],instruction[11:7]};
				end
				//Branch Immediates
				2:
					immediate = {{21{instruction[31]}},instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0};
				//J Type Immediate
				3: 
					immediate = {{11{instruction[31]}},instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
				//U Type Immediate	
				4:
					immediate = {instruction[31:12],{12'd0}};
				default:
					immediate = 0;
			endcase // select
		end
	end

endmodule 