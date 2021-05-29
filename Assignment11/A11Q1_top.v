module top;

reg [3:0] case_number = 0;

reg signed [31:0] mcand;
reg signed [31:0] mplier;
reg clock, signal_in;

wire signed [63:0] product;
wire done_signal;
wire [4:0] addOP;
wire [4:0] subOP;

boothsalgo MODULE(mcand, mplier, clock, signal_in, product, done_signal, addOP, subOP);

always @(negedge clock)
begin
    if (done_signal == 1)
    begin
        if (mplier == 0 || mplier == -1)
        begin
          signal_in = 0;
        end

        if (case_number > 0)
        begin
              $display("Multiplicand: %d, Multiplier: %d, Product: %d,\nAddition count: %d, Subtraction count: %d, done_signal: %d\n",mcand,mplier,product,addOP, subOP, done_signal);
        end

        if (case_number == 0)
        begin
            mcand = 20000;
            mplier = -1;
            signal_in = 1;
            $display("\n");
        end
        else if (case_number == 1)
        begin
            mcand = 113;
            mplier = 4;
            signal_in = 1;
            $display("\n");
        end
        else if (case_number == 2)
        begin
            mcand =10 ;
            mplier = 1;
            signal_in = 1;
            $display("\n");
        end
        else if (case_number == 3)
        begin
            mcand = -10;
            mplier = 4;
            signal_in = 1;
            $display("\n");
        end
        else if (case_number == 4)
        begin
            mcand = -500;
            mplier = -10;
            signal_in = 1;
            $display("\n");
        end
        else if (case_number == 5)
        begin
            mcand = 0;
            mplier = 0;
            signal_in = 1;
            $display("\n");
        end
        else if (case_number == 6)
        begin
            mcand = 10000;
            mplier = 1000;
            signal_in = 1;
            $display("\n");
        end
        else if (case_number == 7)
        begin
            mcand = 100;
            mplier = -100;
            signal_in = 1;
            $display("\n");
        end
        else if (case_number == 8)
        begin
            mcand = 123456;
            mplier = 123456;
            signal_in = 1;
            $display("\n");
        end
        else if (case_number == 9)
        begin
            mcand = 1;
            mplier = -2147483647;
            signal_in = 1;
            $display("\n");
        end
        else begin
          $finish;
        end

        case_number <= case_number + 1;// next test case
    end

    else begin
        signal_in = 0;
    end

end

initial begin
    forever begin
        clock <= 1;
        #5
        clock <= 0;
        #5
        clock <= 1;
    end
end



endmodule
