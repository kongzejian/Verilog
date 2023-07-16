//要求：键盘编码电路要有工作状态标志，以区分没有按键按下和按键0按下两种情况：按键低电平时表示被按下，GS为0表示没有按键按下，GS为1表示有按键按下
//没有按键按下，全为1，GS为0；有按键按下，有一个键是0，GS为1 
`timescale 1ns/1ns
module encoder_0(
   input      [8:0]         I_n   ,
   
   output reg [3:0]         Y_n   
);

always @(*)begin
   casex(I_n)
      9'b111111111 : Y_n = 4'b1111;
      9'b0xxxxxxxx : Y_n = 4'b0110;
      9'b10xxxxxxx : Y_n = 4'b0111;
      9'b110xxxxxx : Y_n = 4'b1000;
      9'b1110xxxxx : Y_n = 4'b1001;
      9'b11110xxxx : Y_n = 4'b1010;
      9'b111110xxx : Y_n = 4'b1011;
      9'b1111110xx : Y_n = 4'b1100;
      9'b11111110x : Y_n = 4'b1101;
      9'b111111110 : Y_n = 4'b1110;
      default      : Y_n = 4'b1111;
   endcase    
end 
     
endmodule

module key_encoder(
      input      [9:0]         S_n   ,         
 
      output wire[3:0]         L     ,
      output wire              GS
);
wire [3:0] Y;
encoder_0 sub(.I_n(S_n[9:1]),.Y_n(Y));
assign L=~Y;
assign GS=&S_n?0:1; 

endmodule
