//这个时序图显示每两个周期计数器+1，trick是用5位计数器，只使用最高的那4位
`timescale 1ns/1ns

module gray_counter(
   input   clk,
   input   rst_n,

   output  reg [3:0] gray_out
);
reg [4:0] binary_cnt;

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
binary_cnt<=0;
else
binary_cnt<=binary_cnt+1;
end

always @(*)
begin
if(!rst_n)
gray_out=0;
else
gray_out=(binary_cnt[4:1])^(binary_cnt[4:1]>>1);
end
endmodule
