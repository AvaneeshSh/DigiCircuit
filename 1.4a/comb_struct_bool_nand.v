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

  wire or12, or34;

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

  // OR stage using NAND only (fixed)
  nand (or12, t1bb, t2bb);
  nand (or34, t3bb, t4bb);
  nand (Y, or12, or34);

endmodule


