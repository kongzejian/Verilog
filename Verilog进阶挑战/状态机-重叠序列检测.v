`timescale 1ns/1ns

module sequence_test2(
	input wire clk  ,
	input wire rst  ,
	input wire data ,
	output reg flag
);
//*************code***********//
parameter idle=0,A=1,B=2,C=3,D=4;
reg [2:0] state,next_state;
always @(posedge clk or negedge rst)
begin
if(!rst)
state<=idle;
else
state<=next_state;
end

always @(*)
begin
case(state)
idle:next_state=data?A:idle;
A:next_state=!data?B:A;  //1
B:next_state=data?C:idle;  //10
C:next_state=data?D:B;
D:next_state=data?A:B;
endcase
end

always @(posedge clk or negedge rst)
begin
if(!rst)
flag<=0;
else if(state==D)
flag<=1;
else
flag<=0;
end
//*************code***********//
endmodule
