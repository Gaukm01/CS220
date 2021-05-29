module min (x,step,min);
input [3:0] x;
input [1:0] step;
reg [4:0]temp;
//input [4:0] y;
output wire [3:0] min;

assign temp = (x+step);
if (temp<15)
 begin
  assign min = temp;
 end
else
 begin
  assign min =15;
 end
endmodule
