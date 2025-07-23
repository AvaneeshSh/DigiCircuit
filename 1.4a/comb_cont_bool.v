module comb_cont_bool( input A, input B, input C, output Y);

  assign Y = (A & ~B & ~C) | (A & ~B & C) | (A & B & C) | (~A & B & ~C);
endmodule
