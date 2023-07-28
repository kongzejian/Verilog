//满足同时写，同时读
`timescale 1ns/1ns
module ram_mod(
	input clk,
	input rst_n,
	
	input write_en,
	input [7:0]write_addr,
	input [3:0]write_data,
	
	input read_en,
	input [7:0]read_addr,
	output reg [3:0]read_data
);
reg [3:0] ram [7:0];
integer i;
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
begin
for(i=0;i<8;i=i+1)
ram[i]=0;
end
else if(write_en)
ram[write_addr]<=write_data;
else
ram[write_addr]<=ram[write_addr];
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
read_data<=0;
else if(read_en)
read_data<=ram[read_addr];
else
read_data<=read_data;
end
endmodule
