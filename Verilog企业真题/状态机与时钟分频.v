`timescale 1ns/1ns

module huawei7(
	input wire clk  ,
	input wire rst  ,
	output reg clk_out
);

//*************code***********//
reg [1:0] cnt;
always @(posedge clk or negedge rst)
begin
if(!rst)
cnt<=0;
else if(cnt==3)
cnt<=0;
else
cnt<=cnt+1;
end

always @(posedge clk or negedge rst)
begin
if(!rst)
clk_out<=0;
else if(cnt==0)
clk_out<=1;
else
clk_out<=0;
end
//*************code***********//
endmodule
