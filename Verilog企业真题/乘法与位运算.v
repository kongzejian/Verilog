//乘以251
`timescale 1ns/1ns

module dajiang13(
    input  [7:0]    A,
    output [15:0]   B
	);

//*************code***********//
assign B=(A<<8)-(A<<2)-A;
//*************code***********//

endmodule
