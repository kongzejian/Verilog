`timescale 1ns/1ns

module top_module( 
    input a, 
    input b, 
    output c,
    output d);
assign c=!(a|b);
assign d=a|b;
endmodule
