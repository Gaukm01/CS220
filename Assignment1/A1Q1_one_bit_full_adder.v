module one_bit_full_adder (a, b, cin, sum, cout);

   input a;
   input b;
   input cin;

   output sum;
   wire sum;
   output cout;
   wire cout;

   assign sum  = a^b^cin; // sum bit
   assign cout = ((a&b) | (b&cin) | (a&cin)); //carry bit
      // $display("time=%d: %b + %b + %b = %b, cout = %b\n",$time,a,b,cin,sum,cout);

endmodule
