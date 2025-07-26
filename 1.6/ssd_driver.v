module ssd_driver (
    input enable,
    input [3:0] binary_in,
    output reg [6:0] ssd_out
);
always @(*) begin
    if (!enable)
        ssd_out = 7'b0000000;
    else begin
        case (binary_in)
            4'h0: ssd_out = 7'b1111110; // 0
            4'h1: ssd_out = 7'b0110000; // 1
            4'h2: ssd_out = 7'b1101101; // 2
            4'h3: ssd_out = 7'b1111001; // 3
            4'h4: ssd_out = 7'b0110011; // 4
            4'h5: ssd_out = 7'b1011011; // 5
            4'h6: ssd_out = 7'b1011111; // 6
            4'h7: ssd_out = 7'b1110000; // 7
            4'h8: ssd_out = 7'b1111111; // 8
            4'h9: ssd_out = 7'b1111011; // 9
            4'hA: ssd_out = 7'b1110111; // A
            4'hB: ssd_out = 7'b0011111; // b
            4'hC: ssd_out = 7'b1001110; // c
            4'hD: ssd_out = 7'b0111101; // d
            4'hE: ssd_out = 7'b1001111; // E
            4'hF: ssd_out = 7'b0000001; // '-' as per instructions
            default: ssd_out = 7'b0000000; // Off
        endcase
    end
end
endmodule

