`timescale 1ns/1ns

/***************************************RAM*****************************************/
module dual_port_RAM #(parameter DEPTH = 16,
					   parameter WIDTH = 8)(
	 input wclk
	,input wenc
	,input [$clog2(DEPTH)-1:0] waddr  //深度对2取对数，得到地址的位宽。
	,input [WIDTH-1:0] wdata      	//数据写入
	,input rclk
	,input renc
	,input [$clog2(DEPTH)-1:0] raddr  //深度对2取对数，得到地址的位宽。
	,output reg [WIDTH-1:0] rdata 		//数据输出
);
reg [WIDTH-1:0] RAM_MEM [0:DEPTH-1];

always @(posedge wclk) 
begin
if(wenc)
RAM_MEM[waddr] <= wdata;
end 

always @(posedge rclk) 
begin
if(renc)
rdata <= RAM_MEM[raddr];
end 
endmodule  

/***************************************AFIFO*****************************************/
module asyn_fifo#(
	parameter	WIDTH = 8,
	parameter 	DEPTH = 16
)(
	input 					wclk	, 
	input 					rclk	,   
	input 					wrstn	,
	input					rrstn	,
	input 					winc	,
	input 			 		rinc	,
	input 		[WIDTH-1:0]	wdata	,

	output wire				wfull	,
	output wire				rempty	,
	output wire [WIDTH-1:0]	rdata
);
parameter addr_expand=$clog2(DEPTH);
reg [addr_expand:0] waddr,raddr;
reg [addr_expand:0] gray_waddr,gray_raddr;
reg [addr_expand:0] gray_waddr_flip1, gray_waddr_flip2,gray_raddr_flip1,gray_raddr_flip2;

always @(posedge wclk or negedge wrstn)
begin
if(!wrstn)
waddr<=0;
else if(winc&&!wfull)
waddr<=waddr+1;
else
waddr<=waddr;
end

always @(posedge rclk or negedge rrstn)
begin
if(!rrstn)
raddr<=0;
else if(rinc&&!rempty)
raddr<=raddr+1;
else
raddr<=raddr;
end

always @(posedge wclk or negedge wrstn)
begin
if(!wrstn)
gray_waddr<=0;
else
gray_waddr<=(waddr>>1)^(waddr);
end

always @(posedge rclk or negedge rrstn)
begin
if(!rrstn)
gray_raddr<=0;
else
gray_raddr<=(raddr>>1)^(raddr);
end

always @(posedge wclk or negedge wrstn)
begin
if(!wrstn)
begin
gray_waddr_flip1<=0;
gray_waddr_flip2<=0;
end
else
begin
gray_waddr_flip1<=gray_waddr;
gray_waddr_flip2<=gray_raddr_flip1;
end
end

always @(posedge rclk or negedge rrstn)
begin
if(!rrstn)
begin
gray_raddr_flip1<=0;
gray_raddr_flip2<=0;
end
else
begin
gray_raddr_flip1<=gray_raddr;
gray_raddr_flip2<=gray_raddr_flip1;
end
end

assign rempty=(gray_waddr_flip2==gray_raddr);
  assign wfull=({~gray_waddr[addr_expand:addr_expand-1],gray_waddr[addr_expand-2:0]}==gray_raddr_flip2); //最高位次高位相反，后几位相同

wire wen,ren;
assign wen=winc&&!wfull;
assign ren=rinc&&!rempty;
dual_port_RAM #(.DEPTH(DEPTH),.WIDTH(WIDTH)) ram(
	 .wclk(wclk)
	,.wenc(wen)
	,.waddr(waddr[addr_expand-1:0])
	,.wdata(wdata)      	
	,.rclk(rclk)
	,.renc(ren)
	,.raddr(raddr[addr_expand-1:0])
	,.rdata(rdata) 		
);
endmodule
