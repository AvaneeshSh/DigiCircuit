/*Structural design example 1
*/

module structural_1(A,B,C,Y);
  input A, B, C;
  output Y;
  wire D, E;

  not(An, A);
  and(D, A, B);
  and(E, An, C);
  or(Y, D, E);


 endmodule //structural_1