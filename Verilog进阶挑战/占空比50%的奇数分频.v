`timescale 1ns/1ns

module odo_div_or
   (
    input    wire  rst ,
    input    wire  clk_in,
    output   wire  clk_out7
    );

//*************code***********//
reg [2:0] cnt;
reg clk_pos,clk_neg;

always @(posedge clk_in or negedge rst)
begin
if(!rst)
cnt<=0;
else if(cnt==6)
cnt<=0;
else
cnt<=cnt+1;
end

always @(posedge clk_in or negedge rst)
begin
if(!rst)
clk_pos<=0;
else if(cnt==3||cnt==6)
clk_pos<=!clk_pos;
end

always @(negedge clk_in or negedge rst)
begin
if(!rst)
clk_neg<=0;
else if(cnt==3||cnt==6)
clk_neg<=!clk_neg;
end

assign clk_out7=clk_pos||clk_neg;
//*************code***********//
endmodule
