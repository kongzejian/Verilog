//3个datain拼接成2个dataout


`timescale 1ns/1ns

module width_8to12(
	input 				   clk 		,   
	input 			      rst_n		,
	input				      valid_in	,
	input	[7:0]			   data_in	,
 
 	output  reg			   valid_out,
	output  reg [11:0]   data_out
);
reg [1:0] cnt;
reg [7:0] buffer;
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
cnt<=0;
else if(cnt==2&&valid_in)
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
buffer<=data_in;
else
buffer<=buffer;
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
data_out<=0;
else if(cnt==1&&valid_in)
data_out<={buffer,data_in[7:4]};
else if(cnt==2&&valid_in)
data_out<={buffer[3:0],data_in};
else
data_out<=data_out;
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
valid_out<=0;
else if((valid_in&&cnt==1)||(valid_in&&cnt==2))
valid_out<=1;
else
valid_out<=0;
end
endmodule
