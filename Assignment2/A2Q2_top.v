module priority_encoder8to3_top;

  reg [7:0] a_in; // input value to  priortiy encode.

  wire [2:0] Y_out;  // output value returned after encoding.

  priority_encoder8to3 ENCODE (.a(a_in),.Y(Y_out));

  always @(a_in or Y_out) begin
    $monitor ("time : %d , a_in : %b , Y_out : %b , Y_out(decimal) : %d", $time,a_in,Y_out,Y_out);
  end

  initial begin
    a_in = 8'b00001010; // should give encoded value based on a[1]=1
    #1
    $display("\n");
    a_in = 8'b00110000;
    #1
    $display("\n");
    a_in = 8'b01001000;
    #1
    $display("\n");
    a_in = 8'b11100010;
    #1
    $display("\n");
    a_in = 8'b01010101;
    #1
    $display("\n");
    a_in = 8'b11111111;
    #1
    $display("\n");
    a_in = 8'b11000000;
    #1
    $display("\n");
    a_in = 8'b10100100;
    #1
    $display("\n");
    a_in = 8'b11010000;
    #1
    $display("\n");
    a_in = 8'b10100000;

  end

endmodule
