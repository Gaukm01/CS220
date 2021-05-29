module top;
wire out;
reg clock, in;
fsm M0(.CLK(clock),.X(in), .Z(out));

initial 
begin
        clock = 1'b1;
        in = 1'b0;
        in = #8 1'b1;
        //10
        in = #10 1'b0;
        //20
        in = #10 1'b1;
        //30
        in = #10 1'b0;
        //40
        in = #10 1'b0;
        //50
        in = #10 1'b0;
        //60
        in = #10 1'b1;
        //70
        in = #10 1'b0;
        //80
        in = #10 1'b1;
        //90
        in = #10 1'b0;
        //100
        #2$finish; // end simulation
end

// always @(out,in) begin
// $display("CLK= %b,time=%d: Output=%b, in =%b\n",clock,$time,out,in);     
// end
always @(posedge clock) begin
$strobe("time:%d, Output=%b\n",$time,out);     
end

always 
    begin
    #5 clock = ~clock;
    end
endmodule