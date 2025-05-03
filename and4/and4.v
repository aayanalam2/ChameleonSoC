module and4 (
    input wire a, b, c, d,   // Four input signals
    output wire y            // Output signal
);

assign y = a & b & c & d;   // AND all inputs together

endmodule

