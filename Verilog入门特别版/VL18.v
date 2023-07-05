`timescale 1ns/1ns

module top_module(
    input a, b, c, d, e,
	output [24:0] out
);
wire [24:0] m1,m2;
  assign m1={{5{a}},{5{b}},{5{c}},{5{d}},{5{e}}}; //拼接变量的时候，数字外面还要加一层括号别忘了
assign m2={{5{a,b,c,d,e}}};
assign out=m1~^m2;
endmodule
