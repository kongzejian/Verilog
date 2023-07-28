//24*16=128*3,使用一个128的数据缓存器

`timescale 1ns/1ns

module width_24to128(
	input 				clk 		,   
	input 				rst_n		,
	input				valid_in	,
	input	[23:0]		data_in		,
 
 	output	reg			valid_out	,
	output  reg [127:0]	data_out
);
reg [3:0] cnt;
reg [127:0] buffer;
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
cnt<=0;
else if(valid_in&&cnt==15)
cnt<=0;
else if(valid_in)
cnt<=cnt+1;
else
cnt<=cnt;
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
buffer<=0;
else if(valid_in)
buffer<={buffer[103:0],data_in};
else
buffer<=buffer;
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
data_out<=0;
else if(cnt==5&&valid_in)
data_out<={buffer[119:0],data_in[23:16]};
else if(valid_in&&cnt==10)
data_out<={buffer[111:0],data_in[23:8]};
else if(valid_in&&cnt==15)
data_out<={buffer[103:0],data_in};
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
valid_out<=0;
else if(valid_in&&(cnt==5||cnt==10||cnt==15))
valid_out<=1;
else
valid_out<=0;
end
endmodule
