`timescale 1ns/1ns

module pulse_detect(
	input 				clk_fast	, 
	input 				clk_slow	,   
	input 				rst_n		,
	input				data_in		,

	output  		 	dataout
);
reg level_signal,flip1,flip2,flip3;
wire xor_output;

assign xor_output=data_in^level_signal;
always @(posedge clk_fast or negedge rst_n)
begin
if(!rst_n)
level_signal<=0;
else
level_signal<=xor_output;
end

always @(posedge clk_slow or negedge rst_n)
begin
if(!rst_n)
begin
flip1<=0;
flip2<=0;
flip3<=0;
end
else
begin
flip1<=level_signal;
flip2<=flip1;
flip3<=flip2;
end
end

assign dataout=flip2^flip3;
endmodule
