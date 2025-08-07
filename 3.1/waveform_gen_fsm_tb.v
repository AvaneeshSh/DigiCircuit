`timescale 1ns / 1ns

module waveform_gen_fsm_tb(
    output wire waveform_out
);

    reg clk = 0;
    reg en = 0;
    reg sig_in = 0;

    // Instantiate UUT (can switch between structural/behavioral)
    waveform_gen_behav uut (
        .clk(clk),
        .enable(en),
        .sig_in(sig_in),
        .sig_out(waveform_out)
    );

    // Clock generation (10 ns period, 50% duty)
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        #20 en = 1'b1;
        #32 sig_in = 1'b1;
        #30 sig_in = 1'b0;
        #20 sig_in = 1'b1;
        #20 sig_in = 1'b0;
    end

endmodule
