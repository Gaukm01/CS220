// `timescale 1ns / 1ps
module adder_1_bit(a, b, cin, opcode, sum, carry);
	 
	input a, b, cin;
	input opcode;
	
	output sum; 
	wire sum;
    output carry;
    wire carry;


    wire B;
    assign  B = b^opcode;

    assign sum = a ^ B ^ cin;
    assign carry = ( a & B) | (B & cin)| (a & cin);


endmodule