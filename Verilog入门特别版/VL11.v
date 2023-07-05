`timescale 1ns/1ns

module top_module(
    input [2:0] in,
    output a,b,c
);
assign {a,b,c}=in;
endmodule
