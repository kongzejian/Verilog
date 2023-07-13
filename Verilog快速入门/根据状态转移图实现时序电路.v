`timescale 1ns/1ns

module seq_circuit(
   input                C   ,
   input                clk ,
   input                rst_n,
 
   output   wire        Y   
);
parameter state_1=2'b00,state_2=2'b01,state_3=2'b11,state_4=2'b10;
reg [1:0] state,next_state;
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
state<=state_1;
else
state<=next_state;
end

always @(*)
begin
case(state)
state_1: next_state=C==0?state_1:state_2;
state_2: next_state=C==0?state_3:state_2;
state_3: next_state=C==0?state_3:state_4;
state_4: next_state=C==0?state_1:state_4;
endcase
end

assign Y=(state==state_3)||(state==state_4&&C==1);

endmodule
