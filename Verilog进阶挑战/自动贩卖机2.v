`timescale 1ns/1ns

module seller2(
	input wire clk  ,
	input wire rst  ,
	input wire d1 ,
	input wire d2 ,
	input wire sel ,
	
	output reg out1,
	output reg out2,
	output reg out3
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
if(!sel) //买第一种饮料
begin
case(state)
zero:
begin
if({d1,d2}==2'b10)
next_state=half;
else if({d1,d2}==2'b01)
next_state=one;
else
next_state=next_state;
end
half:
begin
if({d1,d2}==2'b10)
next_state=one;
else if({d1,d2}==2'b01)
next_state=one_half;
else
next_state=next_state;
end
one:
begin
if({d1,d2}==2'b10)
next_state=one_half;
else if({d1,d2}==2'b01)
next_state=two;
else
next_state=next_state;
end
one_half:next_state=zero;
two:next_state=zero;
endcase


end


else
begin
case(state)
zero:
begin
if({d1,d2}==2'b10)
next_state=half;
else if({d1,d2}==2'b01)
next_state=one;
else
next_state=next_state;
end
half:
begin
if({d1,d2}==2'b10)
next_state=one;
else if({d1,d2}==2'b01)
next_state=one_half;
else
next_state=next_state;
end
one:
begin
if({d1,d2}==2'b10)
next_state=one_half;
else if({d1,d2}==2'b01)
next_state=two;
else
next_state=next_state;
end
one_half:
begin
if({d1,d2}==2'b10)
next_state=two;
else if({d1,d2}==2'b01)
next_state=two_half;
else
next_state=next_state;
end
two:
begin
if({d1,d2}==2'b10)
next_state=two_half;
else if({d1,d2}==2'b01)
next_state=three;
else
next_state=next_state;
end
two_half:next_state=zero;
three:next_state=zero;
endcase

end

end


always @(posedge clk or negedge rst)
begin
if(!rst)
out1<=0;
else if(!sel&&((next_state==one_half)||(next_state==two)))
out1<=1;
else
out1<=0;
end

always @(posedge clk or negedge rst)
begin
if(!rst)
out2<=0;
else if(sel&&((next_state==two_half)||(next_state==three)))
out2<=1;
else
out2<=0;
end

always @(posedge clk or negedge rst)
begin
if(!rst)
out3<=0;
else if((!sel&&next_state==two)||(sel&&next_state==three))
out3<=1;
else
out3<=0;
end

//*************code***********//
endmodule
