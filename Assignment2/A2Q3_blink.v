// `timescale 1ns / 1ps

module blink(clk,led); // input reset

    input clk;
    
    reg [14:0] counter = 25000; // 15 bit counter
    
    output  led;
    reg led = 0;            // toggles every 25000th cycle 

    always @(negedge clk) begin
        if (counter == 0) begin
            counter <= 24999;
            led <= ~led;
        end 
        
        else begin
            counter <= counter - 1;
        end
    end
endmodule
