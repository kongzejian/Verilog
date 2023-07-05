`timescale 1ns/1ns

module top_module(
	input [2:0] a, 
	input [2:0] b, 
	output [2:0] c,
	output d
);
assign c=a|b;
assign d=a||b;

endmodule
