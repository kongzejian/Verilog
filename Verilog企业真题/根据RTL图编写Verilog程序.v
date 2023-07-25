`timescale 1ns/1ns

module RTL(
	input clk,
	input rst_n,
	input data_in,
	output reg data_out
	);
reg data_in_reg;
wire data_out_reg0;

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
data_in_reg<=0;
else
data_in_reg<=data_in;
end

assign data_out_reg0=data_in&&!data_in_reg;

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
data_out<=0;
else
data_out<=data_out_reg0;
end

endmodule
