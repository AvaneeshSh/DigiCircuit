`timescale 1ns/1ns

module top_60_tb;

    reg clk = 0;
    reg reset = 1;
    reg pause = 0;
    wire [3:0] low_digit;
    wire [2:0] high_digit;
    wire [3:0] muxed_digits;
    wire en_high_digit;
    wire en_low_digit;

    // Instantiate top module
    top_60 #(.CLK_DIV_INT(5)) uut (
        .clk(clk),
        .reset(reset),
        .pause(pause),
        .low_digit(low_digit),
        .high_digit(high_digit),
        .muxed_digits(muxed_digits),
        .en_high_digit(en_high_digit),
        .en_low_digit(en_low_digit)
    );

    // Clock generation: 10ns period (100 MHz)
    always #5 clk = ~clk;

    initial begin
        $dumpfile("top_60_tb.vcd");
        $dumpvars(0, top_60_tb);

        // Release reset after a few clock cycles
        #20;
        reset = 0;

        // Let it run without pause for 800ns (~80 counts)
        #800;

        // Activate pause
        pause = 1;
        #100;

        // Resume
        pause = 0;
        #400;
    end

endmodule
