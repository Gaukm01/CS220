/* module A7Q2_top;

wire done; // max_cap reached
wire signed [7:0] OUTPUT_REG; // final output is kept here;
reg [31:0] intr_memory [0:6]; // seven intructions memory stored;
reg [2:0] MAX_PC; // maximum number of instruction;
reg clk;
reg [5:0] output_reg_addr;

//reg [2:0] fsm_state;
reg [2:0] i;

processor Execute (clk,intr_memory[0],intr_memory[1],intr_memory[2],intr_memory[3],intr_memory[4],intr_memory[5],intr_memory[6],MAX_PC, output_reg_addr,OUTPUT_REG,done);

assign done = 1'b0;
initial begin
    i =0;
    MAX_PC = 3'b111; //7 PC start with 0 and go upto 7 reaching max.
    output_reg_addr = 5'b00101; // register 5 needs to be output at last
		intr_memory[0]=32'b00100100000000010000000000101101;
		intr_memory[1]=32'b00100100000000101111111111101100;
		intr_memory[2]=32'b00100100000000111111111111000100;
		intr_memory[3]=32'b00100100000001000000000000011110;
		intr_memory[4]=32'b00000000001000100010100000100001;
		intr_memory[5]=32'b00000000011001000011000000100001;
		intr_memory[6]=32'b00000000101001100010100000100011;
end

initial begin
    forever begin
         clk = 0;
         #5
         clk = 1;
         #5
         clk = 0;
    end
end

always @ ( posedge clk ) begin
      if (done == 1'b1) begin
          $display ("Time: %d, Output register value: %d ",$time,OUTPUT_REG);
          $finish;
        end
    //  else i<=i+1;

end

endmodule
*/

`define TICK #2
`define TICK1 #3

module processor; //(clk,intr_0,intr_1,intr_2,intr_3,intr_4,intr_5,intr_6,MAX_PC, output_reg_addr,OUTPUT_REG,done);

reg clk;
//input [31:0] intr_0,intr_1,intr_2,intr_3,intr_4,intr_5,intr_6; // inputting all instructions from top or may have written all instruction here itself.
reg [2:0] MAX_PC;
reg [5:0] output_reg_addr;
//output done;
reg [7:0] OUTPUT_REG;
//reg done;
//reg signed [7:0] OUTPUT_REG;

//register file storage
reg signed [7:0] reg_file [0:31];
integer index;

reg [31:0] instr [0:6]; // all the instructions to be executed
reg [2:0] fsm_state; // stores current onoging state,
reg [2:0] PC ; // program counter;
reg [4:0] source_1; //source 1 for given instruction
reg [4:0] source_2; // source 2 for given instruction
reg [7:0] srcval_1; // value for source_1
reg [7:0] srcval_2;// value for source_2
reg [4:0] designation; // designation to write computed value for the given instruction
reg [7:0] desg_val; // computed value
reg valid; // check validity of Instruction
reg [5:0] opcode;
reg [5:0] func_code;
reg [7:0] immediate;
reg [31:0] curr_instr;
//reg [2:0] Max_PC;


initial begin
     /*instr [0]=intr_0; // may also give the value here itself if top module not used.
     instr [1]=intr_1;
     instr [2]=intr_2;
     instr [3]=intr_3;
     instr [4]=intr_4;
     instr [5]=intr_5;
     instr [6]=intr_6; */
     instr[0]=32'b00100100000000010000000000101101;
     instr[1]=32'b00100100000000101111111111101100;
     instr[2]=32'b00100100000000111111111111000100;
     instr[3]=32'b00100100000001000000000000011110;
     instr[4]=32'b00000000001000100010100000100001;
     instr[5]=32'b00000000011001000011000000100001;
     instr[6]=32'b00000000101001100010100000100011;
     MAX_PC = 3'b111; //MAX_PC;
     output_reg_addr = 5'b00101; // register 5 needs to be output at last
     valid = 0;
     fsm_state =3'b000;
     PC = 3'b000;
     //initializing all the register value to 0
     for(index = 0; index < 32; index = index + 1)
      begin
        reg_file[index]=0;
      end
end

always @ ( posedge clk ) begin
    case(fsm_state)
      //state 0
      3'b000: begin
          curr_instr <= `TICK instr[PC];
          PC <= `TICK1 PC + 1;
          fsm_state <= `TICK1 3'b001;
      end
      // state 1
      3'b001: begin
          if (curr_instr[31:26]== 6'b000000) begin //R-Format
             opcode[5:0] <= `TICK curr_instr[31:26];
             source_1 <= `TICK curr_instr[25:21];
             source_2 <= `TICK curr_instr[20:16];
             designation <= `TICK curr_instr[15:11];
             func_code <= `TICK curr_instr [5:0]; // 5 bits of shift amt left from 6:10
          end
          else begin //I -format
             opcode[5:0] <= `TICK curr_instr[31:26];
             source_1 <= `TICK curr_instr[25:21];
             designation <= `TICK curr_instr[20:16];
             immediate <= `TICK curr_instr [7:0]; // LSB part of 16 bits used to store
          end
          fsm_state <= `TICK1 3'b010;
      end

      //state 2
      3'b010: begin
          srcval_1 <= `TICK reg_file[source_1];
          srcval_2 <= `TICK reg_file[source_2];
          fsm_state <= `TICK1 3'b011;
      end

      //state 3
      3'b011: begin
          if (opcode[5:0] == 6'b000000) begin  // opcode =0
              case (func_code)
                  6'b100001: begin // addu
                      valid = 1'b0;
                      desg_val <= srcval_1 + srcval_2;
                      valid <= 1'b0; //`TICK 0;
                  end
                  6'b100011: begin //subu
                      valid = 1'b0;
                      desg_val <=  srcval_1 - srcval_2;
                       //`TICK 0;
                  end
                  default: valid = 1'b1 ; //`TICK 1;
              endcase
          end
          else begin
              if(opcode[5:0] == 6'b001001) begin //addiu
                    valid = 1'b0;
                    desg_val <=  srcval_1 + immediate;
                    //`TICK 0;
              end
              else valid = 1'b1; //`TICK 1;
          end
          fsm_state <= 3'b100; //`TICK 3'b100;
      end
      //state 4
      3'b100: begin
          if  ( valid != 1'b1 && designation != 5'b00000) begin
                reg_file[designation] <= `TICK desg_val;
          end
          if (PC < MAX_PC) fsm_state <= `TICK 3'b000;
          else fsm_state <= `TICK 3'b101;
      end

      //state 5
      3'b101: begin
          fsm_state <= `TICK 3'b101;
          OUTPUT_REG =  reg_file[output_reg_addr]; // basically storing value of $5 in output_reg
          // will be displayed in A7Q2_top
          //done <= `TICK 1'b1;
          $display ("Time: %d, Output register value: %d",$time,OUTPUT_REG);
          $finish;
      end

    endcase
end

initial begin
    forever begin
         clk = 0;
         #5
         clk = 1;
         #5
         clk = 0;
    end
end

endmodule
