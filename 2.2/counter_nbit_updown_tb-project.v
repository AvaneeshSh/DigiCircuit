/* counter_nbit_updown_tb-project.v
*      Avaneesh Sharma
*      2025-08-01
*      189190
*/

`define N_BITS_3 3
`define N_BITS_4 4

module counter_nbit_updown_tb(
    output wire[`N_BITS_3-1:0] count_3bit,
    output wire[`N_BITS_4-1:0] count_4bit
);

// Simulation signals
reg clk;
reg en = 1'b0;
reg ld = 1'b0;
reg [`N_BITS_3-1:0] dat_3;
reg [`N_BITS_4-1:0] dat_4;
reg up_down = 1'b1; // Start with count up

// Generate the clock waveform (10 ns period, 50% duty cycle)
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Instantiate 3-bit counter (UUT1)
counter_nbit_updown #(.WIDTH(`N_BITS_3)) UUT1 (
    .clk(clk),
    .enable(en),
    .data(dat_3),
    .load(ld),
    .up_down(up_down),
    .count(count_3bit)
);

// Instantiate 4-bit counter (UUT2)
counter_nbit_updown #(.WIDTH(`N_BITS_4)) UUT2 (
    .clk(clk),
    .enable(en),
    .data(dat_4),
    .load(ld),
    .up_down(up_down),
    .count(count_4bit)
);

// Simulation sequence
initial begin
  // Step 1: Load 0
  dat_3 = 3'b000;
  dat_4 = 4'b0000;

  ld = 1'b1;
  up_down = 1'b1;
  en = 1'b0;
  #10;
  ld = 1'b0;
  en = 1'b1;

  // Step 2: Count up
  #160;

  en = 1'b0;
  #20;

  // Step 4: Count down
  up_down = 1'b0;
  en = 1'b1;
  #160;

  $stop;
end



endmodule // counter_nbit_updown_tb
