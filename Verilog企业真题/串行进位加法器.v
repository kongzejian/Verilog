`timescale 1ns/1ns

module add_half(
   input                A   ,
   input                B   ,
 
   output	wire        S   ,
   output   wire        C   
);
assign S=A^B;
assign C=A&B;
endmodule

module add_full(
   input                A   ,
   input                B   ,
   input                Ci  , 

   output	wire        S   ,
   output   wire        Co   
);
wire s1,c1,c2;
add_half add_half1(.A(A),.B(B),.S(s1),.C(c1)); //s1=a^b   c1=a&&b
add_half add_half2(.A(Ci),.B(s1),.S(S),.C(c2));  //S=a^b^Ci 
assign Co=c1||c2;
endmodule

module add_4(
   input         [3:0]  A   ,
   input         [3:0]  B   ,
   input                Ci  ,
 
   output   wire [3:0]  S   ,
   output   wire        Co  
);
wire c1,c2,c3;
add_full add_full1(.A(A[0]),.B(B[0]),.Ci(Ci),.S(S[0]),.Co(c1));
add_full add_full2(.A(A[1]),.B(B[1]),.Ci(c1),.S(S[1]),.Co(c2));
add_full add_full3(.A(A[2]),.B(B[2]),.Ci(c2),.S(S[2]),.Co(c3));
add_full add_full4(.A(A[3]),.B(B[3]),.Ci(c3),.S(S[3]),.Co(Co));

endmodule
