`timescale 1ns/1ns

module even_div
    (
    input     wire rst ,
    input     wire clk_in,
    output    wire clk_out2,
    output    wire clk_out4,
    output    wire clk_out8
    );
//*************code***********//
reg [2:0] cnt;
reg clk2,clk4,clk8;
always @(posedge clk_in or negedge rst)
begin
if(!rst)
cnt<=0;
else if(cnt==7)
cnt<=0;
else
cnt<=cnt+1;
end

always @(posedge clk_in or negedge rst)
begin
if(!rst)
clk2<=0;
else
clk2<=!clk2;
end

always @(posedge clk_in or negedge rst)
begin
if(!rst)
clk4<=0;
else if(cnt==0||cnt==2||cnt==4||cnt==6)
clk4<=!clk4;
end

always @(posedge clk_in or negedge rst)
begin
if(!rst)
clk8<=0;
else if(cnt==0||cnt==4)
clk8<=!clk8;
end

assign clk_out2=clk2;
assign clk_out4=clk4;
assign clk_out8=clk8;
//*************code***********//
endmodule
