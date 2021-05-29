module encoder8to3 (a , Y);

 input [7:0] a; //  a represents form a7 a6 a5 a4 a3 a2 a1 a0 //i.e. 01000000 represents a0=0 a1=0 a2=0 a3=0 a4=0 a5=0 a6=1 a7=0.
 output [2:0] Y;  // Y represents form Y2 Y1 Y0 //i.e. 110 represents Y2=1,Y1=1,Y0=0 i.e. 6 .
 wire [2:0] Y;

 //using the method that if either of the value of a_i is 1 then it's corresponding Y_j
 // which is encoded 1 will become 1 due to the "or" between a_i's in the expression
 assign Y[0] = a[1] | a[3] | a[5] | a[7];
 assign Y[1] = a[2] | a[3] | a[6] | a[7];
 assign Y[2] = a[4] | a[5] | a[6] | a[7];

 endmodule
