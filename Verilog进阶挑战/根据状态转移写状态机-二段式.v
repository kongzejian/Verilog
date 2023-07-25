`timescale 1ns/1ns

module fsm2(
	input wire clk  ,
	input wire rst  ,
	input wire data ,
	output reg flag
);

//*************code***********//
parameter s0=0,s1=1,s2=2,s3=3,s4=4;
reg [2:0] state,next_state;
always @(posedge clk or negedge rst)
begin
if(!rst)
state<=s0;
else
state<=next_state;
end

always @(*)
begin
if(!rst)
flag<=0;
else
begin
case(state)
s0:begin if(data) begin next_state=s1;flag=0; end else  begin next_state=s0;flag=0;  end          end
s1:begin  if(data) begin next_state=s2;flag=0; end else  begin next_state=s1;flag=0;  end           end
s2:begin if(data) begin next_state=s3;flag=0; end else  begin next_state=s2;flag=0;  end            end
s3:begin   if(data) begin next_state=s4;flag=0; end else  begin next_state=s3;flag=0;  end          end
s4:begin  if(data) begin next_state=s1;flag=1; end else  begin next_state=s0;flag=1;  end           end
endcase
end
end
//*************code***********//
endmodule
