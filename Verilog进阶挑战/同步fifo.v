`timescale 1ns/1ns
/**********************************RAM************************************/
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

always @(posedge wclk) begin
	if(wenc)
		RAM_MEM[waddr] <= wdata;
end 

always @(posedge rclk) begin
	if(renc)
		rdata <= RAM_MEM[raddr];
end 

endmodule  

/**********************************SFIFO************************************/
module sfifo#(
	parameter	WIDTH = 8,
	parameter 	DEPTH = 16
)(
	input 					clk		, 
	input 					rst_n	,
	input 					winc	,
	input 			 		rinc	,
	input 		[WIDTH-1:0]	wdata	,

	output 		reg		wfull	,
	output 		reg		rempty	,
	output wire [WIDTH-1:0]	rdata
);
parameter expand_addr=$clog2(DEPTH);
reg [expand_addr:0] waddr,raddr;
wire wfull_,rempty_;
wire wen,rin;
wire waddr_h,raddr_h;
wire [expand_addr-1:0] waddr_l,raddr_l;

assign waddr_h=(waddr[expand_addr-1:0]==DEPTH-1?!waddr[expand_addr]:waddr[expand_addr]);
assign raddr_h=(raddr[expand_addr-1:0]==DEPTH-1?!raddr[expand_addr]:raddr[expand_addr]);


assign waddr_l=(waddr[expand_addr-1:0]==DEPTH-1?0:waddr[expand_addr-1:0]+1);
assign raddr_l=(raddr[expand_addr-1:0]==DEPTH-1?0:raddr[expand_addr-1:0]+1);

assign wen=winc&&!wfull;
assign rin=rinc&&!rempty;

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
waddr<=0;
else if(wen)
waddr<={waddr_h,waddr_l};
else
waddr<=waddr;
end

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
raddr<=0;
else if(rin)
raddr<={raddr_h,raddr_l};
else
raddr<=raddr;
end


assign wfull_=({!waddr[expand_addr],waddr[expand_addr-1:0]}==raddr);
assign rempty_=(waddr==raddr);

always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
begin
wfull<=0;
rempty<=0;
end
else
begin
wfull<=wfull_;
rempty<=rempty_;
end
end

dual_port_RAM #(.DEPTH(DEPTH), .WIDTH(WIDTH)) ram(
	.wclk(clk),
	.wenc(wen),
	.waddr(waddr[expand_addr-1:0]),
	.wdata(wdata),      	
	.rclk(clk),
	.renc(rin),
	.raddr(raddr[expand_addr-1:0]),
	.rdata(rdata) 	
);
endmodule
