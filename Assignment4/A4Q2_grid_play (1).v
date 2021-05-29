// `timescale 1ns / 1ps
module adder_1_bit(a, b, cin, opcode, sum, carry);
	 
	input a, b, cin;
	input opcode;
	
	output sum; 
	wire sum;
    output carry;
    wire carry;


    wire B;
    assign  B = b^opcode;

    assign sum = a ^ B ^ cin;
    assign carry = ( a & B) | (B & cin)| (a & cin);


endmodule


module adder_8_bit( a,b,sum,opcode,overflow,cout);
  output  [7:0] sum ;
  wire signed [7:0] sum;

  output  overflow ;
  wire overflow;

  output  cout;
  wire cout;


  input    [7:0] a ;
  input    [7:0] b ;
  input opcode; 

wire [6:0] carry;

	adder_1_bit bit0 (.a(a[0]), .b(b[0]), .cin(opcode), .opcode(opcode), .sum(sum[0]), .carry(carry[0]));
	adder_1_bit bit1 (.a(a[1]), .b(b[1]), .cin(carry[0]), .opcode(opcode), .sum(sum[1]), .carry(carry[1]));
	adder_1_bit bit2 (.a(a[2]), .b(b[2]), .cin(carry[1]), .opcode(opcode), .sum(sum[2]), .carry(carry[2]));
	adder_1_bit bit3 (.a(a[3]), .b(b[3]), .cin(carry[2]), .opcode(opcode), .sum(sum[3]), .carry(carry[3]));
	adder_1_bit bit4 (.a(a[4]), .b(b[4]), .cin(carry[3]), .opcode(opcode), .sum(sum[4]), .carry(carry[4]));
	adder_1_bit bit5 (.a(a[5]), .b(b[5]), .cin(carry[4]), .opcode(opcode), .sum(sum[5]), .carry(carry[5]));
	adder_1_bit bit6 (.a(a[6]), .b(b[6]), .cin(carry[5]), .opcode(opcode), .sum(sum[6]), .carry(carry[6]));
	adder_1_bit bit7 (.a(a[7]), .b(b[7]), .cin(carry[6]), .opcode(opcode), .sum(sum[7]), .carry(cout));


assign overflow=  (carry[6]^cout);

	
endmodule


module grid_play (clk,direc,step,x_out,y_out);

input [1:0] direc;// 0=north;1=east;2=south;3=west;
input [1:0] step; // number of steps
input clk;
wire [7:0] step1;
output reg [4:0] x_out;
output reg [4:0] y_out;

reg [4:0] x_curr;
reg [4:0] y_curr;
wire signed [7:0] temp;
reg opcode;
reg [7:0] now;

wire overflow,cout1;

initial begin
  x_curr = 0;
  y_curr = 0;
  x_out = 0;
  y_out = 0;
end
assign step1=step;

adder_8_bit y( .a(now),.b(step1),.opcode(opcode),.sum(temp),.overflow(overflow),.cout(cout1) );
// adder_8_bit x( .a(x_curr),.b(step),.opcode(opcode),.sum(temp),.overflow(overflow),.cout(cout1) );

always @ (posedge clk ) begin
    if (direc == 0) begin  //north
    //  min Y_n (.x(y_curr),.step(step),.min(y_out));
        opcode=0;
        now=x_curr;
        #1
        // temp = (x_curr+step);
        // $display("x_curr=%d, step=%dtemp = %d",x_curr,step,temp);
        $display(" >>>>>>------EAST-------->>>>>>>>> no of Steps : %d",step);
        if (temp<15)
          begin
          x_out = temp;
          x_curr = x_out;
          end
        else
          begin
          x_out =15;
          x_curr = x_out;
          end
    end
    else if (direc == 1) begin
      //min X_e (.x(x_curr),.step(step),.min(x_out));
      // temp = (y_curr+step);
        opcode=0;
        now=y_curr;
        #1
      $display(" ^^^^^^^------NORTH--------^^^^^^  no of Steps : %d",step);

      // $display("y_curr=%d, step=%dtemp = %d",y_curr,step,temp);
      if (temp<15)
        begin
        y_out = temp;
        y_curr = y_out;
        // $display("came here");
        end
      else
        begin
        y_out = 15;
        y_curr = y_out;
        end
    end
    else if (direc == 2) begin
      //max Y_s (.x(y_curr),.step(step),.max(y_out));
        opcode=1;
        now=x_curr;
        #1
          $display(" <<<<<<<<<<<------WEST-------<<<<<<<<<< no of Steps : %d",step);

      // temp = (x_curr-step);
            // $display("x_curr=%d, step=%dtemp = %d",x_curr,step,temp);

      if (temp>0)
        begin
        x_out = temp;
        x_curr = x_out;
        end
      else
        begin
        x_out = 0;
        x_curr = x_out;
        end
     end
    else if (direc == 3) begin
      //max X_w (.x(x_curr),.step(step),.max(x_out));
      // temp = (y_curr-step);
        opcode=1;
        now=y_curr;
        #1
            // $display("y_curr=%d, step=%dtemp = %d",y_curr,step,temp);
        $display(" *******-------SOUTH-------********** no of Steps : %d",step);

      if (temp>0)
        begin
        // $display("was here");
        y_out = temp;
        y_curr = y_out;
        end
      else
        begin
        y_out =0;
        y_curr = y_out;
        end
    end
end
endmodule
