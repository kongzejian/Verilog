//0->1->2->3->4->5->0  一个箭头对应一个数字001011
`timescale 1ns/1ns

module sequence_generator(
	input clk,
	input rst_n,
	output reg data
	);
reg [2:0] cnt; 
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
cnt<=0;
else if(cnt==5)
cnt<=0;
else
cnt<=cnt+1;
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
data<=0;
else if(cnt==2||cnt==4||cnt==5) //0-1-2-3-4-5-0
data<=1;
else
data<=0;
end
endmodule
