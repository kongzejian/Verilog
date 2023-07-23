
要打一拍才能通过，服了
`timescale 1ns/1ns

module count_module(
	input clk,
	input rst_n,
	input set,
	input [3:0] set_num,
	output reg [3:0]number,
	output reg zero
	);
	reg [3:0] num;
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
num<=0;
else if(set)
num<=set_num;
else if(num==15)
num<=0;
else
num<=num+1;
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
number<=0;
else
number<=num;
end

always @(*)
begin
zero=(rst_n&&number==0);
end
endmodule
