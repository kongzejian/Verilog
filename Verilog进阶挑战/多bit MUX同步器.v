//将数据和数据有效信号寄存，然后对数据有效信号打两拍，最后选择
`timescale 1ns/1ns

module mux(
	input 				clk_a	, 
	input 				clk_b	,   
	input 				arstn	,
	input				brstn   ,
	input		[3:0]	data_in	,
	input               data_en ,

	output reg  [3:0] 	dataout
);
reg data_en1,data_en2,data_en3;
reg [3:0] data_in1;

always @(posedge clk_a or negedge arstn)
begin
if(!arstn)
begin
data_in1<=0;
data_en1<=0;
end
else
begin
data_in1<=data_in;
data_en1<=data_en;
end
end

always @(posedge clk_b or negedge arstn)
begin
if(!arstn)
begin
data_en2<=0;
data_en3<=0;
end
else
begin
data_en2<=data_en1;
data_en3<=data_en2;
end
end

always @(posedge clk_b or negedge arstn)
begin
if(!arstn)
dataout<=0;
else if(data_en3)
dataout<=data_in1;
else
dataout<=dataout;
end
endmodule
