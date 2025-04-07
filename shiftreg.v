module shiftreg (input fpga_head, 
                 input prog_clk,
                 input reset,
                 output reg fpga_tail);
 
  reg[63:0] shiftreg ;
 
  always@(posedge prog_clk, negedge reset)begin
    if (!reset) begin
      shiftreg <= 0;
    end
    else begin  
      shiftreg <= {shiftreg[62:0], fpga_head };
      fpga_tail <= shiftreg[63];
    end
    end
endmodule
  