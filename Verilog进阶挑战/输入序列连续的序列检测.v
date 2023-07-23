`timescale 1ns/1ns
module sequence_detect(
	input clk,
	input rst_n,
	input a,
	output reg match
	);
parameter idle=0,A=1,B=2,C=3,D=4,E=5,F=6,G=7,H=8;
reg [3:0] state,next_state;
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
state<=idle;
else
state<=next_state;
end

always @(*)
begin
case(state)
idle:next_state=!a?A:idle;
A: next_state=a?B:A;
B: next_state=a?C:A;
C: next_state=a?D:A;
D: next_state=!a?E:idle;
E: next_state=!a?F:B;
F: next_state=!a?G:B;
G: next_state=a?H:A;
H: next_state=!a?A:idle;
endcase
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
match<=0;
else if(state==H)
match<=1;
else
match<=0;
end
endmodule
