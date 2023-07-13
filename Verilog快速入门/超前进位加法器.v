
//Pi=Ai^Bi   Gi=AiBi    Si=Pi^Ci-1    Ci=Gi+Pi^Ci-1

`timescale 1ns/1ns

module lca_4(
	input		[3:0]       A_in  ,
	input	    [3:0]		B_in  ,
    input                   C_1   ,
 
 	output	 wire			CO    ,
	output   wire [3:0]	    S
);
wire G0,G1,G2,G3;
wire P0,P1,P2,P3;
wire C0,C1,C2;
assign G0=A_in[0]&&B_in[0];
assign P0=A_in[0]^B_in[0];
assign S[0]=P0^C_1;
assign C0=G0|(P0&&C_1);

assign G1=A_in[1]&&B_in[1];
assign P1=A_in[1]^B_in[1];
assign S[1]=P1^C0;
assign C1=G1|(P1&&C0);

assign G2=A_in[2]&&B_in[2];
assign P2=A_in[2]^B_in[2];
assign S[2]=P2^C1;
assign C2=G2|(P2&&C1);

assign G3=A_in[3]&&B_in[3];
assign P3=A_in[3]^B_in[3];
assign S[3]=P3^C2;
assign CO=G3|(P3&&C2);


endmodule
