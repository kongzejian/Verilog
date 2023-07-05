`timescale 1ns/1ns

module top_module( 
    input [3:0] a, b, c, d, e, 
    input [2:0] sel,
    output reg [3:0] out );
    always @(*)
    begin
    case(sel)
    0: out=a;
    1: out=b;
    2: out=c;
    3: out=d;
    4: out=e;
    endcase
    end
endmodule
