`timescale 1ns/1ns
module encoder_83(
   input      [7:0]       I   ,
   input                  EI  ,
   
   output wire [2:0]      Y   ,
   output wire            GS  ,
   output wire            EO    
);
assign Y[2] = EI & (I[7] | I[6] | I[5] | I[4]);
assign Y[1] = EI & (I[7] | I[6] | ~I[5]&~I[4]&I[3] | ~I[5]&~I[4]&I[2]);
assign Y[0] = EI & (I[7] | ~I[6]&I[5] | ~I[6]&~I[4]&I[3] | ~I[6]&~I[4]&~I[2]&I[1]);

assign EO = EI&~I[7]&~I[6]&~I[5]&~I[4]&~I[3]&~I[2]&~I[1]&~I[0];

assign GS = EI&(I[7] | I[6] | I[5] | I[4] | I[3] | I[2] | I[1] | I[0]);
         
endmodule

module encoder_164(
   input      [15:0]      A   ,
   input                  EI  ,
   
   output wire [3:0]      L   ,
   output wire            GS  ,
   output wire            EO    
);
wire EO_1,GS_1,GS_2,EO_2;
wire [2:0] out_1,out_2;
encoder_83 sub_1(.I(A[7:0]),.EI(EI),.Y(out_1),.GS(GS_1),.EO(EO_1));
encoder_83 sub_2(.I(A[15:8]),.EI(EI),.Y(out_2),.GS(GS_2),.EO(EO_2));
assign L[3]=(!EI)?0:(GS_2&&!EO_2); //EI为0，bit4为0；EI为1，0-7位全为0 bit4为1
assign L[2:0]=(!GS_2&&EO_2)?out_1:out_2;
assign GS=GS_1||GS_2;
assign EO=EI&&EO_1&&EO_2;
endmodule



这是野路子代码，正统的是主模块的EI接入第一块的EI，主模块的EO接入第二块的EO，第一块的EO接入第二块的EI
输出的最高位为第一块的GS，后面三位是第一块与第二块后三位的或，主模块的GS为第一块GS和第二块GS的或。

当主模块EI为0时，所有都为0；
当主模块EI为1，数字为8-15时，第一块EO为0，第二块不工作，第一块GS为1，输出最高位为1；数字为0-7时，第一块EO为1，第二块工作，第一块GS为0，输出最高位为0
