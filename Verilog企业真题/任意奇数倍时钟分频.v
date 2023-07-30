//奇数分频，从0计数到divior-1，前一半位0，后一半为1
`timescale 1ns/1ns

module clk_divider
  #(parameter dividor = 5) //前2.5为0，后2.5为1 
( 	input clk_in,
	input rst_n,
	output clk_out
);
parameter bit_=$clog2(dividor);
reg [bit_-1:0] cnt;
reg clk1,clk2;
always @(posedge clk_in or negedge rst_n)
begin
if(!rst_n)
cnt<=0;
else if(cnt==(dividor-1))
cnt<=0;
else
cnt<=cnt+1;
end

always @(posedge clk_in or negedge rst_n)
begin
if(!rst_n)
clk1<=0;
else if((cnt==(((dividor-1)>>1)))||(cnt==dividor-1))
clk1<=~clk1;
else
clk1<=clk1;
end

always @(negedge clk_in or negedge rst_n)
begin
if(!rst_n)
clk2<=0;
else if((cnt==(((dividor-1)>>1)))||(cnt==dividor-1))
clk2<=~clk2;
else
clk2<=clk2;
end

assign clk_out=clk1||clk2;
endmodule
