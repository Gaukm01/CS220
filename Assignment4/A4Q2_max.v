module max (x,step,max);
input [3:0] x;
input [1:0] step;
reg [4:0] temp;
//reg [4:0] y = 0;
output wire [3:0] max;

assign temp=(x-step);
if (temp>=0)
 begin
   assign max = temp;
 end
else
 begin
   assign max =0;
 end
endmodule
