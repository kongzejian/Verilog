
//两个注意点：1.由于d1,d2,d3只持续半个周期，在第二段组合逻辑中，else的语句必须为next_state=next_state，否则永远停留在zero状态
//2. 当rst拉低时，必须对state,next_state都初始化，不然rst拉高，state是zero，next_state未知，state<=next_state后state直接未知了
`timescale 1ns/1ns
module seller1(
	input wire clk  ,
	input wire rst  ,
	input wire d1 ,
	input wire d2 ,
	input wire d3 ,
	
	output reg out1,
	output reg [1:0]out2
);
//*************code***********//
parameter zero=0,half=1,one=2,one_half=3,two=4,two_half=5,three=6;
reg [2:0] state,next_state;
always @(posedge clk or negedge rst)
begin
if(!rst)
begin
state<=zero;
next_state<=zero;
end
else
state<=next_state;
end

always @(*)
begin
case(state)
zero:
begin 
if({d1,d2,d3}==3'b100)
next_state=half;
else if({d1,d2,d3}==3'b010)
next_state=one;
else if({d1,d2,d3}==3'b001)
next_state=two;
else
next_state=next_state;
end
half:
begin       
if({d1,d2,d3}==3'b100)
next_state=one;
else if({d1,d2,d3}==3'b010)
next_state=one_half;
else if({d1,d2,d3}==3'b001)
next_state=two_half;
else
next_state=next_state;
end
one:
begin       
if({d1,d2,d3}==3'b100)
next_state=one_half;
else if({d1,d2,d3}==3'b010)
next_state=two;
else if({d1,d2,d3}==3'b001)
next_state=three;
else if({d1,d2,d3}==3'b000)
next_state=next_state;
end
one_half:
begin       
next_state=zero;
end
two:
begin       
next_state=zero;
end
two_half:
begin
next_state=zero;
end
three:
begin
next_state=zero;
end
endcase
end

always @(posedge clk or negedge rst)
begin
if(!rst)
begin
out1<=0;
out2<=0;
end
else if(next_state==one_half)
begin
out1<=1;
out2<=0;
end
else if(next_state==two)
begin
out1<=1;
out2<=1;
end
else if(next_state==two_half)
begin
out1<=1;
out2<=2;
end
else if(next_state==three)
begin
out1<=1;
out2<=3;
end
else
begin
out1<=0;
out2<=0;
end
end
//*************code***********//
endmodule
