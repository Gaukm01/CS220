
// `timescale 1ns / 1ps
module rotate_top;
	
    reg clk1;
	wire [3:0] M;

	rotate uut (
		.clk(clk1),
		.led(M)
	);

	initial begin
		#3100000
		$finish;
	end

    always @(M) begin
    $display ("time : %d , M : %b " ,$time,M);
    end

    //Module to generate clock with period 10 time units
    initial begin
        forever begin
            clk1=0;
            #5
            clk1=1;
            #5
            clk1=0;
        end
    end 

 endmodule