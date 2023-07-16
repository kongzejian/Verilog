实现真值表
1.sum of product Y=ABC+A!BC 这种 是看1的行
2. product of sum Y=(A+B+C)(!A+B+C) 是看0的行




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
assign Y0_n=!E3||E2_n||E1_n||A0||A1||A2;
assign Y1_n=!E3|E2_n||E1_n||!A0||A1||A2;
assign Y2_n=!E3||E2_n||E1_n||A0||!A1||A2;
assign Y3_n=!E3||E2_n||E1_n||!A0||!A1||A2;
assign Y4_n=!E3||E2_n||E1_n||A0||A1||!A2;
assign Y5_n=!E3||E2_n||E1_n||!A0||A1||!A2;
assign Y6_n=!E3||E2_n||E1_n||A0||!A1||!A2;
assign Y7_n=!E3||E2_n||E1_n||!A0||!A1||!A2;
endmodule
