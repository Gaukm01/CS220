// `include "A1Q1_eight_bit_adder.v"
module eight_bit_adder_top;

   reg [7:0] A;
   reg [7:0] B;
   reg Cin;

   wire [7:0] Sum;
   wire Carry;

   eight_bit_adder ADDER (.x(A), .y(B), .carry_in(Cin), .sum(Sum), .carry_out(Carry));
    always @ (A or B or Cin or Sum or Carry) begin
        $display("time:%d : input A: %d  input B: %d cin: %b sum: %d, Carry = %b",$time,A,B,Cin,Sum,Carry);
    end

   initial
    begin

      A = 100; B =100; Cin =1; //can also take input in 8d'100 and 1b'1 form.
      #1
      $display("\n");
      A = 200; B = 200; Cin = 0;
      #1
      $display("\n");
      A = 20; B = 200; Cin = 0;
      #1
      $display("\n");
      A = 233; B = 200; Cin = 1;
      #1
      $display("\n");
      A = 99; B = 123; Cin = 1;
      #1
      $display("\n");
      A = 20; B = 76; Cin = 0;
      #1
      $display("\n");
      A = 34; B = 255; Cin = 0;
      #1
      $display("\n");
      A = 245; B = 34; Cin = 1;
      #1
      $display("\n");
      A = 23; B = 23; Cin = 0;
      #1
      $display("\n");
      A = 255; B = 255; Cin = 1;

   end

endmodule
