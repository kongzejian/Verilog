`timescale 1ns/1ns

module encoder_83(
   input      [7:0]       I   ,
   input                  EI  ,
   
   output wire [2:0]      Y   ,
   output wire            GS  ,
   output wire            EO    
);
reg [2:0] out;
assign EO=EI&&I==0;
assign GS=EI&&I!=0;

always @(*)
begin
casex({EI,I})
9'b0xxxxxxxx:out=3'b000;
9'b100000000:out=3'b000;
9'b11xxxxxxx:out=3'b111;
9'b101xxxxxx:out=3'b110;
9'b1001xxxxx:out=3'b101;
9'b10001xxxx:out=3'b100;
9'b100001xxx:out=3'b011;
9'b1000001xx:out=3'b010;
9'b10000001x:out=3'b001;
9'b100000001:out=3'b000;
endcase
end

assign Y=out;
endmodule
