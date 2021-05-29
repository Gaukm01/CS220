module A4Q2_top;
wire [4:0] x_curr;
wire [4:0] y_curr;
reg [1:0] step;
reg [1:0] direc;// 0 = north,1=east; 2= south; 3= west;
reg clk;

grid_play play (.clk(clk),.direc(direc),.step(step),.x_out(x_curr),.y_out(y_curr));

always @ (negedge clk ) begin
   $display ("time: %d; Direction= %d ; Number of Steps =%d; Final Position= (%d,%d) \n",$time,direc,step,x_curr,y_curr);
end
initial begin
  //clk = 1;
   #3
   direc=3;
   step=2;
   $display("\n\n");
   #10
   direc=2;
   step=1;
   $display("\n\n");
   #10
   direc=1;
   step=3;
   $display("\n\n");
   #10
   direc=0;
   step=3;
   $display("\n\n");
   #10
   direc=0;
   step=2;
   $display("\n\n");
   #10
   direc=1;
   step=3;
   $display("\n\n");
   #10
   direc=0;
   step=2;
   $display("\n\n");
   #10
   direc=1;
   step=3;
   $display("\n\n");
   #10
   direc=0;
   step=3;
   $display("\n\n");
   #10
   direc=2;
   step=1;
   $display("\n\n");
   #10
   direc=1;
   step=2;
   $display("\n\n");
   #10
   direc=3;
   step=1;
   $display("\n\n");
   #10
   direc=2;
   step=1;
   $display("\n\n");
   #10
   direc=1;
   step=3;
   $display("\n\n");
   #10
   direc=1;
   step=3;
   $display("\n\n");
   #10
   direc=0;
   step=3;
   $display("\n\n");
   #10
   direc=0;
   step=3;
   $display("\n\n");
   #10
   direc=2;
   step=2;
   $display("\n\n");
   #10
   direc=0;
   step=3;
   $display("\n\n");
   #10
   direc=0;
   step=3;
   $display("\n\n");
   #10
   direc=3;
   step=2;
   $display("\n\n");
   #10
    #10$finish;
end
always
    begin
     clk = 0;
     #5
     clk =1;
     #5
     clk =0;
    end

endmodule
