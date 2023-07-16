全减器
A B CI D CO
0 0 0  0  0
0 0 1  1  1
0 1 0  1  1
0 1 1  0  1
1 0 0  1  0
1 0 1  0  0
1 1 0  0  0
1 1 1  1  1

低位向本位结尾：Ci=1;A=A-1；若本位向高位借位A+2
比如最后一行，因为Ci=1,,A=1-1=0,因为B=1，不够减，向高位借位A=1-1+2=2，D=A-B=1
`timescale 1ns/1ns

module decoder_38(
   input             E      ,
   input             A0     ,
   input             A1     ,
   input             A2     ,
   
   output reg       Y0n    ,  
   output reg       Y1n    , 
   output reg       Y2n    , 
   output reg       Y3n    , 
   output reg       Y4n    , 
   output reg       Y5n    , 
   output reg       Y6n    , 
   output reg       Y7n    
);
always @(*)begin
   if(!E)begin
      Y0n = 1'b1;
      Y1n = 1'b1;
      Y2n = 1'b1;
      Y3n = 1'b1;
      Y4n = 1'b1;
      Y5n = 1'b1;
      Y6n = 1'b1;
      Y7n = 1'b1;
   end  
   else begin
      case({A2,A1,A0})
         3'b000 : begin
                     Y0n = 1'b0; Y1n = 1'b1; Y2n = 1'b1; Y3n = 1'b1; 
                     Y4n = 1'b1; Y5n = 1'b1; Y6n = 1'b1; Y7n = 1'b1;
                  end 
         3'b001 : begin
                     Y0n = 1'b1; Y1n = 1'b0; Y2n = 1'b1; Y3n = 1'b1; 
                     Y4n = 1'b1; Y5n = 1'b1; Y6n = 1'b1; Y7n = 1'b1;
                  end 
         3'b010 : begin
                     Y0n = 1'b1; Y1n = 1'b1; Y2n = 1'b0; Y3n = 1'b1; 
                     Y4n = 1'b1; Y5n = 1'b1; Y6n = 1'b1; Y7n = 1'b1;
                  end 
         3'b011 : begin
                     Y0n = 1'b1; Y1n = 1'b1; Y2n = 1'b1; Y3n = 1'b0; 
                     Y4n = 1'b1; Y5n = 1'b1; Y6n = 1'b1; Y7n = 1'b1;
                  end 
         3'b100 : begin
                     Y0n = 1'b1; Y1n = 1'b1; Y2n = 1'b1; Y3n = 1'b1; 
                     Y4n = 1'b0; Y5n = 1'b1; Y6n = 1'b1; Y7n = 1'b1;
                  end 
         3'b101 : begin
                     Y0n = 1'b1; Y1n = 1'b1; Y2n = 1'b1; Y3n = 1'b1; 
                     Y4n = 1'b1; Y5n = 1'b0; Y6n = 1'b1; Y7n = 1'b1;
                  end 
         3'b110 : begin
                     Y0n = 1'b1; Y1n = 1'b1; Y2n = 1'b1; Y3n = 1'b1; 
                     Y4n = 1'b1; Y5n = 1'b1; Y6n = 1'b0; Y7n = 1'b1;
                  end 
         3'b111 : begin
                     Y0n = 1'b1; Y1n = 1'b1; Y2n = 1'b1; Y3n = 1'b1; 
                     Y4n = 1'b1; Y5n = 1'b1; Y6n = 1'b1; Y7n = 1'b0;
                  end 
         default: begin
                     Y0n = 1'b1; Y1n = 1'b1; Y2n = 1'b1; Y3n = 1'b1; 
                     Y4n = 1'b1; Y5n = 1'b1; Y6n = 1'b1; Y7n = 1'b1;
                  end
      endcase  
   end 
end  
     
endmodule

module decoder1(
   input             A     ,
   input             B     ,
   input             Ci    ,
   
   output wire       D     ,
   output wire       Co         
);
wire Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7;
decoder_38 sub1(.E(1'b1),.A0(Ci),.A1(B),.A2(A),.Y0n(Y0),.Y1n(Y1),.Y2n(Y2),.Y3n(Y3),.Y4n(Y4),.Y5n(Y5),.Y6n(Y6),.Y7n(Y7));

assign D=!Y1||!Y2||!Y4||!Y7;
assign Co=!Y1||!Y2||!Y3||!Y7;

endmodule
