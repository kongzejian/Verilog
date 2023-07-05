`timescale 1ns/1ns

module top_module(
    input [15:0] in,
    output [15:0] out
);
assign out={in[3:0],in[7:4],in[11:8],in[15:12]};
endmodule
