module eight_bit_comparator (a,b,l_out,g_out,e_out);

   input [7:0]a;
   input [7:0]b;

   output l_out,g_out,e_out; // final output
   wire l_out,g_out,e_out;

   //extra wire l,g,e to store value for each bit
   wire [8:0]l;
   wire [8:0]g;
   wire [8:0]e;

   assign l[8] = 1'b0;
   assign g[8] = 1'b0;
   assign e[8] = 1'b1;
   /* most significant bit is compared; taking initial
   values as equal(=1) so that it's normaly compared
   Later the result of this will be passed on to next most
   significant bit */

   one_bit_comparator FA7 (a [7],b [7],l [8],g [8],e [8],l [7],g [7],e [7]);
   one_bit_comparator FA6 (a [6],b [6],l [7],g [7],e [7],l [6],g [6],e [6]);
   one_bit_comparator FA5 (a [5],b [5],l [6],g [6],e [6],l [5],g [5],e [5]);
   one_bit_comparator FA4 (a [4],b [4],l [5],g [5],e [5],l [4],g [4],e [4]);
   one_bit_comparator FA3 (a [3],b [3],l [4],g [4],e [4],l [3],g [3],e [3]);
   one_bit_comparator FA2 (a [2],b [2],l [3],g [3],e [3],l [2],g [2],e [2]);
   one_bit_comparator FA1 (a [1],b [1],l [2],g [2],e [2],l [1],g [1],e [1]);
   one_bit_comparator FA0 (a [0],b [0],l [1],g [1],e [1],l_out,g_out,e_out);

   /* the value l_out,g_out,e_out contains the final comparison
   result after each bit*/

endmodule
