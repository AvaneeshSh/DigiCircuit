`timescale 1ns/1ns

module ssd_phone_number_tb ();

    reg [2:0] selector_in;
    wire [3:0] phone_digit;
    wire [6:0] ssd_out;

    ssd_phone_number uut (
        .selector_in(selector_in),
        .phone_digit(phone_digit),
        .ssd_out(ssd_out)
    );

    initial begin
        $display("selector | digit | ssd_out");
        for (selector_in = 0; selector_in < 8; selector_in = selector_in + 1) begin
            #10;
            $display("   %b     |   %d   | %b", selector_in, phone_digit, ssd_out);
        end
        $finish;
    end

endmodule

