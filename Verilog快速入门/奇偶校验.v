奇校验：二进制中1的个数+校验码的1或0=奇数
偶校验：二进制中1的个数+校验码的1或0=偶数

这答案搞反了
`timescale 1ns/1ns
module odd_sel(
input [31:0] bus,
input sel,
output check
);
//*************code***********//
assign check=sel?(^bus):!(^bus);
//*************code***********//
endmodule


//测试文件：
`timescale 1ns/1ns



module testbench();
	reg clk=0;
  reg [31:0] bus=0;
  reg sel=0;
	always #5 clk = ~clk;  // Create clock with period=10
// A testbench
    initial
    begin
    #20 sel=!sel;
    bus=1;
    #20 bus=2;
    #20 sel=!sel;
    #100 $finish;
    end
//end    
  odd_sel shit(.bus(bus),.sel(sel),.check(check));
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
