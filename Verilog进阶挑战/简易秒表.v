`timescale 1ns/1ns

module count_module(
	input clk,
	input rst_n,

    output reg [5:0]second,
    output reg [5:0]minute
	);
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
second<=0;
else if(minute==60)
second<=second;
else if(second==60)
second<=1;
else
second<=second+1;
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
minute<=0;
else if(second==60)
minute<=minute+1;
end
endmodule
