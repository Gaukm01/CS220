// `timescale 1ns / 1ps
module rotate(clk,led); // input reset

    input clk;
    
    reg [16:0] counter = 100000; // 17 bit counter
    
    output [3:0] led;
    reg [3:0] led; 

    always @(negedge clk) begin
        if (counter == 0) begin
            counter <= 99999;
            led = 4'b1000;
            // clkout <= ~clkout;
        end 
        
        else if (counter == 25000) begin
             led <= 4'b0100;
             counter <= counter - 1;
        end
        
        else if (counter == 50000) begin
             led <= 4'b0010;
             counter <= counter - 1;
        end
        
        else if (counter == 75000) begin
             led <= 4'b0001;
             counter <= counter - 1;
        end

        else if (counter == 100000) begin
            counter <= 99999;
            led = 4'b1000;
            counter <= counter - 1;
            // clkout <= ~clkout;
        end

        else begin
            counter <= counter - 1;
        end
    end

endmodule
