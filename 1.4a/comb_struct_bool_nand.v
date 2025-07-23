module comb_struct_bool_nand( input A, input B, input C, output Y);

  wire nA, nB, nC;
  wire t1, t2, t3, t4;

  // Inverters
  nand (nA, A, A);
  nand (nB, B, B);
  nand (nC, C, C);

  // ---- Term 1: AB'C' ----
  wire t1a, t1b;
  nand (t1a, A, nB);
  nand (t1a, t1a, t1a);
  nand (t1b, t1a, nC);
  nand (t1, t1b, t1b);

  // ---- Term 2: AB'C ----
  wire t2a, t2b;
  nand (t2a, A, nB);       
  nand (t2a, t2a, t2a);    
  nand (t2b, t2a, C);      
  nand (t2, t2b, t2b);     

  // ---- Term 3: ABC ----
  wire t3a, t3b;
  nand (t3a, A, B);        
  nand (t3a, t3a, t3a);    
  nand (t3b, t3a, C);      
  nand (t3, t3b, t3b);     

  // ---- Term 4: A'BC' ----
  wire t4a, t4b;
  nand (t4a, nA, B);       
  nand (t4a, t4a, t4a);    
  nand (t4b, t4a, nC);     
  nand (t4, t4b, t4b);     

  // ---- OR of 4 terms using NAND ----
  // Y = t1 + t2 + t3 + t4 = ~(~t1 & ~t2 & ~t3 & ~t4)
  wire nt1, nt2, nt3, nt4;
  nand (nt1, t1, t1);
  nand (nt2, t2, t2);
  nand (nt3, t3, t3);
  nand (nt4, t4, t4);

  wire tmp1, tmp2;
  nand (tmp1, nt1, nt2);
  nand (tmp2, nt3, nt4);

  wire tmp_final;
  nand (tmp_final, tmp1, tmp2);

  assign Y = tmp_final;

endmodule

