`timescale 1ns/1ns
module edge_detect(
	input clk,
	input rst_n,
	input a,
	
	output reg rise,
	output reg down
);
reg a_delay;
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
a_delay<=0;
else
a_delay<=a;
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
begin
rise<=0;
down<=0;
end
  else if(a&!a_delay) //下面这段代码是为了实现a出现不确定的状态，rise和down都为0的功能
rise<=1;
else if(!a&a_delay)
down<=1;
else
begin
rise<=0;
down<=0;
end
end

endmodule
