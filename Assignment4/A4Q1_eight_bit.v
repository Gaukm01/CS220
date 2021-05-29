
// `timescale 1ns / 1ps

module adder_8_bit( a,b,sum,opcode,overflow,cout);
  output  [7:0] sum ;
  wire [7:0] sum;

  output  overflow ;
  wire overflow;

  output  cout;
  wire cout;


  input    [7:0] a ;
  input    [7:0] b ;
  input opcode; 

wire [6:0] carry;

	adder_1_bit bit0 (.a(a[0]), .b(b[0]), .cin(opcode), .opcode(opcode), .sum(sum[0]), .carry(carry[0]));
	adder_1_bit bit1 (.a(a[1]), .b(b[1]), .cin(carry[0]), .opcode(opcode), .sum(sum[1]), .carry(carry[1]));
	adder_1_bit bit2 (.a(a[2]), .b(b[2]), .cin(carry[1]), .opcode(opcode), .sum(sum[2]), .carry(carry[2]));
	adder_1_bit bit3 (.a(a[3]), .b(b[3]), .cin(carry[2]), .opcode(opcode), .sum(sum[3]), .carry(carry[3]));
	adder_1_bit bit4 (.a(a[4]), .b(b[4]), .cin(carry[3]), .opcode(opcode), .sum(sum[4]), .carry(carry[4]));
	adder_1_bit bit5 (.a(a[5]), .b(b[5]), .cin(carry[4]), .opcode(opcode), .sum(sum[5]), .carry(carry[5]));
	adder_1_bit bit6 (.a(a[6]), .b(b[6]), .cin(carry[5]), .opcode(opcode), .sum(sum[6]), .carry(carry[6]));
	adder_1_bit bit7 (.a(a[7]), .b(b[7]), .cin(carry[6]), .opcode(opcode), .sum(sum[7]), .carry(cout));


assign overflow=  (carry[6]^cout);

	
endmodule