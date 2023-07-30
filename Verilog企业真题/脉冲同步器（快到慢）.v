`timescale 100ps/100ps

module pulse_detect(
	input 				clka	, 
	input 				clkb	,   
	input 				rst_n		,
	input				sig_a		,

	output  	        sig_b
);
reg sig_a1,sig_a2,sig_a3,sig_a4;
wire xor1;

assign xor1=sig_a^sig_a1;

always @(posedge clka or negedge rst_n)
begin
if(!rst_n)
sig_a1<=0;
else
sig_a1<=xor1;
end

always @(posedge clkb or negedge rst_n)
begin
if(!rst_n)
begin
sig_a2<=0;
sig_a3<=0;
sig_a4<=0;
end
else
begin
sig_a2<=sig_a1;
sig_a3<=sig_a2;
sig_a4<=sig_a3;
end
end

assign sig_b=sig_a3^sig_a4;
endmodule
