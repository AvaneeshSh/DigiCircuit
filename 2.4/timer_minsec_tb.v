`timescale 1ns/1ns

`define CLK_DIV 7

module timer_minsec_tb (
    output wire [3:0] sec_low_digit,
    output wire [2:0] sec_high_digit,
    output wire [3:0] min_low_digit
);

    reg clk = 0;
    reg reset = 1;
    reg pause = 1;
    reg up_down = 1;

    wire sec_low_dig_enable;

    // Clock generation (20ns period, 50 MHz)
    always #10 clk = ~clk;

    // Instantiate clock divider to generate enable pulses
    clock_divider #(.CLK_DIV_INT(`CLK_DIV)) CD_UUT (
        .clk(clk),
        .reset(reset),
        .pause(pause),
        .rco_enable(sec_low_dig_enable)
    );

    // Instantiate the timer_minsec module
    timer_minsec UUT (
        .clk(clk),
        .reset(reset),
        .enable(sec_low_dig_enable),
        .up_down(up_down),
        .sec_low_digit(sec_low_digit),
        .sec_high_digit(sec_high_digit),
        .min_low_digit(min_low_digit)
    );

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        pause = 1;
        up_down = 1;

        #25;
        reset = 0;      // Release reset after 25ns
        pause = 0;      // Start counting up

        #43000;        // Run counting up for a while

        up_down = 0;    // Switch to counting down

        #37000;        // Count down for a while

        pause = 1;      // Pause counting
        #100;

        $finish;
    end

endmodule
