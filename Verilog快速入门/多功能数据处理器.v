`timescale 1ns/1ns
module data_select(
	input clk,
	input rst_n,
	input signed[7:0]a,
	input signed[7:0]b,
	input [1:0]select,
	output reg signed [8:0]c
);
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
c<=0;
else if(select==0)
c<=a;
else if(select==1)
c<=b;
else if(select==2)
c<=a+b;
else if(select==3)
c<=a-b;
end
endmodule
