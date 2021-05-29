//regfile where the instruction is completed

module regfile (in,clk,read_reg_addr_1,read_reg_addr_2,write_reg_addr,write_data,shift_len,signal,read_data_1, read_data_2,write_data_value);
input [2:0] in; // instruction type input
input clk;
input [4:0] read_reg_addr_1, read_reg_addr_2;
input [4:0] write_reg_addr;
input [3:0] shift_len; // 0 to 15 max , can be changed accordingly
input [15:0] write_data;
output reg signed [15:0] read_data_1;
output reg signed [15:0] read_data_2;
output reg signed [15:0] write_data_value;
output reg signal;

reg [4:0] count ;// to keep the counter of the cycles.
reg signed [15:0] inp_1,inp_2,temp_shift;
wire [15:0] ans_alu;
reg opcode;
//assign opcode = (in == 3'b110); // 0 for in= 100, 1= 110


// registor storage
reg signed [15:0] reg_file[0:31];
integer index;
//for addition
alu4 alu4_instance (
		.in1(inp_1),
		.in2(inp_2),
		.opcode(opcode),
		.ans(ans_alu)
);



always @(posedge clk ) begin

			case (in)
			     3'b000: begin
					 			signal<= 0; // i doesnot increase till the process completes
								count <= count +1; // count is incremented upto correct cycle number where the instruction should be carriead out in the sumulation
								if (count ==2) begin
								   reg_file[write_reg_addr] <= write_data; // write in the register
									 count <= 0; // so next time restart with value 0
									 signal <= 1; // so i ++ happens in top
								end
					 end

					 3'b001: begin
					 			signal<= 0;
					 			count <= count +1;
					 			if (count ==2) begin
									read_data_1 <= reg_file [read_reg_addr_1]; // read the 1st resistor for reading
									count <= 0;
							    signal <= 1;
							end
					 end
					 3'b010: begin
					    signal<= 0;
				      count <= count +1;
				      if (count ==2) begin // reading both registor in one cycle
					       read_data_1 <= reg_file [read_reg_addr_1]; // read the 1st resistor for reading
								 read_data_2 <= reg_file [read_reg_addr_2]; // read the 2nd resistor for reading
					       count <= 0;
					       signal <= 1;
			       end

					 end
					 3'b011: begin
					   signal<= 0;
						 count <= count +1;
						 if (count ==2) begin // reading one registor in one cycle
						 			read_data_1 <= reg_file [read_reg_addr_1]; // read the 1st resistor for reading
				 	 	 end
						 if (count ==4) begin // writing after 2 cycles as given in simulation
						 			reg_file[write_reg_addr] <= write_data; // write in the register
						      count <= 0;
						      signal <= 1;
						 end
					 end
					 3'b100: begin
					 	 signal<= 0;
 						 count <= count +1;
 						 if (count ==2) begin // reading both registor in one cycle
 						 			read_data_1 <= reg_file [read_reg_addr_1]; // read the 1st resistor for reading
									read_data_2 <= reg_file [read_reg_addr_2]; // read the 2nd resistor for reading
 				 	 	 end
 						 if (count ==4) begin // writing after 2 cycles as given in simulation
 						 			reg_file[write_reg_addr] <= write_data; // write in the register
 						      count <= 0;
 						      signal <= 1;
 						 end

					 end
					 3'b101: begin
					    signal<= 0;
  						 count <= count +1;
  						 if (count ==2) begin // reading both registor in one cycle
  						 			inp_1 <= reg_file [read_reg_addr_1]; // read the 1st resistor in inp_1
 									  inp_2 <= reg_file [read_reg_addr_2]; // read the 2nd resistor in inp_2
  				 	 	 end
							 if(count == 18) begin // getting summed value after 16 cycles as mentioned in simulation
							 			opcode = 0; // required sum is in ans_alu
							 end
  						 if (count ==20) begin // writing after 2 cycles as given in simulation
  						 			reg_file[write_reg_addr] <= ans_alu; //write in the register with sum
										write_data_value <= ans_alu; // just to pass to print
										count <= 0;
	 						      signal <= 1;
  					   end
					 end
					 3'b110: begin
					 		 signal<= 0;
  						 count <= count +1;
  						 if (count ==2) begin // reading both registor in one cycle
  						 			inp_1 <= reg_file [read_reg_addr_1]; // read the 1st resistor in inp_1
 									  inp_2 <= reg_file [read_reg_addr_2]; // read the 2nd resistor in inp_2
  				 	 	 end
							 if(count == 18) begin // getting difference value after 16 cycles as mentioned in simulation
							 			opcode = 1; // required difference is in ans_alu
							 end
  						 if (count ==20) begin // writing after 2 cycles as given in simulation
  						 			reg_file[write_reg_addr] <= ans_alu; // write the register with sum
										write_data_value <= ans_alu; // just to pass to print
										count <= 0;
	 						      signal <= 1;
  					   end

					 end
					 3'b111: begin
					 		 signal<= 0;
  						 count <= count +1;
  						 if (count ==2) begin // reading 1st registor in one cycle
  						 			inp_1 <= reg_file [read_reg_addr_1]; // read the 1st resistor in inp_1
 							 end
							 if(count == 18) begin // getting shifted value after 16 cycles as mentioned in simulation
							 			temp_shift <= inp_1 << shift_len; // required value in temp_shift
							 end
  						 if (count ==20) begin // writing after 2 cycles as given in simulation
  						 			reg_file[write_reg_addr] <= temp_shift; // write in the register with shift value
										write_data_value <= temp_shift; // just to pass to print in top
										count <= 0;
	 						      signal <= 1;
  					   end
					 end

			endcase
	end

			// initializing all of the register's and other tempopray variable to 0
			initial begin
			     signal = 0;
					 count =0;
			     inp_1=0;
			     inp_2=0;
			     //ans_alu=0;
			     temp_shift=0;
			     for(index = 0; index < 32; index = index + 1)
						begin
							reg_file[index]=0;
						end
			end

endmodule
