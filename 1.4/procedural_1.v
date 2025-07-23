/* Procedural assignment example 1
Demonstrates procedural assignments
*/
module procedural_1(A,B,C,Y);
  input A, B, C;
  output Y;
  reg D;
  reg E;
  
// procedural assignment
  //always @(*) begin //alternative for combinational
  always @(A,B,C) begin
    D = A&B;
    E = !A&C;
  end

  assign Y=D|E;
endmodule //procedural_
