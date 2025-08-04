`timescale 1ns/1ns

module timer_60_tb;

    reg clk;
    reg reset;
    reg enable;
    wire [3:0] low_digit;
    wire [2:0] high_digit;

    // Instantiate the DUT
    timer_60 uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .low_digit(low_digit),
        .high_digit(high_digit)
    );

    // Generate a clock: fast so we can see changes
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns clock period
    end

    initial begin
        // Waveform dump
        $dumpfile("timer_60_tb.vcd");
        $dumpvars(0, timer_60_tb);

        // Initial conditions
        reset = 1;
        enable = 0;

        #10 reset = 0;
        #10 enable = 1;
    end

endmodule
