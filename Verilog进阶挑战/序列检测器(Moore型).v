`timescale 1ns/1ns

module det_moore(
   input                clk   ,
   input                rst_n ,
   input                din   ,
 
   output	reg         Y   
);
reg [3:0] buffer;
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
buffer<=0;
else
buffer<={buffer[2:0],din};
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
Y<=0;
else if(buffer==4'b1101)
Y<=1;
else
Y<=0;
end
endmodule
