module A3Q2_fsm_top;

   reg clk;
   reg [1:0]Y;
   wire [3:0]curr;

   fsm FSM (.clk(clk), .Y(Y), .curr(curr));

   always @ (posedge clk) begin
      $display("Time = %d, Y = %b, current_state = %d", $time, Y, curr);
   end

   initial begin
      forever begin
         clk = 0;
         #5
         clk = 1;
         #5
         clk = 0;
      end
   end
/*
S3 2’b00 S4
S3 2’b01 S5
S3 2’b1x S6

S10 2’b00 S11
S10 2’b01, S12
    2’b1x
*/
   initial begin
      #3
      Y=2'b00;
      #10
      Y=2'b10;
      #10
      Y=2'b01;
      #10
      Y=2'b11;
      #10
      Y=2'b10;
      #10
      Y=2'b01;
      #10
      Y=2'b11;
      #10
      Y=2'b10;
      #10
      Y=2'b11;
      #10
      Y=2'b00;
      #10
      Y=2'b01;
      #10
      Y=2'b10;
      #10
      Y=2'b01;
      #10
      Y=2'b01;
   end

   initial begin
      #150
      $finish;
   end

endmodule
