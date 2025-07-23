/* Behavioral assignment example 1
Demonstrates continuous assignments
*/
module continous_1(A,B,C,Y);
  input A, B, C;
  output Y;
  wire D,E;

  assign D = A & B;
  assign E = !A & C;
  assign Y = D | E;
endmodule //continous_1
