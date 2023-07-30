//a,b输入打一拍，奇奇怪怪
`timescale 1ns/1ns

module calculation(
	input clk,
	input rst_n,
	input [3:0] a,
	input [3:0] b,
	output [8:0] c
	);
reg [8:0] answer;
reg [3:0] a_,b_;

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
begin
a_<=0;
b_<=0;
end
else
begin
a_<=a;
b_<=b;
end
end
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
answer<=0;
else
answer<=(a_<<3)+(a_<<2)+b_+(b_<<2);
end

assign c=answer;
endmodule
