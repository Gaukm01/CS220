

    module read (clk,row_number, valid_input,output_valid,word_out );// clock, a row number, and an input_valid bit.

    output reg output_valid;
    output reg [31:0] word_out;
    input  valid_input, clk;
    input  [3:0] row_number;
    reg [31:0] chip [0:15];
    reg[5:0] last_open;
    reg case2, case1, open_cond;

    //reg [2:0] counter = 3;
    reg var1;

    initial begin
    /* for ( i =0; i< 16; i=i+1) begin
        chip[i] = i ;
        */
        chip[0]=0;
        chip[1]=1;
        chip[2]=2;
        chip[3]=3;
        chip[4]=4;
        chip[5]=5;
        chip[6]=6;
        chip[7]=7;
        chip[8]=8;
        chip[9]=9;
        chip[10]=10;
        chip[11]=11;
        chip[12]=12;
        chip[13]=13;
        chip[14]=14;
        chip[15]=15;

    case1 = 1; // after one cycle after loading it will work
     case2 = 0;
     last_open = 20; // start
     open_cond =0;
        // word_out<=0;
    end

    // forever begin
    //     output_valid=0;
    // end
    always @(posedge clk) begin

         if (case2 == 1 ) begin // once called prv so one cycle delay
              case2 <= #1 0;
              word_out <= #1 chip[row_number];
              output_valid <= #1 1;
         end
         else if (case1 == 1) begin
              case2 <= #1 1;
              case1 <= #1 0;
         end
         else if (valid_input==1) begin
             if (last_open == row_number) begin
                 word_out <= #1 chip[row_number];
                 output_valid <= #1 1;
             end
             else if ( open_cond==0) begin
                 case2 <= #1 1;
                 last_open <= #1 row_number;
                 open_cond <= #1 1;
                 output_valid <= #1 0;
              end
              else begin
                 last_open <= row_number;
                 case1 <= #1 1;
                 output_valid <= #1 0;
              end
            end
            //output_valid <= #1 0;

    end

  endmodule
