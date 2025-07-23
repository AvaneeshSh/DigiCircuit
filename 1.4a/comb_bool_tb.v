// Testbench for combinational logic example

`timescale 1ns/1ns

module comb_bool_tb();
  reg clk;
  reg [2:0] count;
  wire struct_out, nand_out, cont_out;

  initial begin
    clk = 1;
    count = -1;
  end

  always #5 clk = ~clk;
  always @(posedge clk) count = count + 1;

  comb_struct_bool S_UUT(.A(count[2]), .B(count[1]), .C(count[0]), .Y(struct_out));
  comb_struct_bool_nand N_UUT(.A(count[2]), .B(count[1]), .C(count[0]), .Y(nand_out));
  comb_cont_bool C_UUT(.A(count[2]), .B(count[1]), .C(count[0]), .Y(cont_out));
endmodule // comb_bool_tb

