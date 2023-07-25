//其实占空比有要求 拉高两个周期，拉低三个周期

`timescale 1ns/1ns

module odd_div (    
    input     wire rst ,
    input     wire clk_in,
    output    wire clk_out5
);
//*************code***********//
reg [2:0] cnt;
reg clk_out;
always @(posedge clk_in or negedge rst)
begin
if(!rst)
cnt<=0;
else if(cnt==4)
cnt<=0;
else
cnt<=cnt+1;
end

always @(posedge clk_in or negedge rst)
begin
if(!rst)
clk_out<=0;
else if(cnt==1||cnt==0)
clk_out<=1;
else
clk_out<=0;
end

assign clk_out5=clk_out;
//*************code***********//
endmodule
