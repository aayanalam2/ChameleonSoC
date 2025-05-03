module counter_4bit (
    input wire clk,        // Clock input
    input wire reset,      // Active-high synchronous reset
    output reg [3:0] count // 4-bit count output
);

always @(posedge clk) begin
    if (reset)
        count <= 4'b0000;          // Reset counter to 0
    else
        count <= count + 1'b1;     // Increment counter
end

endmodule

