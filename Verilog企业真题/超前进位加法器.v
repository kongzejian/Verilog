//如果用4位超前进位加法器组成16位
//C4=Pm0C0+Gm0
//C8=Pm1Pm0C0+Pm1Gm0+Gm1
//C12
//C16
`timescale 1ns/1ns

module huawei8//四位超前进位加法器
(
	input wire [3:0]A,
	input wire [3:0]B,
	output wire [4:0]OUT
);

//*************code***********//

wire [3:0] P;
wire [3:0] G;
wire [3:0] C;
Add1 sub1(.a(A[0]),.b(B[0]),.C_in(1'b0),.f(OUT[0]),.g(G[0]),.p(P[0]));
Add1 sub2(.a(A[1]),.b(B[1]),.C_in(C[0]),.f(OUT[1]),.g(G[1]),.p(P[1]));
Add1 sub3(.a(A[2]),.b(B[2]),.C_in(C[1]),.f(OUT[2]),.g(G[2]),.p(P[2]));
Add1 sub4(.a(A[3]),.b(B[3]),.C_in(C[2]),.f(OUT[3]),.g(G[3]),.p(P[3]));

CLA_4 sub5(.P(P),.G(G),.C_in(1'b0),.Ci(C[3:0]),.Gm(),.Pm());
assign OUT[4]=C[3];
//*************code***********//
endmodule



//////////////下面是两个子模块////////

module Add1
(
		input a,
		input b,
		input C_in,
		output f,
		output g,
		output p
		);
assign p=a^b;
assign g=a&b;
assign f=a^b^C_in; //S=a^b^cin  Cout=PCin+G
endmodule






module CLA_4(
		input [3:0]P,
		input [3:0]G,
		input C_in,
		output [4:1]Ci,
		output Gm,
		output Pm
	);
assign Ci[1]=P[0]&&C_in||G[0];
assign Ci[2]=P[1]&&(P[0]&&C_in||G[0])||G[1];
assign Ci[3]=P[2]&&(P[1]&&(P[0]&&C_in||G[0])||G[1])||G[2];
assign Ci[4]=P[3]&&(P[2]&&(P[1]&&(P[0]&&C_in||G[0])||G[1])||G[2])||G[3];
//C4=PmC0+Gm
assign Pm=P[0]&P[1]&P[2]&P[3];
assign Gm=G[3]|(G[1]&P[2]&P[3])|(G[0]&P[1]&P[2]&P[3]);
endmodule
