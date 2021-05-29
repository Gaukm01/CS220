
`define TICK #2

module fsm (clk, Y, curr);

   input clk;

   input [1:0] Y; // Y is the input

   output wire [3:0]curr; // curr shows the current state

   reg [3:0] states;

   reg [2:0] micro[12:0];
   reg [3:0] dis3[3:0];
   reg [3:0] dis10[3:0];

   wire [2:0] minstr;


   initial begin
      states = 0;// taking starting state as state 0

      //microcode ROM -- array with all the states corres. Micro Instruction.
      micro[0]=0;
      micro[1]=0;
      micro[2]=0;
      micro[3]=1;
      micro[4]=3;
      micro[5]=3;
      micro[6]=0;
      micro[7]=0;
      micro[8]=0;
      micro[9]=0;
      micro[10]=2;
      micro[11]=4;
      micro[12]=4;

      //Dispatch ROM array for current state = 3
      dis3[0]= 4'b0100; // input = 00  Next State = 4
      dis3[1]= 4'b0101; // input = 01  Next State = 5
      dis3[2]= 4'b0110; // input = 10  Next State = 6
      dis3[3]= 4'b0110; // input = 11  Next State = 6

      //Dispatch ROM array for current state = 10
      dis10[0]=4'b1011; // input = 00  Next State = 11
      dis10[1]=4'b1100; // input = 01  Next State = 12
      dis10[2]=4'b1100; // input = 10  Next State = 12
      dis10[3]=4'b1100; // input = 11  Next State = 12

   end


   assign minstr = micro[states]; //Micro Instruction for multiplexer
   assign curr = states; // current state getting update ech time states change


   always @(posedge clk)

      begin

      //State Selection multiplexer implementation
      case (minstr)
      //Increment
      0: begin
      states = `TICK states + 1;
      end

      // State = 3, update state based on Input x
      1: begin
      states = `TICK dis3[Y];
      end

      // State = 10, update state based on Input x
      2: begin
      states =`TICK  dis10[Y];
      end

      // For State = 4,5; update to next state to state 7
      3: begin
      states =`TICK  4'b0111;
      end

      // For State = 11,12; update to next state to state 0
      4: begin
      states = `TICK 4'b0000;
      end

      endcase

end

endmodule
