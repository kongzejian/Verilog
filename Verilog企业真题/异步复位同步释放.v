`timescale 1ns/1ns

module ali16(
input clk,
input rst_n,
input d,
output reg dout
 );

//*************code***********//
reg d1,d2;
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
begin
d1<=0;
d2<=0;
end
else
begin
d1<=1;
d2<=d1;
end
end


always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
dout<=0;
else if(d2)
dout<=d;
end
//*************code***********//
endmodule
