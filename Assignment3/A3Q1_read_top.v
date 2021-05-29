module top;
// reg out;
reg[3:0] row_number;
reg valid_input;
reg clock;
wire output_bit;
wire[31:0] word_out1;
read M0(.clk(clock),.row_number(row_number), .valid_input(valid_input),.output_valid(output_bit),.word_out(word_out1));

initial
begin
        clock = 1'b0;
        #3
        valid_input=1;
        row_number =3;
//3
       #30
        valid_input=1;
        row_number =3;
//33
        #30
        valid_input=1;
        row_number =4;
//63
        #30
        valid_input=1;
        row_number =4;
//93
        #30
        valid_input=1;
        row_number =4;
//123
        #30
        valid_input=1;
        row_number =10;
//153
        #30
        valid_input=1;
        row_number =12;
//183
        #30
        valid_input=1;
        row_number =10;
//213
        #30
        valid_input=1;
        row_number =3;
//243
        #30
        valid_input=1;
        row_number =3;
//273
      //   valid_input=#30 1;
      //  row_number =15;

        #27$finish; // end simulation
end

// always @(clock) begin
// $display("CLK= %b,time=%d\n",clock,$time);
// end
always @(posedge output_bit) begin
    $display("time:%d, row_number=%d, value:%d\n",$time,row_number,word_out1);

end

always
    begin
    #5 clock = ~clock;
    end
endmodule
