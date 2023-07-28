//相当于米利机状态机两个状态，用out作为Buffer存储第一个数据，dataout再把第一个数据和第二个数据拼起来


`timescale 1ns/1ns

module width_8to16(
	input 				   clk 		,   
	input 				   rst_n		,
	input				      valid_in	,
	input	   [7:0]		   data_in	,
 
 	output	reg			valid_out,
	output   reg [15:0]	data_out
);
reg [7:0] out;
reg cnt;

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
cnt<=0;
  else if(cnt==1&&valid_in)    //在0和1之间切换
cnt<=0;
else if(valid_in)
cnt<=1;
else
cnt<=cnt;
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
out<=0;
else if(valid_in)
out<=data_in;
else
out<=out;
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
valid_out<=0;
  else if(cnt==1&&valid_in)   //当cnt为1且数据有效时，米利机
valid_out<=1;
else
valid_out<=0;
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
data_out<=0;
else if(cnt==1&&valid_in)
data_out<={out,data_in};
else
data_out<=data_out;
end

endmodule
