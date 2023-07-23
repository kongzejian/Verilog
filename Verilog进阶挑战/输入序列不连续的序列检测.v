`timescale 1ns/1ns
module sequence_detect(
	input clk,
	input rst_n,
	input data,
	input data_valid,
	output reg match
	);
reg [3:0] cache;

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
cache<=0;
else if(data_valid)
cache<={cache[2:0],data};
else
cache<=cache;
end


always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
match<=0;
else if(data_valid&&{cache[2:0],data}==4'b0110)
match<=1;
else
match<=0;
end
endmodule
