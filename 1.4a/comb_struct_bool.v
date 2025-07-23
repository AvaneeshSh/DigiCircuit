module comb_struct_bool(input A, input B, input C, output Y);
  wire nA, nB, nC;
  wire term1, term2, term3, term4;

  not (nA, A);
  not (nB, B);
  not (nC, C);

  and (term1, A, nB, nC);   // AB'C'
  and (term2, A, nB, C);    // AB'C
  and (term3, A, B, C);     // ABC
  and (term4, nA, B, nC);   // A'BC'

  or (Y, term1, term2, term3, term4);
endmodule

