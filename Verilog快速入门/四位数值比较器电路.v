`timescale 1ns/1ns

module comparator_4(
	input		[3:0]       A   	,
	input	   [3:0]		B   	,
 
 	output	 wire		Y2    , //A>B
	output   wire        Y1    , //A=B
    output   wire        Y0      //A<B
);
  //判断两位是否相等，用同或门！！！
assign Y2=(A[3]&&!B[3])||((A[3]~^B[3])&&(A[2]&&!B[2]))||((A[3]~^B[3])&&(A[2]~^B[2])&&(A[1]&&!B[1]))||((A[3]~^B[3])&&(A[2]~^B[2])&&(A[1]~^B[1])&&(A[0]&&!B[0]));

assign Y1=(A[3]~^B[3])&&(A[2]~^B[2])&&(A[1]~^B[1])&&(A[0]~^B[0]);

assign Y0=(!A[3]&&B[3])||((A[3]~^B[3])&&(!A[2]&&B[2]))||((A[3]~^B[3])&&(A[2]~^B[2])&&(!A[1]&&B[1]))||((A[3]~^B[3])&&(A[2]~^B[2])&&(A[1]~^B[1])&&(!A[0]&&B[0]));

endmodule
