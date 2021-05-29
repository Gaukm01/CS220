
`define TICK #2
`define TICK1 #3

module processor;

reg clk;
reg [7:0] MAX_PC;
reg [5:0] output_reg_addr;
reg signed [7:0] OUTPUT_REG;

reg signed [7:0] reg_file [0:31]; // register file
integer index;

reg [31:0] instr [0:13]; // all the instructions to be executed
reg [2:0] fsm_state; // stores current onoging state,
reg [7:0] PC ; // program counter;
reg [4:0] source_1; //source 1 for given instruction ---rs
reg [4:0] source_2; // source 2 for given instruction ---rt
reg [7:0] srcval_1; // value for source_1
reg [7:0] srcval_2;// value for source_2
reg [4:0] designation; // rd----designation to write computed value for the given instruction
reg [7:0] desg_val; // computed value
reg valid; // check validity of Instruction
reg [5:0] opcode;
reg [5:0] func_code;
reg signed [15:0] immediate;
reg [31:0] curr_instr;
//reg [2:0] Max_PC;
reg [25:0] target;
reg [4:0] load_val; // for lw

reg signed [7:0] data_mem[0:10]; // Data Memomry stores the array values

initial begin

       // array value
        data_mem[0]=8;
        data_mem[1]=4;
        data_mem[2]=4;
        data_mem[3]=-10;
        data_mem[4]=6;
        data_mem[5]=10;
        data_mem[6]=-4;
        data_mem[7]=1;
        data_mem[8]=9; // extra not part of sum for n= 8
        data_mem[9]=20; // extra not part of sum for n=8
        data_mem[10]=8; // n value should be kept here.
        //to max number of loop iterations to 10
        data_mem[10] <= (data_mem[10]) > 10 ? 10: data_mem [10];

//////////////////////////////////////////////////////////////////////////
     // Instructions sets
    //sum
		instr[0]=32'b001001_00000_00010_0000000000000000;// addiu $2, $0, 0
		instr[1]=32'b001001_00000_00011_0000000000000000;// addiu $3, $0, 0
		instr[2]=32'b000000_00011_00001_00100_00000_101010;// slt $4, $3, $1
		instr[3]=32'b000100_00100_00000_0000000000001000;// beq $4, $0, exit
		instr[4]=32'b001001_00000_00101_0000000000001010;// addiu $5, $0, 10
    //loop
		instr[5]=32'b000100_00011_00101_0000000000000110;// beq $3, $5, exit
		instr[6]=32'b100011_00011_00110_0000000000000000;// lw $6, 0($3)
		instr[7]=32'b000000_00010_00110_00010_00000_100001;// addu $2, $2, $6
		instr[8]=32'b001001_00011_00011_0000000000000001;// addiu $3, $3, 1
		instr[9]=32'b000000_00011_00001_00100_00000_101010;// slt $4, $3, $1
		instr[10]=32'b000101_00100_00000_11111111_11111011;// bne $4, $0, loop
    //exit
		instr[11]=32'b000000_11111_00000_00000_00000_001000;//  jr $31
		instr[12]=32'b100011_00000_00001_0000000000001010;// lw $1, 10($0)
		instr[13]=32'b000011_00000000000000000000000000;//  jal Sum

////////////////////////////////////////////////////////////////

      PC = 8'b00001100; // start from 12
      MAX_PC = 8'b00001110; //MAX_PC;
      output_reg_addr = 5'b00010; // register 2 needs to be output at last
      valid = 0;
      fsm_state =3'b000;
      load_val=5'b00000;

///////////////////////////////////////////////////////////////

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
          //PC <= `TICK1 PC + 1;
          fsm_state <= `TICK1 3'b001;
      end


      // state 1
      3'b001: begin
      //R-Format
          if (curr_instr[31:26]== 6'b000000) begin
             opcode[5:0] <= `TICK curr_instr[31:26];
             source_1 <= `TICK curr_instr[25:21]; // rs
             source_2 <= `TICK curr_instr[20:16]; //rt
             designation <= `TICK curr_instr[15:11]; //rd
             func_code <= `TICK curr_instr [5:0];
          end

       // J- Format
          else if (curr_instr[31:26]== 6'b000011)
             begin
             opcode[5:0] <= `TICK curr_instr[31:26];
             target[25:0] <= `TICK curr_instr[25:0];
            end

      //I -format
          else begin
             opcode[5:0] <= `TICK curr_instr[31:26];
             source_1 <= `TICK curr_instr[25:21]; //rs
             source_2 <= `TICK curr_instr[20:16]; //rt
             designation <= `TICK curr_instr[20:16]; //rt
             immediate <= `TICK curr_instr [15:0]; // LSB part of 16 bits used to store
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

      /////// R -Instruction , opcode = 0

          if (opcode[5:0] == 6'b000000) begin
              case (func_code)
              // addu
                  6'b100001: begin
                      desg_val <= srcval_1 + srcval_2;
                      valid <= 1'b0;
                      PC <= PC + 1;
                  end

              // slt
                  6'b101010:
                  begin
                      valid = 1'b0;
                    desg_val <= ($signed(srcval_1) < $signed(srcval_2))?1:0;
                    PC <= PC + 1;
                  end

              // jr
                  6'b001000: begin
                     valid = 1'b0;
                     PC <= srcval_1;
                    end

                  default: valid = 1'b1 ; //`TICK 1;
              endcase
          end

     ////////   I - instructions

     //addiu
          else if(opcode[5:0] == 6'b001001) begin
                    valid = 1'b0;
                    desg_val <=  srcval_1 + immediate[7:0];
                    PC <= PC + 1;
              end

    //beq
          else if(opcode[5:0] == 6'b000100) begin
                    valid = 1'b0;
                    PC <= (srcval_1 == srcval_2) ? PC+immediate[7:0] : PC+1;
                end

    // bne
          else if(opcode[5:0] == 6'b000101) begin
                    valid = 1'b0;
                   PC <= (srcval_1 != srcval_2) ? PC+immediate [7:0] : PC+1;

            end

 ////// jal and lw ///////

      //jal
          else if(opcode[5:0] == 6'b000011) begin
                    valid = 1'b0;
                  //  PC <= immediate;
                  PC <= `TICK1 target[7:0];
                  reg_file[31]<= `TICK PC+1;
          end

     //lw
          else if(opcode[5:0] == 6'b100011) begin
                    valid = 1'b0;
                    load_val  <= srcval_1 + immediate[7:0];
                    PC <= PC + 1;

            end

        else valid = 1'b1;
          fsm_state <= 3'b100; //next state
      end


      //state 4
      3'b100: begin
          //lw
          if  (opcode == 6'b100011)
            begin
                desg_val <= `TICK data_mem[load_val];
            end
        fsm_state <= `TICK 3'b101;
      end


      //state 5
      3'b101: begin

           if  ( valid != 1'b1 && designation != 5'b00000) begin
                reg_file[designation] <= `TICK desg_val;
          end
          if (PC < MAX_PC) fsm_state <= `TICK 3'b000;
          else    fsm_state <= `TICK 3'b110;
        end


    //state 6
     3'b110: begin
          //fsm_state <= `TICK 3'b101;
          OUTPUT_REG =  reg_file[output_reg_addr]; // basically storing value of $2 in output_reg
          $display (" Output register value: %d",OUTPUT_REG);
          `TICK
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
