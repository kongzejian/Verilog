`timescale 1ns/1ns
module multi_sel(
input [7:0]d ,
input clk,
input rst,
output reg input_grant,
output reg [10:0]out
);
//*************code***********//
reg [1:0] counter;
reg [7:0] old_d;
always @(posedge clk or negedge rst)
begin
if(!rst)
begin
out<=0;
input_grant<=0;
old_d<=0;
end
else if(counter==0)
begin
out<=d;
old_d<=d;
input_grant<=1;
end
else if(counter==1)
begin
out<=((old_d<<2)-old_d);
input_grant<=0;
end
else if(counter==2)
begin
  out<=((old_d<<3)-old_d); //如果不加括号就是移位3-old_d位
input_grant<=0;
end
else if(counter==3)
begin
out<=(old_d<<3);
input_grant<=0;
end
end

always @(posedge clk or negedge rst)
begin
if(!rst)
begin
counter<=0;
end
else if(counter==3)
counter<=0;
else
counter<=counter+1;
end


//*************code***********//
endmodule






`timescale 1ns/1ns



module testbench();
	reg clk=0;
  reg rst=0;
  reg input_grant;
  reg [7:0] d;
  wire [10:0] out;
	always #5 clk = ~clk;  // Create clock with period=10
// A testbench
    initial begin
    d=143;
    #10 rst=1;
    #10 d=128;
    #10 d=129;
    #200 $finish;
    
    end
    multi_sel shit(.clk(clk),.d(d),.rst(rst),.input_grant(intput_grant),.out(out));
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
