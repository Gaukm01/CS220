module a6q1_top;

    reg [2:0]in [0:10];
    //reg [2:0] in_i;
    reg clk;
    reg [4:0] read_reg_addr_1 [0:10]; // taken 10 instruction as most here can change according to the need
    //reg [4:0] read_reg_addr_1_i;
    reg [4:0] read_reg_addr_2 [0:10];
    //reg [4:0] read_reg_addr_2_i;
    reg [4:0] write_reg_addr [0:10];
    //reg [4:0] write_reg_addr_i;
    reg signed [15:0] write_data [0:10];
    //reg [15:0] write_data_i;
    reg [3:0] shift_len [0:10];
    //reg [3:0] shift_len_i;
    wire done_signal;
    wire signed [15:0] read_data_1, read_data_2, write_data_value;
    reg [4:0] i = 0 ;
    //assign done_signal = 0;

    regfile uut(.in(in[i]),.clk(clk),.read_reg_addr_1(read_reg_addr_1[i]),.read_reg_addr_2(read_reg_addr_2[i]),.write_reg_addr(write_reg_addr[i]),.write_data(write_data[i]),.shift_len(shift_len[i]),.signal(done_signal),.read_data_1(read_data_1), .read_data_2(read_data_2), .write_data_value(write_data_value));

    //test case already stored in an array
    initial begin
     #3
     in[0] = 3'b000;
     write_reg_addr[0] = 1;
     write_data[0] = 17;

     //#10
     in[1] = 3'b011;
     read_reg_addr_1[1] = 1;
     write_reg_addr[1] = 2;
     write_data[1] = -9;

     //#10
     in[2] = 3'b100;
     read_reg_addr_1[2] = 1;
     read_reg_addr_2[2] = 2;
     write_reg_addr[2] = 3;
     write_data[2] = 65;
     //shift_len= x;

     //#10
     in[3] = 3'b010;
     read_reg_addr_1[3] = 2 ;
     read_reg_addr_2[3] = 3;

    // #10
     in[4] = 3'b111;
     read_reg_addr_1[4] = 3;
     write_reg_addr[4] = 5;
     shift_len[4]= 3;

     //#10
     in[5] = 3'b101;
     read_reg_addr_1[5] = 1;
     read_reg_addr_2[5] = 2;
     write_reg_addr[5] = 4;

     //#10
     in[6] = 3'b111;
     read_reg_addr_1[6] = 4;
     write_reg_addr[6] = 4;
     shift_len[6]= 9;

    // #10
     in[7] = 3'b110;
     read_reg_addr_1[7] = 5 ;
     read_reg_addr_2[7] = 4;
     write_reg_addr[7] = 6;


     //#10
     in[8] = 3'b001;
     read_reg_addr_1[8] = 6 ;
  // $finish;
    end

    always
     begin
         clk = 0;
         #5
         clk =1;
         #5
         clk =0;
    end

    always @ (posedge clk) begin
          //done_signal = 0;
          //output when the process ends.
          if ( done_signal ==1) begin
              case ( in[i])
                3'b000:$display ("Instruction executed : %b\n", in[i]);
                3'b001: begin
                      $display ("Instruction executed : %b", in[i]);
                      $display ("Time: %d, Register_address: %d , read_value: %d\n", $time,read_reg_addr_1[i],read_data_1);
                end
                3'b010: begin
                      $display ("Instruction executed : %b", in[i]);
                      $display ("Time: %d, Register_address_1: %d , read_value_1: %d,  Register_address_2: %d , read_value_2: %d\n ",$time, read_reg_addr_1[i],read_data_1,read_reg_addr_2[i],read_data_2);
                end
                3'b011: begin
                      $display ("Instruction executed : %b", in[i]);
                      $display ("Time: %d, Register_address: %d , read_value: %d\n ", $time,read_reg_addr_1[i],read_data_1);
                end
                3'b100: begin
                      $display ("Instruction executed : %b", in[i]);
                      $display ("Time: %d, Register_address_1: %d , read_value_1: %d, Register_address_2: %d , read_value_2: %d\n ", $time,read_reg_addr_1[i],read_data_1,read_reg_addr_2[i],read_data_2);
                end
                3'b101: begin
                      $display ("Instruction executed : %b", in[i]);
                      $display ("Time: %d, Register_address: %d , write_value: %d\n",$time, write_reg_addr[i],write_data_value);
                end
                3'b110: begin
                      $display ("Instruction executed : %b", in[i]);
                      $display ("Time: %d, Register_address: %d , write_value: %d\n",$time, write_reg_addr[i],write_data_value);
                end
                3'b111: begin
                      $display ("Instruction executed : %b", in[i]);
                      $display ("Time: %d, Register_address: %d , write_value: %d\n",$time, write_reg_addr[i],write_data_value);
                end
              endcase
              i<=i+1;
          end
          if (i==9) $finish;

    end

    initial begin
      #10000 $finish;
    end

endmodule
