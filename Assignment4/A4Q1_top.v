// `timescale 1ns / 1ps

module adder_8_bit_top;

    reg signed [7:0] A;
    reg signed [7:0] B;
    reg  opcode;

    wire signed   [7:0] sum;
    wire overflow;
    wire cout1;

  adder_8_bit u_addsub_8_bit( .a(A),.b(B),.opcode(opcode),.sum(sum),.overflow(overflow),.cout(cout1) );

  initial begin
    // #1
    A=40; B=82; opcode=1'b0;
    #1
    $display("\n");

    A=87; B=116; opcode=1'b1;
    #1
    $display("\n");

    A= -87; B= -116; opcode=1'b1;
    #1
    $display("\n");

    A= 127; B= 23; opcode=1'b0;
    #1
    $display("\n");

    A= -33; B= -100; opcode=1'b0;
    #1
    $display("\n");

    A= -127; B=-127; opcode=1'b1;
    #1
    $display("\n");

    A= -103; B= 82; opcode=1'b0;
    #1
    $display("\n");

    A= -23; B= 110; opcode=1'b1;
    #1
    $display("\n");

    A= -63; B= -54; opcode=1'b1;
    #1
    $display("\n");

    A= 79; B= -67; opcode=1'b1;
    #1
    $finish;
  end

always @ (A or B or opcode or sum or overflow) begin
    $monitor("\ntime:%d : input A: %b,%d  input B: %b,%d opcode: %b , sum: %b,%d , cout: %b  overflow = %b",$time,A,A,B,B,opcode,sum,sum,cout1,overflow);
    end

endmodule
