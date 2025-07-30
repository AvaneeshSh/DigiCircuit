`timescale 1ns / 1ns

module JKff_tb;

    // Simulation signals
    reg clk;
    reg [1:0] JK = 2'b00;
    reg en = 1'b0;
    reg clr = 1'b1; // Active-low reset
    wire Q;         // Corrected from "output wire" to just wire

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Instantiate Unit Under Test (UUT)
    JKff UUT (
        .clk(clk),
        .J(JK[1]),
        .K(JK[0]),
        .enable(en),
        .reset(clr),
        .Q(Q)
    );

    // Stimulus
    initial begin
        // Initial JK: 00 (hold)
        #20 JK = 2'b10; $display("Time %0t: JK = %b", $time, JK); // Set
        #20 en = 1'b1;
        #20 JK = 2'b10; $display("Time %0t: JK = %b", $time, JK); // Set again
        #20 JK = 2'b11; $display("Time %0t: JK = %b", $time, JK); // Toggle
        #20 JK = 2'b01; $display("Time %0t: JK = %b", $time, JK); // Reset
        #20 clr = 1'b0; JK = 2'b10; $display("Time %0t: JK = %b (reset low)", $time, JK); // Async clear
        #20 clr = 1'b1;
        #10 JK = 2'b00; $display("Time %0t: JK = %b", $time, JK); // Hold
        #10 JK = 2'b11; $display("Time %0t: JK = %b", $time, JK); // Toggle
        #20 JK = 2'b01; $display("Time %0t: JK = %b", $time, JK); // Reset again

        // End simulation
        #20 $finish;
    end

endmodule
