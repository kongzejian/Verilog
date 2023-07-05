`timescale 1ns/1ns
module mux4_1(
input [1:0]d1,d2,d3,d0,
input [1:0]sel,
output[1:0]mux_out
);
//*************code***********//
assign mux_out=sel[0]?(sel[1]?d0:d2):(sel[1]?d1:d3);
//*************code***********//
endmodule
