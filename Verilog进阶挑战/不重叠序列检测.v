这个题目有个trick，计数器从0计数到5再返回0，但在一开始的时候，复位的时候计数器和缓存都是0，在计数器为1的时候，缓存才进第一个数，
计数器计到5时，缓存中只有5个数，要到下一周期的0的时候，缓存才满6个数。所以缓存中有效数据实际对应计数器的1，2，3，4，5，0。
给match和not_match赋值的时候，理论上应该在count=0的时候用组合逻辑判断，但是如果这么做，在复位的时候not_match就会拉高，这是不符合时序的，所以trick就是在count
=5的时候，结合刚进来的数{cache[4:0], data}进行判断

`timescale 1ns/1ns
module sequence_detect(
	input clk,
	input rst_n,
	input data,
	output reg match,
	output reg not_match
	);
reg [5:0] cache;
reg [2:0] count;

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
count<=0;
else if(count==5)
count<=0;
else
count<=count+1;
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
cache<=0;
else if(count==0)
cache<=data;
else
cache<={cache[4:0],data};
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
begin
match<=0;
not_match<=0;
end
else
begin
match<= (count==5) && ({cache[4:0], data}==6'b011100);
not_match <= (count==5) && ({cache[4:0], data}!=6'b011100);
end
end

endmodule
