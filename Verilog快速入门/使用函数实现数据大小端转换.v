`timescale 1ns/1ns
module function_mod(
	input [3:0]a,
	input [3:0]b,
	output [3:0]c,
	output [3:0]d
);
assign c=convert(a);
assign d=convert(b);


function [3:0] convert;
input [3:0] i;
begin
convert[0]=i[3];
convert[1]=i[2];
convert[2]=i[1];
convert[3]=i[0];
end
endfunction
endmodule

