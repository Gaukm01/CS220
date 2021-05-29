
 module non_restoring_divison(dividend, divisor, divdnd_len,divsr_len, inp_signal,clk,  add_count, subt_count, quotient, remainder, done_signal);

    input clk, inp_signal;
    input [31:0] dividend; // dividend
    input [31:0] divisor;  // divisor
    input signed [6:0] divdnd_len; // # bits in dividend
    input signed [6:0] divsr_len;  // # bits in divisor

    output reg [31:0] quotient = 0;         //contains quotient
    output reg signed [31:0] remainder; // contains remainder
    output reg done_signal = 1;             // done signal send back once process cmplt
    output reg [4:0] add_count = 0;         // count # addition
    output reg [4:0] subt_count= 0;        // count #subtractions

    reg start_cycle = 1;           // to track start of division process
    reg [31:0] shifted_divisor;    // to store the divisor after shift, aligned to dividend
    reg [5:0] iteration_count = 0; // count number of iteration


    //initalizing for every new input to conduct new division
    always @(posedge inp_signal) begin
        start_cycle <= 1;     // first cycle is done
        quotient <= 32'b0;    // initialize quotient 0
        remainder <= dividend;// initalize remainder equal to dividend
        add_count <= 0;       // initialize add count to 0
        subt_count <= 0;      // initalize sub count to 0
        done_signal <= 0;     // done signal made 0
        iteration_count <= 0; // initalize i = 0
    end


    // carriyng out the division
    always @(posedge clk) begin

        // if |dividend| < |divisor| => dividend itself is remainder, and quotient = 0
        if (divdnd_len -divsr_len < 0) begin
          done_signal <= 1;
        end

        //shifting divisor to align to dividend in 1st cycle
        else if (start_cycle == 1) begin
            shifted_divisor <= divisor << (divdnd_len -divsr_len); // divisor aligned
            start_cycle <= 0; //so not enter again
        end

        // carry out non restoring division process
        else begin
            // remainder  < 0 path
            if (remainder < 0) begin
                remainder <= remainder + shifted_divisor; // adding divisor to remainder
                quotient <= quotient ^ 1;                 // last bit of quotient made 0
                add_count <= add_count + 1;               // count of addn ++
            end
            // remainder > 0 path
            else begin
                remainder <= remainder - shifted_divisor; // subtracting divisor from remainder
                subt_count <= subt_count + 1;             // count of subt ++
            end

            #1 //steps in parallel
            shifted_divisor <= shifted_divisor >> 1;   // divisor shifted right
            quotient <= (quotient << 1) | 1;           // insert 1 in LSB
            iteration_count <= iteration_count + 1;    // number of iteration ++

            #1 // for last iteration , if remainder still < 0 then extra steps, then done
            if (iteration_count == divdnd_len - divsr_len + 1) begin
                //if remainder still < 0 , add divisor to it
                if (remainder < 0) begin
                  remainder <= remainder + divisor; // made remainder > 0
                  quotient <= quotient - 1;         // quotient LSB made 0
                  add_count <= add_count + 1;       // count of addn ++
                end
                #1
                done_signal <= 1; // divison complete.
            end

        end

    end

endmodule
