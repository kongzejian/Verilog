//这个贩卖机支持马上出饮料后再下一周期内继续马上投币而不是先回到zero状态
`timescale 1ns/1ns

module sale(
   input                clk   ,
   input                rst_n ,
   input                sel   ,//sel=0,5$dranks,sel=1,10&=$drinks
   input          [1:0] din   ,//din=1,input 5$,din=2,input 10$
 
   output   reg  [1:0] drinks_out,//drinks_out=1,output 5$ drinks,drinks_out=2,output 10$ drinks
   output	reg        change_out   
);
parameter zero=0,five=1,ten=2,fifteen=3;
reg [1:0] state,next_state;

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
state<=zero;
else
state<=next_state;
end

always @(*)
begin
if(!sel)
begin
case(state)
zero:
begin 
if(din==1)
next_state=five;
else if(din==2)
next_state=ten;
else if(din==0)
next_state=zero;
end
five:
if(din==1)
next_state=five;
else if(din==2)
next_state=ten;
else if(din==0)
next_state=zero;
ten:
if(din==1)
next_state=five;
else if(din==2)
next_state=ten;
else if(din==0)
next_state=zero;
endcase
end
else
begin
case(state)
zero:
begin 
if(din==1)
next_state=five;
else if(din==2)
next_state=ten;
else if(din==0)
next_state=zero;
end
five:
begin 
if(din==1)
next_state=ten;
else if(din==2)
next_state=fifteen;
else if(din==0)
next_state=five;
end
ten:
if(din==1)
next_state=five;
else if(din==2)
next_state=ten;
else if(din==0)
next_state=zero;
fifteen:
if(din==1)
next_state=five;
else if(din==2)
next_state=ten;
else if(din==0)
next_state=zero;
endcase
end
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
drinks_out<=0;
else if(!sel&&(next_state==five||next_state==ten))
drinks_out<=1;
else if(sel&&(next_state==fifteen||next_state==ten))
drinks_out<=2;
else
drinks_out<=0;
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
change_out<=0;
else if((!sel&&next_state==ten)||(sel&&next_state==fifteen))
change_out<=1;
else
change_out<=0;
end

endmodule
