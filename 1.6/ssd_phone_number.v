module ssd_phone_number (
    input [2:0] selector_in,
    output reg [3:0] phone_digit,
    output [6:0] ssd_out
);

    always @(*) begin
        case (selector_in)
            3'b000: phone_digit = 4'd8;
            3'b001: phone_digit = 4'd4;
            3'b010: phone_digit = 4'd5;
            3'b011: phone_digit = 4'hF;   // dash
            3'b100: phone_digit = 4'd7;
            3'b101: phone_digit = 4'd6;
            3'b110: phone_digit = 4'd7;
            3'b111: phone_digit = 4'd9;
            default: phone_digit = 4'd0;
        endcase
    end

    ssd_driver display (
        .enable(1'b1),
        .binary_in(phone_digit),
        .ssd_out(ssd_out)
    );

endmodule

