 module boothsalgo(mcand, mplier, clock, signal_in, product, done_signal, addOP, subOP);

    input clock, signal_in;
    input signed [31:0] mcand;  //multiplicand
    input signed [31:0] mplier; // multiplier

    output reg signed [63:0] product = 64'b0; // contains product
    output reg done_signal = 0;               // done_signal signal
    output reg [4:0] addOP = 0;              //count # addition
    output reg [4:0] subOP = 0;              //count # subtraction

    reg signed [31:0] temp_mplier;   // to store
    reg current_mplier_bit;          // contains current multiplier bit, multiplier[i]
    reg [4:0] current_index = 0;     // current index , i
    reg previous_mplier_bit = 0;     // previous bit, multiplier[i-1]

//initalizing for every new input to calculate product
    always @(posedge signal_in) begin
        done_signal <= 0;          // make done_signal 0 after getting new input
        addOP <= 0;                // initalize add count 0
        subOP <= 0;                // initalize sub count 0
        product <= 64'b0;          // initalize product 0
        previous_mplier_bit <= 0;  // i-1 = 0
        current_index <= 0;        // i = 0
    end

//booth's algorithm implementation
    always @(posedge clock) begin
        current_mplier_bit <= mplier[current_index]; //multiplier[i]
        #1
        // if current bit != last bit of multiplier  then change product accordingly
        if ( previous_mplier_bit != current_mplier_bit ) begin
            // 1 to 0 transition, add multiplicand x 2^i
            if (current_mplier_bit != 1) begin
                product <= product + (mcand << current_index); // add 2^i
                addOP <= addOP + 1; // add count ++
            end
            // 0 to 1 transition , subtract multiplicand x 2^i
            else begin
                product <= product - (mcand << current_index); // subtract 2^i
                subOP <= subOP + 1; // sub count ++
            end
        end

        temp_mplier <= mplier >>> (current_index + 1); // for termination
        #1
        // termination process
        if (current_index == 32 - 1) begin // if last bit of product reached
            done_signal <= 1;
        end
        // multiplication ends
        if (current_mplier_bit == 1) begin
            if(temp_mplier == -1) begin // terminate
                done_signal <= 1;
            end
        end
        else begin
            if (temp_mplier == 0) begin // terminate
                done_signal <= 1;
            end
        end

        //to move to next iteration
        current_index <= current_index + 1; // i ++
        previous_mplier_bit <= current_mplier_bit; // curr bit stored as prv bit for next iteration

    end

endmodule
