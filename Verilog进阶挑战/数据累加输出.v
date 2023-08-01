//当valid_a（进来的数据有效），和ready_a（本模块可以接收）同时有效，本模块开始接收上游数据，并开始累加
//当累加四个数据时，valid_b（输出数据有效）拉高
//当valid_b为高，但ready_b为低，本模块要输出但是下游不肯接收，立即拉低ready_a
//当read_b为高，且valid_b为高，握手成功，下一周期valid_b拉低

`timescale 1ns/1ns

module valid_ready(
	input 				clk 		,   
	input 				rst_n		,
	input		[7:0]	data_in		,
	input				valid_a		,
	input	 			ready_b		,
 
 	output		 		ready_a		,
 	output	reg			valid_b		,
	output  reg [9:0] 	data_out
);
//valid_a用来指示数据输入data_in的有效性，valid_b用来指示数据输出data_out的有效性；
//ready_a用来指示本模块是否准备好接收上游数据，ready_b表示下游是否准备好接收本模块的输出数据

reg [1:0] cnt;

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
cnt<=0;
else if(ready_a&&valid_a) //进来的数据有效且本模块可以接收
cnt<=cnt+1;
end

assign ready_a=!(valid_b&&!ready_b);//当出去的数据有效但下游不想接收，反压ready_a


always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
data_out<=0;
else if(cnt==0&&ready_a&&valid_a)//第一个进来的有效数据
data_out<=data_in;
else if(ready_a&&valid_a)
data_out<=data_out+data_in;//第二，三，四有效数据累加
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
valid_b<=0;
else if(cnt==3&&ready_a&&valid_a)//第四个有效数据，输出有效
valid_b<=1;
else if(valid_b&&ready_b)//当下游模块准备接收本游数据，准备新的一轮
valid_b<=0;
end


endmodule
