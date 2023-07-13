`timescale 1ns/1ns

module data_cal(
input clk,
input rst,
input [15:0]d,
input [1:0]sel,

output reg[4:0]out,
output reg validout
);
//*************code***********//
reg [15:0] valid_input;
initial begin   //初始化
out=0;
validout=0;
end
always @(posedge clk)
begin
if(!rst)
validout<=0;
else if(sel==0)
begin
validout<=0;
valid_input<=d;
end
else
validout<=1;
end

always @(posedge clk)
begin
if(!rst)
out<=0;
else if(sel==1)
out<=valid_input[3:0]+valid_input[7:4];
else if(sel==2)
out<=valid_input[3:0]+valid_input[11:8];
else if(sel==3)
out<=valid_input[3:0]+valid_input[15:12];
else
out<=0;
end
//*************code***********//
endmodule


`timescale 1ns/1ns



module testbench();
	reg clk=0;
  reg rst=0;
  reg [15:0] d=0;
  reg [1:0]sel=0;
  wire [4:0] out;
  wire validout; 
	always #5 clk = ~clk;  // Create clock with period=10
// A testbench
  initial begin
  #10 rst=1;
  #5 d=16'b1000010000100001;
  #20 sel=2;
  d=16'b1000010000100011;
  #20 sel=1;
  #10 sel=0;
    
  #100 $finish;
  end
  data_cal shit(.clk(clk),.rst(rst),.d(d),.sel(sel),.out(out),.validout(validout));
//end    
  initial begin
    $dumpfile("out.vcd");
    // This will dump all signal, which may not be useful
    //$dumpvars;
    // dumping only this module
    //$dumpvars(1, testbench);
    // dumping only these variable
    // the first number (level) is actually useless
    $dumpvars(0, testbench);
end  
    
endmodule
