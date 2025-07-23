//Testbench for combinational logic example 

`timescale 1ns/1ns 

module comb_logic_tb();
  reg clk;
  reg [2:0] count;
  wire proceed_out;
  
  initial begin
    clk = 1;
    count = -1;

end
always #5 clk = ~clk;
always @(posedge clk) count = count + 1; 

  procedural_1 P_UUT(.A(count[2]), .B(count[1]), .C(count[0]), .Y(proceed_out));
endmodule //comb_logic_tb