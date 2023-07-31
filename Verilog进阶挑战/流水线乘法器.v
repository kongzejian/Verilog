//答案要求第两个周期内出结果

`timescale 1ns/1ns

module multi_pipe#(
	parameter size = 4
)(
	input 						clk 		,   
	input 						rst_n		,
	input	[size-1:0]			mul_a		,
	input	[size-1:0]			mul_b		,
 
 	output	reg	[size*2-1:0]	mul_out		
);
integer i,j,k;
reg [size*2-1:0] temp [size-1:0];
reg [size*2-1:0] out [size-1:0];
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
begin
for(i=0;i<size;i=i+1)
temp[i]<=0;
end
else
begin
for(j=0;j<size;j=j+1)
begin
if(mul_b[j]==1)
temp[j]<=({{size{1'b0}},mul_a}<<j);
else
temp[j]<=0;
end
end
end

  always @(*)
begin
if(!rst_n)
begin
for(k=0;k<size;k=k+1)
out[k]<=0;
end
else 
begin
for(k=0;k<size;k=k+1)
begin
if(k==0)
out[0]<=temp[0];
else
out[k]<=out[k-1]+temp[k];
end
end
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
mul_out<=0;
else
mul_out<=out[size-1];
end
endmodule

