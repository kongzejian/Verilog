//可以使用在generate语句中的类型主要有：module（模块）;UDP（用户自定义原语）;门级原语连续赋值语句;initial或always语句
`timescale 1ns/1ns
module gen_for_module( 
    input [7:0] data_in,
    output [7:0] data_out
);
genvar i;
generate
for(i=0;i<=7;i=i+1)
begin: assign_data_out
  assign data_out[i]=data_in[7-i]; //必须使用assign
end
endgenerate
endmodule
