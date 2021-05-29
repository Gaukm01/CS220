module one_bit_comparator (a,b,l_pv,g_pv,e_pv,l,g,e);
    /* l_pv,g_pv,e_pv represents compratror value for last most significant bit and
     l,g,e represents current bit comparison result*/
    input a,b,l_pv,g_pv,e_pv;

    output l,g,e;
    wire l,g,e;

    /*to remove using if...else, decuced l, g , e;
    directly in terms of other inputs */
    /* if previous value gives l_pv=1 or g_pv=1 that is directly
    passed to l or g resp. while other part is used if e_pv=1 */

    assign l = l_pv | (e_pv & ~a & b);
    assign g = g_pv | (e_pv & a & ~b);
    assign e = e_pv & ((a & b) | (~a & ~b));

endmodule
