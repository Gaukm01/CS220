module eight_bit_comparator_top;

   reg [7:0] A;
   reg [7:0] B;

   wire l_out,g_out,e_out;

   eight_bit_comparator COMPARE (.a(A), .b(B), .l_out(l_out), .g_out(g_out), .e_out(e_out));

   always @ (A or B or l_out or g_out or e_out) begin
         $display("<Time : %d> : A = %d , B = %d , less = %d , equal = %b , greater = %b \n",$time, A, B,l_out,e_out,g_out);
   end

   initial begin
      #60
      $finish;
   end

   //testbench
   initial begin

      A = 128; B =127;
      #1
      $display("\n");

      A = 0; B = 0; //can also input in 8d'0 form
      #1
      $display("\n");

      A =25; B =25;
      #1
      $display("\n");

      A =39; B =16;
      #1
      $display("\n");

      A =37; B =79;
      #1
      $display("\n");

      A =24; B=200;
      #1
      $display("\n");

      A= 109; B=109;
      #1
      $display("\n");

      A=237; B=99;
      #1
      $display("\n");

      A =20; B =100;
      #1
      $display("\n");

      A=187; B=176;

    end

endmodule
