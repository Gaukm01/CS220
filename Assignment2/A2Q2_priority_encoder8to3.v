module priority_encoder8to3 (a , Y);

 input [7:0] a; //  a represents form a7 a6 a5 a4 a3 a2 a1 a0 //i.e. 01000000 represents a0=0 a1=0 a2=0 a3=0 a4=0 a5=0 a6=1 a7=0  .
 output [2:0] Y;  // Y represents form Y2 Y1 Y0 //i.e. 110 represents Y2=1,Y1=1,Y0=0 i.e. 6 .
 wire [2:0] Y;


 //using the fact that if lower significant bit is 1 then higher significant bit does not involve/affect Y

 // by using method that if a_i =1 gives Y=1 then all other higher significant bit's (than present bit) results is "OR" to it,
 //        i.e. higher significant bits won't effect assigning Y=1; as a_i(1) "OR" thier result ensures assigning Y=1.
 // also if a_i=1 gives Y=0 then all other higher significant bit's (than present bit) results are "AND" to this,
 //        i.e. if a_i is true then higher significant bit's (which should not affect) result "AND" ~a_i (0) ensures assigning Y=0.
//** Also lower significant bits are kept in left side so that Y values is assigned as soon as it encounter 1
//         i.e. the least significant 1 **

 assign Y[0] = ~a[0] & ( a[1] | (~a[2] & (a[3] | (~a[4] & (a[5] | (~a[6] & a[7]))))));
 assign Y[1] = ~a[0] & ~a[1] & (a[2] | a[3] | (~a[4] & ~a[5] & (a[6] | a[7])));
 assign Y[2] = ~ a[0] & ~a[1] & ~a[2] & ~a[3] & (a[4] | a[5] | a[6] | a[7] );

 endmodule
