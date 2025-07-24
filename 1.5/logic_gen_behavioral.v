module logic_gen_behavioral #(parameter n=8) (
    input [n-1:0] A,
    input [n-1:0] B,
    input [1:0] logic_func,
    output reg [n-1:0] logic_out
);
    always @(*) begin
        case (logic_func)
            2'b00: logic_out = A & B;
            2'b01: logic_out = A | B;
            2'b10: logic_out = A ^ B;
            2'b11: logic_out = ~(A ^ B); // xnor
            default: logic_out = {n{1'b0}};
        endcase
    end
endmodule

