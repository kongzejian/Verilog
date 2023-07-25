`timescale 1ns/1ns

module add_half(
   input                A   ,
   input                B   ,
 
   output	wire        S   ,
   output   wire        C   
);
assign S = A ^ B;
assign C = A & B;
endmodule

/***************************************************************/
module add_full(
   input                A   ,
   input                B   ,
   input                Ci  , 

   output	wire        S   ,
   output   wire        Co   
);
wire S1,C1,C2;
add_half module1(.A(A),.B(B),.S(S1),.C(C1)); //S1=A^B  C1=AB
add_half module2(.A(S1),.B(Ci),.S(S),.C(C2));       //S=S1^Ci    C2=S1&&Ci
assign Co=C1||(C2);
endmodule
