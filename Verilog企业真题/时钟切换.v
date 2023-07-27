//一开始一直通不过是因为没有注意到触发器是下降沿触发，原时钟下降沿到来时，输出为低电平，切换，等新时钟下降沿到来时，完成切换


`timescale 1ns/1ns

module huawei6(
	input wire clk0  ,
	input wire clk1  ,
	input wire rst  ,
	input wire sel ,
	output wire clk_out
);
//*************code***********//
reg d1,d2;

always @(negedge clk0 or negedge rst)
begin
if(!rst)
d1<=0;
else
d1<=!sel&&!d2;
end

always @(negedge clk1 or negedge rst)
begin
if(!rst)
d2<=0;
else
d2<=sel&&!d1;
end

assign clk_out=(clk0&&d1)||(clk1&&d2);

//*************code***********//
endmodule
