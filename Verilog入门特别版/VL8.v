`timescale 1ns/1ns

module top_module (
	input a,
	input b,
	input c,
	input d,
	output e,
	output f );
wire w1,w2;
assign w1=a&b;
assign w2=c|d;
assign f=w1^w2;
assign e=!(w1^w2);
endmodule
