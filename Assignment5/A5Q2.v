//comparator  to compare b/w elements.
module one_bit_comparator (a,b,l_pv,g_pv,e_pv,l,g,e);
    input a,b,l_pv,g_pv,e_pv;

    output l,g,e;
    wire l,g,e;

    assign l = l_pv | (e_pv & ~a & b);
    assign g = g_pv | (e_pv & a & ~b);
    assign e = e_pv & ((a & b) | (~a & ~b));

endmodule

module three_bit_comparator (a,b,l_out,g_out,e_out);

   input [2:0]a;
   input [2:0]b;

   output l_out,g_out,e_out; // final output
   wire l_out,g_out,e_out;

   wire [3:0]l;
   wire [3:0]g;
   wire [3:0]e;

   assign l[3] = 1'b0;
   assign g[3] = 1'b0;
   assign e[3] = 1'b1;

   one_bit_comparator FA2 (a [2],b [2],l [3],g [3],e [3],l [2],g [2],e [2]);
   one_bit_comparator FA1 (a [1],b [1],l [2],g [2],e [2],l [1],g [1],e [1]);
   one_bit_comparator FA0 (a [0],b [0],l [1],g [1],e [1],l_out,g_out,e_out);

endmodule


//module to return the index of element with minimum value.
module min_return (a0,a1,a2,a3,min_index);//,clk);

input [2:0] a0;
input [2:0] a1;
input [2:0] a2;
input [2:0] a3;
//input clk;
output wire [1:0]min_index;

integer temp_min_index,i;
//wire [2:0] arr [0:3];
//wire [2:0] temp_min;
//wire [2:0] arri;

//wire l_out, g_ot, e_out;
wire l_20,l_21,l_30,l_31,l_10,l_32 ; // l_20 represents comparision b/w a2 nd a0 in given order.
wire g_20,g_21,g_30,g_31,g_10,g_32 ;
wire e_20,e_21,e_30,e_31,e_10,e_32 ;

//three_bit_comparator compare (.a(arri),.b(temp_min),.l_out(l_out),.g_out(g_out),.e_out(e_out));
three_bit_comparator compare20 (.a(a2),.b(a0),.l_out(l_20),.g_out(g_20),.e_out(e_20));
three_bit_comparator compare21 (.a(a2),.b(a1),.l_out(l_21),.g_out(g_21),.e_out(e_21));
three_bit_comparator compare30 (.a(a3),.b(a0),.l_out(l_30),.g_out(g_30),.e_out(e_30));
three_bit_comparator compare31 (.a(a3),.b(a1),.l_out(l_31),.g_out(g_31),.e_out(e_31));
three_bit_comparator compare10 (.a(a1),.b(a0),.l_out(l_10),.g_out(g_10),.e_out(e_10));
three_bit_comparator compare32 (.a(a3),.b(a2),.l_out(l_32),.g_out(g_32),.e_out(e_32));
/*always @ ( posedge clk ) begin

   arr[0]=a0; // assigning all values to a array of 4 elements to easily loop through,
   arr[1]=a1;
   arr[2]=a2;
   arr[3]=a3;
   temp_min_index=0;  // maintains index of array element wiith min values.
   temp_min= arr[0];  // maintains minimum value accessed by now.
   //#1
   //simple loop goes thorugh all elements, 0th element already mentioned
   //as minimum initially, and this minimum index and value is updated
   // upon encountring lesser value than current min value stored.
   for (i= 1 ; i<=3 ; i++)  begin
        arri=arr[i];
        if (l_out == 1) begin
            temp_min_index=i;
            temp_min= arr[temp_min_index];
        end
    end
    min_index=temp_min_index;

//end */


// let x1x0 be the index of minimum value  then;
//     x1 = (a2 < a0  && a2 < a1) || (a3 < a0 && a3 < a1)
// i.e. if either of a2,a3 is less than both a0, a1 then x1 will be one else 0
//     x0= (a1 <= a2  && a1 < a0) || (a3 < a0 && a3 < a2)
// i.e. if either of a1,a3 is less than both a0, a2 then x0 will be one else 0;
// here a1<=a2 is allowed because for same value lower one is consisdered.
assign min_index[1]= (l_20 && l_21) || (l_30 && l_31);
assign min_index[0]= (~(l_21) && l_10) || (l_30 && l_32);

endmodule
