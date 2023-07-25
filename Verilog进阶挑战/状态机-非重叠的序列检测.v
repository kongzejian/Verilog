`timescale 1ns/1ns

module sequence_test1(
	input wire clk  ,
	input wire rst  ,
	input wire data ,
	output reg flag
);
//*************code***********//
parameter idle=0,A=1,B=2,C=3,D=4,E=5;
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
idle:begin next_state=data?A:idle;flag=0;end
A:begin next_state=!data?B:A;flag=0; end
B:begin next_state=data?C:idle;flag=0;end
C:begin next_state=data?D:B;flag=0;end
D:begin next_state=data?E:B;flag=0;end
E:begin next_state=data?A:idle;flag=1;end
endcase
end


//*************code***********//
endmodule
