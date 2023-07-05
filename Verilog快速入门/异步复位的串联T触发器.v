`timescale 1ns/1ns
module Tff_2 (
input wire data, clk, rst,
output reg q  
);
//*************code***********//
reg q1;
always @(posedge clk or negedge rst)
begin
if(!rst)
begin
q1<=0;
end
else if(data)
q1<=~q1;
end

always @(posedge clk or negedge rst)
begin
if(!rst)
begin
q<=0;
end
else if(q1)
q<=~q;
end

//*************code***********//
endmodule

//在verilog中，if else if执行到一个以后就不会执行其他的条件了
//测试文件：
`timescale 1ns/1ns



module testbench();
	reg clk=0;
  reg data=0;
  reg rst=0;
  reg q1=0;
	always #5 clk = ~clk;  // Create clock with period=10
// A testbench
    initial
    begin
    data=0;
    rst=0;
    q1=0;
    #10 rst=1;
    #20 data=1;
    #100 data=0;
    #130 $finish;
    end
    
    Tff_2 shit(.data(data),.clk(clk),.rst(rst),.q(q));
    
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

