`timescale 1ns/1ns

module top_module(
    input [7:0] a, b, c, d,
    output [7:0] max);//
    wire [7:0] m1,m2;
    assign m1=(a>b)?a:b;
    assign m2=(c>d)?c:d;
    assign max=(m1>m2)?m1:m2;
endmodule
