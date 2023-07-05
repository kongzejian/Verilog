//method1:
`timescale 1ns/1ns

module top_module(
    input [15:0] in,
	output [15:0] out
);
reg [15:0] out;
integer i;
always @(*)
begin
for(i=0;i<=15;i=i+1)
    begin
    out[i]=in[15-i];
    end
end
endmodule

//method2:
`timescale 1ns/1ns

module top_module(
    input [15:0] in,
	output [15:0] out
);
genvar i;
generate
for(i=0;i<=15;i=i+1)
begin:loop
  assign out[i]=in[15-i]; //assign 别忘了加
end
endgenerate
endmodule
