module waveform_gen_struct(
    input clk,
    input enable,
    input sig_in,
    output sig_out
);

    wire [2:0] Q;  // 3-bit state register
    wire [2:0] D;  // 3-bit next state logic

    // State encodings
    // S0 = 000, S1 = 001, S2 = 010, S3 = 011, S4 = 100

    // Next state logic
    assign D[0] = (~Q[2] & ~Q[1] & ~Q[0] & sig_in) | // S0 -> S1
                  (~Q[2] & Q[1] & ~Q[0] & sig_in)  | // S1 -> S2
                  (Q[2] & ~Q[1] & ~Q[0] & sig_in)  | // S4 -> S4
                  (Q[2] & Q[1] & ~Q[0] & sig_in);     // S3 -> S4

    assign D[1] = (~Q[2] & Q[1] & ~Q[0] & sig_in) | // S1 -> S2
                  (~Q[2] & Q[1] & ~Q[0] & ~sig_in) | // S2 -> S3
                  (Q[2] & Q[1] & ~Q[0] & ~sig_in);   // S3 -> S0

    assign D[2] = (Q[2] & ~Q[1] & ~Q[0] & sig_in) | // S4 -> S4
                  (Q[2] & Q[1] & ~Q[0] & sig_in);   // S3 -> S4

    // Output logic
    assign sig_out = (~Q[2] & Q[1] & ~Q[0]) | // S1
                     (Q[2] & Q[1] & ~Q[0]);   // S3

    // Instantiate flip-flops for each state bit
    Dff dff0 (.clk(clk), .D(D[0]), .enable(enable), .reset(1'b1), .Q(Q[0]));
    Dff dff1 (.clk(clk), .D(D[1]), .enable(enable), .reset(1'b1), .Q(Q[1]));
    Dff dff2 (.clk(clk), .D(D[2]), .enable(enable), .reset(1'b1), .Q(Q[2]));

endmodule

