
// module fulladder_top;
// reg a, b, c;
// wire sum, carry;
// one_bit_full_adder uut(a,b,c,sum,carry);
// always @(sum or carry)
// begin
// $display("time=%d: %b + %b + %b =%b, carry =%b\n",$time,a,b,c,sum,carry);
// end
// initial
// begin
// #40
// $finish;
// end
// initial
// begin
// a = 0; b = 0; c = 0;
// #5
// a = 0; b = 1; c = 0;
// #5
// a = 1; b = 0; c = 1;
// #5
// a = 1; b = 1; c = 1;
// end
// endmodule
// /******************************************************/
module eight_bit_adder (x, y, carry_in, sum, carry_out);

   input [7:0] x;
   input [7:0] y;
   input carry_in;

   output [7:0] sum;
   wire [7:0] sum;
   output carry_out;
   wire carry_out;
      
   // wire [7:0] y;
   //  assign y[0] = y[0]^carry_in; if we wanted to use it as subtracter.
   //  assign y[1] = y[1]^carry_in;
   //  assign y[2] = y[2]^carry_in;
   //  assign y[3] = y[3]^carry_in;
   //  assign y[4] = y[4]^carry_in;                          
   //  assign y[5] = y[5]^carry_in;
   //  assign y[6] = y[6]^carry_in;
   //  assign y[7] = y[7]^carry_in;

   wire [7:0] intermediate_carry;

   one_bit_full_adder FA0 (x[0], y[0], carry_in, sum[0], intermediate_carry[0]);
   one_bit_full_adder FA1 (x[1], y[1], intermediate_carry[0], sum[1], intermediate_carry[1]);
   one_bit_full_adder FA2 (x[2], y[2], intermediate_carry[1], sum[2], intermediate_carry[2]);
   one_bit_full_adder FA3 (x[3], y[3], intermediate_carry[2], sum[3], intermediate_carry[3]);
   one_bit_full_adder FA4 (x[4], y[4], intermediate_carry[3], sum[4], intermediate_carry[4]);
   one_bit_full_adder FA5 (x[5], y[5], intermediate_carry[4], sum[5], intermediate_carry[5]);
   one_bit_full_adder FA6 (x[6], y[6], intermediate_carry[5], sum[6], intermediate_carry[6]);
   one_bit_full_adder FA7 (x[7], y[7], intermediate_carry[6], sum[7], intermediate_carry[7]);
   
   assign carry_out = intermediate_carry[7];

   // @always @(sum) begin
   //       $display("Sum %b",sum);
   // end
   // always @(sum or cin)
   //    begin
   //    $display("time=%d: Sum = %b, carry = %b\n",$time,sum,cout_out);
   //    end
   //   assign carry_out = intermediate_carry[7];



endmodule

/***********************************************************************/
