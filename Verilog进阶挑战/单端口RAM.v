//enb为1的时候写，enb为0的时候读
`timescale 1ns/1ns

module RAM_1port(
    input clk,
    input rst,
    input enb,
    input [6:0]addr,
    input [3:0]w_data,
    output wire [3:0]r_data
);
//*************code***********//
reg [3:0] ram [127:0];
integer i;
always @(posedge clk or negedge rst)
begin
if(!rst)
begin
for(i=0;i<128;i=i+1)
ram[i]=0;
end
else if(enb)
ram[addr]<=w_data;
end

assign r_data=(!enb)?ram[addr]:0;
//*************code***********//
endmodule
