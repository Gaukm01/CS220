module decoder_to_encorder_top;

  reg [2:0] Y_in; // input value to decode.

  wire [7:0] temp_a; // temprorary decoded value of input
  wire [2:0] Y_out;  // output value returned after encoding.

  decoder3to8 DECODE (.Y(Y_in),.a(temp_a));

  encoder8to3 ENCODE (.a(temp_a),.Y(Y_out));

  always @(Y_in or temp_a or Y_out) begin
    $monitor ("time : %d , Y_in : %b , decoded output : %b , Y_out : %b", $time,Y_in,temp_a,Y_out);
  end

  initial begin
    Y_in = 3'b000;
    #5
    $display("\n");
    Y_in = 3'b001;
    #5
    $display("\n");
    Y_in = 3'b010;
    #5
    $display("\n");
    Y_in = 3'b011;
    #5
    $display("\n");
    Y_in = 3'b100;
    #5
    $display("\n");
    Y_in = 3'b101;
    #5
    $display("\n");
    Y_in = 3'b110;
    #5
    $display("\n");
    Y_in = 3'b111;

  end

endmodule
