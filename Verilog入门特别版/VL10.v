`timescale 1ns/1ns

module top_module (
	input a,
	input b,
	input c,
	input d,
	output e,
	output f );
assign e=!((a&b)^(c^d));
assign f=((a&b)^(c^d))|d;

endmodule
