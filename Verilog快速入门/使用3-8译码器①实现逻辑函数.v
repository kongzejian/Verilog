`timescale 1ns/1ns

module decoder_38(
   input             E1_n   ,
   input             E2_n   ,
   input             E3     ,
   input             A0     ,
   input             A1     ,
   input             A2     ,
   
   output wire       Y0_n   ,  
   output wire       Y1_n   , 
   output wire       Y2_n   , 
   output wire       Y3_n   , 
   output wire       Y4_n   , 
   output wire       Y5_n   , 
   output wire       Y6_n   , 
   output wire       Y7_n   
);
wire E ;
assign E = E3 & ~E2_n & ~E1_n;
assign  Y0_n = ~(E & ~A2 & ~A1 & ~A0);
assign  Y1_n = ~(E & ~A2 & ~A1 &  A0);
assign  Y2_n = ~(E & ~A2 &  A1 & ~A0);
assign  Y3_n = ~(E & ~A2 &  A1 &  A0);
assign  Y4_n = ~(E &  A2 & ~A1 & ~A0);
assign  Y5_n = ~(E &  A2 & ~A1 &  A0);
assign  Y6_n = ~(E &  A2 &  A1 & ~A0);
assign  Y7_n = ~(E &  A2 &  A1 &  A0);
     
endmodule

module decoder0(
   input             A     ,
   input             B     ,
   input             C     ,
   
   output wire       L
);
wire Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7;
decoder_38 sub(.E1_n(1'b0),.E2_n(1'b0),.E3(1'b1),.A0(A),.A1(B),.A2(C),.Y0_n(Y0),
               .Y1_n(Y1),.Y2_n(Y2),.Y3_n(Y3),.Y4_n(Y4),.Y5_n(Y5),.Y6_n(Y6),.Y7_n(Y7)); //把0的行提取出来
assign L=!Y3||!Y4||!Y6||!Y7; //将0 取反后sum of product
endmodule
