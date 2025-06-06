module MasterMemoryController (
input clk,       
input reset, 
    

// wishbone 
output reg [2:0] wb_address,   
input  [31:0] wb_data_out, 
output reg wb_we,              
output reg wb_bus_cycle,
output reg [3:0] wb_select,
output reg wb_stb,
output reg [31:0] wb_data_in,
//input  wb_ack,
//input wb_error,

 //memory
output [31:0] mem_addr,
output mem_write,
output [31:0] mem_data_in,
input  [31:0] mem_data_out,
output [0:2]mem_control,


// input signals
input write,
//input read,
input [2:0] func_3 ,
input [31:0] address,
input [31:0] datain ,
  
output reg[31:0] dataout

	                    
);

reg FCB_sel;
reg mem_sel;

integer i;

// Input to the fcb
  always@(*)
    begin
 wb_stb = 1;
      wb_bus_cycle = FCB_sel;
 wb_address = address[4:2];
 wb_we = write;
      wb_data_in =datain << {address[1:0],3'b000};
     end
// wishbone select signal is generated in always block


// Input signals to the memory
assign mem_write = mem_sel & write;
//assign mem_read = mem_sel & read;
assign mem_addr = address;
assign mem_data_in = datain;
assign mem_control = func_3;

  always @(*) 
begin
	if (!reset) begin     
	FCB_sel = 0;
	mem_sel = 0;
	wb_select = 0;
    
	end


	else begin
      if (address >= 32'hffffffe0)begin
	FCB_sel = 1;
	mem_sel = 0;
    dataout = wb_data_out;
	end 
	else begin
	FCB_sel = 0;
	mem_sel = 1;
    dataout = mem_data_out;
	end
		case (address [1:0] )
			2'b00: begin
					case (func_3)
						3'b000:begin  
						wb_select = 4'b0001;
						end
						3'b001:begin
						wb_select = 4'b0011;
						end
						3'b010:begin
						wb_select = 4'b1111;
						end
						
						default: wb_select = 4'b0000;
						endcase
								
					end
								
					2'b01:begin
						case (func_3)
							3'b000:  
							wb_select = 4'b0010;
							default: wb_select = 4'b0000;
						endcase
						end
								
						2'b10:begin
								case (func_3)
									3'b000:begin
									wb_select = 4'b0100;
									end		
								3'b001:begin
										wb_select = 4'b1100;
										end
								default: wb_select = 4'b0000;
								endcase
								end
						
						2'b11: begin
								case (func_3)
								3'b000:begin
									wb_select = 4'b1000;
										
										end
								default: wb_select = 4'b0000;
										endcase
									
									end
		endcase
	end
end
  
endmodule