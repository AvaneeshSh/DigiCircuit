
module logic_gen_structural (input [3:0] A, input [3:0] B, input [1:0] logic_func, output reg [3:0] logic_out);
    wire [3:0] and_out, or_out, xor_out, xnor_out;

    // Logic gates
    and and0 (and_out[0], A[0], B[0]);
    and and1 (and_out[1], A[1], B[1]);
    and and2 (and_out[2], A[2], B[2]);
    and and3 (and_out[3], A[3], B[3]);

    or or0 (or_out[0], A[0], B[0]);
    or or1 (or_out[1], A[1], B[1]);
    or or2 (or_out[2], A[2], B[2]);
    or or3 (or_out[3], A[3], B[3]);

    xor xor0 (xor_out[0], A[0], B[0]);
    xor xor1 (xor_out[1], A[1], B[1]);
    xor xor2 (xor_out[2], A[2], B[2]);
    xor xor3 (xor_out[3], A[3], B[3]);

    xnor xnor0 (xnor_out[0], A[0], B[0]);
    xnor xnor1 (xnor_out[1], A[1], B[1]);
    xnor xnor2 (xnor_out[2], A[2], B[2]);
    xnor xnor3 (xnor_out[3], A[3], B[3]);

    always @(*) begin
        case (logic_func)
            2'b00: logic_out = and_out;
            2'b01: logic_out = or_out;
            2'b10: logic_out = xor_out;
            2'b11: logic_out = xnor_out;
            default: logic_out = 4'b0000;
        endcase
    end
endmodule
