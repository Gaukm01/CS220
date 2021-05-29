module fsm(CLK,X,Z);
input CLK,X;
output Z;
reg Z;
initial begin
    Z=1'b1;
end
reg [2:0] CS;
parameter Start = 3'b000; // define state Start with binary value 000
initial begin
    CS= Start;
end
parameter S0 = 3'b001; // define state S0 with binary value 001
parameter S1 = 3'b010; // define state S1 with binary value 010
parameter T0 = 3'b011; // define state T0 with binary value 011
parameter T1 = 3'b100; // define state T1 with binary value 100
parameter Reject = 3'b101; // define state Reject with binary value 101

// State transitions
always @ (posedge CLK)
begin
        if (CS == Start) // IF-ELSE form
            begin
                if (X == 1) CS = T0;
                else CS = S0;
            end
        else if (CS == S0)
            begin
                if (X == 0) CS = Reject;
                else CS = S1;
            end
        else if (CS == S1)
            begin
                if (X == 1) CS = Reject;
                else CS = S0;
            end
        else if (CS == T0)
            begin
                if (X == 0) CS = T1;
                else CS = Reject;
            end
        else if (CS == T1)
            begin
                if (X == 0) CS = Reject;
                else CS = T0;
            end
        else if (CS == Reject)
            begin
                CS = Reject;
            end
        else 
            begin
                CS = Reject;
                
            end
end

always @ (CS)
begin //CASE statement form
case (CS) // CASE (selector)
S0: begin
Z = 1'b1;
end
S1: begin
Z = 1'b1;
end
T0: begin
Z = 1'b1;
end
T1: begin
Z = 1'b1;
end
Reject: begin
Z = 1'b0;
end
Start: begin
Z = 1'b1;
end
endcase
end
endmodule
