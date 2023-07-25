//莫名奇妙number要打一拍，可能是为了zero正好在number为0的时候输出
`timescale 1ns/1ns

module count_module(
	input clk,
	input rst_n,
	input mode,
	output reg [3:0]number,
	output reg zero
	);
reg [3:0] num;
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
number<=0;
else
number<=num;
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
num<=0;
else if(mode&&num==9)
num<=0;
else if(!mode&&num==0)
num<=9;
else if(mode)
num<=num+1;
else if(!mode)
num<=num-1;
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
zero<=0;
else if(num==0)
zero<=1;
else
zero<=0;
end
endmodule
