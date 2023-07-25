`timescale 1ns/1ns

module fsm1(
	input wire clk  ,
	input wire rst  ,
	input wire data ,
	output reg flag
);
//*************code***********//
parameter s0=0,s1=1,s2=2,s3=3;
reg [1:0] state,next_state;
always @(posedge clk or negedge rst)
begin
if(!rst)
state<=s0;
else
state<=next_state;
end

always @(*)
begin
case(state)
s0:next_state=data?s1:s0;
s1:next_state=data?s2:s1;
s2:next_state=data?s3:s2;
s3:next_state=data?s0:s3;
endcase
end

always @(posedge clk or negedge rst)
begin
if(!rst)
flag<=0;
else if(state==s3&&data==1)
flag<=1;
else
flag<=0;
end
//*************code***********//
endmodule
