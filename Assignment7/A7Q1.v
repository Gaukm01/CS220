
module top;

	reg clk;

  reg [31:0]inst[0:7];

	reg [3:0]write_count_3;  //  for  counting inst that write to $3
	reg [3:0]write_count_4;  //  for  counting inst that write to $4
	reg [3:0]write_count_5;  //  for  counting inst that write to $5
	reg [3:0]write_count_6;  //  for  counting inst that write to $6



	reg [3:0]i_count; // for counting i inst
	reg [3:0]j_count; // for counting j inst
	reg [3:0]r_count; // for counting r inst

	reg [4:0]PC; //program counter 3 bits as there are only 8 instions at max


  initial begin

		inst[0]=32'b00100000000001000011010001010110;   //  1st instruction inilization
		inst[1]=32'b00100000000001011111111111111111;   // 2nd instruction inilization
		inst[2]=32'b00000000101001000011000000100000;   // 3rd instruction inilization
		inst[3]=32'b00100000000000110000000000000111;   // 4th instruction inilization
		inst[4]=32'b00000000110000110011000000000100;  // 5th instruction inilization
		inst[5]=32'b00000000000000110001100001000010;  // 6th instruction inilization
		inst[6]=32'b10001100100001011001101010111100;   // 7th instruction inilization
		inst[7]=32'b00001000000100100011010001010110;   // 8th instruction inilization

		PC=4'b0000;

		i_count=4'b0000;
		j_count=4'b0000;
		r_count=4'b0000;

		write_count_3=4'b0000;
		write_count_4=4'b0000;
		write_count_5=4'b0000;
		write_count_6=4'b0000;

	end

    reg [31:0] curr_inst;

	always @(posedge clk) begin

      curr_inst = inst[PC]; // to take the current instruction
			// opcode = 0 so R format
		  if(curr_inst[31:26] == 6'b000000)begin
			    r_count<=r_count+1;
					//checking the destination source and updating it's counter of that reg.
			    if(curr_inst[15:11]==5'b00011) write_count_3<=write_count_3+1;
			    else if(curr_inst[15:11]==5'b00100) write_count_4<=write_count_4+1;
			    else if(curr_inst[15:11]==5'b00101) write_count_5<=write_count_5+1;
		     	else if(curr_inst[15:11]==5'b00110) write_count_6<=write_count_6+1;
		  end

				// opcode = 0x2 and 0x3 so J format
      else if(curr_inst[31:26]==6'b000010 || curr_inst[31:26]==6'b000011)begin
		 	    j_count<=j_count+1;
	    end

				// opcode = every other value: so I format
      else begin
			    i_count<=i_count+1;
					//checking the destination source and updating it's counter of that reg
			    if(curr_inst[20:16]==5'b00011)	write_count_3<=write_count_3+1;
			    else if(curr_inst[20:16]==5'b00100) write_count_4<=write_count_4+1;
					else if(curr_inst[20:16]==5'b00101) write_count_5<=write_count_5+1;
					else if(curr_inst[20:16]==5'b00110) write_count_6<=write_count_6+1;
		end

		PC<=PC+1; // increase program counter by 1
		if (PC == 8) begin //as 8th is the last instruction.
		     $display("Number of I instructions = %d\nNumber of J instructions = %d\nNumber of R instructions = %d",i_count,j_count,r_count);
		 		 $display("Number of instructions which write to $3=%d,$4=%d,$5=%d,$6=%d",write_count_3,write_count_4,write_count_5,write_count_6);
		     $finish;
		end
	end

  initial begin
		forever begin
			clk=0;
			#5
			clk=5;
			#5
			clk=0;
		end
	end

    /*initial begin
		#80
		$display("Number of I inst = %d\nNumber of J inst = %d\nNumber of R inst = %d",i_count,j_count,r_count);
		$display("Number of insruction which write to $3=%d,$4=%d,$5=%d,$6=%d",write_count_3,write_count_4,write_count_5,write_count_6);
		#1
		$finish;
	end */

endmodule
