module A11Q2_top;

reg [31:0] dividend;
reg [31:0] divisor;
reg signed [6:0] divdnd_len;
reg signed [6:0] divsr_len;
reg clk;
reg inp_signal;

wire [31:0] quotient;
wire signed [31:0] remainder;
wire [4:0] add_count;
wire [4:0] subt_count;
wire done_signal;
reg [3:0] i = 0 ; // for test case count

non_restoring_divison COMPUTE(dividend, divisor, divdnd_len,divsr_len, inp_signal,clk,  add_count, subt_count, quotient, remainder, done_signal);

always @ (negedge clk ) begin
    if (done_signal == 1) begin
          if(divdnd_len - divsr_len < 0 )
          begin
            inp_signal = 0;
          end
          if ( i > 0)
          begin
            $display("Dividend: %d, Divisor: %d, Quotient: %d, remainder: %d\nAddition_count: %d, Subtraction_count: %d, done_signal: %d\n",dividend, divisor,quotient, remainder,add_count, subt_count, done_signal);
          end
          //test cases
          if ( i == 0)
          begin
          dividend = 203;
          divisor = 20;
          divdnd_len = 8;
          divsr_len = 5;
          inp_signal =1;
          $display("\n");
          end

          else if ( i == 1)
          begin
          dividend =15;
          divisor =3;
          divdnd_len = 4;
          divsr_len =2;
          inp_signal =1;
          $display("\n");
          end

          else if ( i == 2)
          begin
          dividend = 450;
          divisor = 33;
          divdnd_len =9;
          divsr_len =6;
          inp_signal =1;
          $display("\n");
          end

          else if ( i == 3)
          begin
          dividend = 345;
          divisor = 439;
          divdnd_len = 9;
          divsr_len = 9;
          inp_signal = 1;
          $display("\n");
          end

          else if ( i == 4)
          begin
          dividend = 3456;
          divisor = 23;
          divdnd_len = 12;
          divsr_len = 5;
          inp_signal =1;
          $display("\n");
          end

          else if ( i == 5)
          begin
          dividend = 23456;
          divisor = 234;
          divdnd_len = 15;
          divsr_len = 8;
          inp_signal =1;
          $display("\n");
          end

          else if ( i == 6)
          begin
          dividend = 30;
          divisor = 3;
          divdnd_len = 5;
          divsr_len =2;
          inp_signal =1;
          $display("\n");
          end

          else if ( i == 7)
          begin
          dividend = 99;
          divisor = 8;
          divdnd_len = 7;
          divsr_len =4;
          inp_signal = 1;
          $display("\n");
          end

          else if ( i == 8)
          begin
          dividend = 101;
          divisor = 10;
          divdnd_len = 7;
          divsr_len = 4;
          inp_signal =1;
          $display("\n");
          end

          else if ( i == 9)
          begin
          dividend = 123;
          divisor = 11;
          divdnd_len = 7;
          divsr_len = 4;
          inp_signal = 1;
          $display("\n");
          end

          else begin
          $finish;
          end

          i <= i+1; // next test case
    end
    else begin
          inp_signal = 0;
    end
end

initial begin
    forever begin
        clk <= 1;
        #5
        clk <= 0;
        #5
        clk <= 1;
    end
end

endmodule
