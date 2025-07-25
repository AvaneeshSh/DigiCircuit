module comb_struct_bool_nand(
  input A,
  input B,
  input C,
  output Y
);

  wire nA, nB, nC;
  wire t1a, t1aa, t1b, t1bb;
  wire t2a, t2aa, t2b, t2bb;
  wire t3a, t3aa, t3b, t3bb;
  wire t4a, t4aa, t4b, t4bb;
  wire or1, or2, or3, or4;
  wire or12, or34;
  wire orr12, orr34;

  // Inverters
  nand (nA, A, A);
  nand (nB, B, B);
  nand (nC, C, C);

  // Term 1: AB'C'
  nand (t1a, A, nB);
  nand (t1aa, t1a, t1a);
  nand (t1b, t1aa, nC);
  nand (t1bb, t1b, t1b);

  // Term 2: AB'C
  nand (t2a, A, nB);
  nand (t2aa, t2a, t2a);
  nand (t2b, t2aa, C);
  nand (t2bb, t2b, t2b);

  // Term 3: ABC
  nand (t3a, A, B);
  nand (t3aa, t3a, t3a);
  nand (t3b, t3aa, C);
  nand (t3bb, t3b, t3b);

  // Term 4: A'BC'
  nand (t4a, nA, B);
  nand (t4aa, t4a, t4a);
  nand (t4b, t4aa, nC);
  nand (t4bb, t4b, t4b);

  nand(or1, t1bb, t1bb);
  nand(or2, t2bb, t2bb);
  nand(or3, t3bb, t3bb);
  nand(or4, t4bb, t4bb);
  nand(or12, or1, or2);
  nand(or34, or3, or4);
  nand(orr12, or12, or12);
  nand(orr34, or34, or34);
  nand (Y, orr12, orr34);

endmodule