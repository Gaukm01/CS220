// 1 bit addition/subtraction in 2's complement
module alu1(in1, in2, cin, opcode, out, cout);

   input in1;
   input in2;
   input cin;
   input opcode;

   output out;
   wire out;
   output cout;
   wire cout;

   wire b;
   assign b = in2 ^ opcode;


   assign out = in1 ^ b ^ cin;
   assign cout = (in1 & b) | (b & cin) | (cin & in1);

endmodule


//16 bit 2's complement addition / subtraction
module alu4(in1, in2, opcode, ans); //cf);

	input [15:0]in1;
  input [15:0]in2;
	input opcode;

	//output cf;
	output [15:0] ans;


	wire [15:0] carry;
	wire cin;
	assign cin = opcode;

	alu1 bit0 (.in1(in1[0]) , .in2(in2[0]) , .cin(cin) , .cout(carry[0]) , .opcode(opcode) , .out(ans[0]));
	alu1 bit1 (.in1(in1[1]) , .in2(in2[1]) , .cin(carry[0]) , .cout(carry[1]) , .opcode(opcode) , .out(ans[1]));
	alu1 bit2 (.in1(in1[2]) , .in2(in2[2]) , .cin(carry[1]) , .cout(carry[2]) , .opcode(opcode) , .out(ans[2]));
	alu1 bit3 (.in1(in1[3]) , .in2(in2[3]) , .cin(carry[2]) , .cout(carry[3]) , .opcode(opcode) , .out(ans[3]));
  alu1 bit4 (.in1(in1[4]) , .in2(in2[4]) , .cin(carry[3]) , .cout(carry[4]) , .opcode(opcode) , .out(ans[4]));
	alu1 bit5 (.in1(in1[5]) , .in2(in2[5]) , .cin(carry[4]) , .cout(carry[5]) , .opcode(opcode) , .out(ans[5]));
	alu1 bit6 (.in1(in1[6]) , .in2(in2[6]) , .cin(carry[5]) , .cout(carry[6]) , .opcode(opcode) , .out(ans[6]));
	alu1 bit7 (.in1(in1[7]) , .in2(in2[7]) , .cin(carry[6]) , .cout(carry[7]) , .opcode(opcode) , .out(ans[7]));
	alu1 bit8 (.in1(in1[8]) , .in2(in2[8]) , .cin(carry[7]) , .cout(carry[8]) , .opcode(opcode) , .out(ans[8]));
	alu1 bit9 (.in1(in1[9]) , .in2(in2[9]) , .cin(carry[8]) , .cout(carry[9]) , .opcode(opcode) , .out(ans[9]));
	alu1 bit10 (.in1(in1[10]) , .in2(in2[10]) , .cin(carry[9]) , .cout(carry[10]) , .opcode(opcode) , .out(ans[10]));
	alu1 bit11 (.in1(in1[11]) , .in2(in2[11]) , .cin(carry[10]) , .cout(carry[11]) , .opcode(opcode) , .out(ans[11]));
	alu1 bit12 (.in1(in1[12]) , .in2(in2[12]) , .cin(carry[11]) , .cout(carry[12]) , .opcode(opcode) , .out(ans[12]));
	alu1 bit13 (.in1(in1[13]) , .in2(in2[13]) , .cin(carry[12]) , .cout(carry[13]) , .opcode(opcode) , .out(ans[13]));
	alu1 bit14 (.in1(in1[14]) , .in2(in2[14]) , .cin(carry[13]) , .cout(carry[14]) , .opcode(opcode) , .out(ans[14]));
	alu1 bit15 (.in1(in1[15]) , .in2(in2[15]) , .cin(carry[14]) , .cout(carry[15]) , .opcode(opcode) , .out(ans[15]));


	//assign cf = carry[15];

endmodule
