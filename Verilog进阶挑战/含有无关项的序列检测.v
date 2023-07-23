方法一：状态机，由于中间是XXX，无法检测重复项
`timescale 1ns/1ns
module sequence_detect(
	input clk,
	input rst_n,
	input a,
	output reg match
	);
parameter idle=0,A=1,B=2,C=3,D=4,E=5,F=6,G=7,H=8,I=9;
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
idle: next_state=!a?A:idle;
A: next_state=a?B:A;
B: next_state=a?C:A;
C: next_state=D;
D: next_state=E;
E: next_state=F;
F: next_state=a?G:A;
G: next_state=a?H:A;
H: next_state=!a?I:idle;
I: next_state=!a?A:idle;
endcase
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
match<=0;
else if(state==I)
match<=1;
else
match<=0;
end

endmodule

方法二：缓存
`timescale 1ns/1ns
module sequence_detect(
	input clk,
	input rst_n,
	input a,
	output reg match
	);
reg [8:0] cache;
reg match_first3,match_last3;
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
cache<=0;
else
cache<={cache[7:0],a};
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
match_first3<=0;
else if(cache[8:6]==3'b011)
match_first3<=1;
else
match_first3<=0;
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
match_last3<=0;
else if(cache[2:0]==3'b110)
match_last3<=1;
else
match_last3<=0;
end

always @(*)
begin
match=match_first3&&match_last3;
end
endmodule
