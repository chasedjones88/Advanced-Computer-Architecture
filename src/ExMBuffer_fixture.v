/*
 * Module by Chase Jones
 */

`include "ExMBuffer.v"
module ExMBuffer_fixture();

reg clk, mWrite, mRead, mByte;
reg [1:0] rWrite;
reg [3:0] op1, op2;
reg [15:0] data1, op1data, op2data, r15data;

wire mWriteOut, mReadOut, mByteOut;
wire [1:0] rWriteOut;
wire [3:0] op1Out, op2Out;
wire [15:0] data1Out, op1dataOut, op2dataOut, r15dataOut;

ExMBuffer exmbuf(.clk(clk), .mWrite(mWrite), .mRead(mRead), .mByte(mByte), .rWrite(rWrite), .op1(op1), .op2(op2), .data1(data1), .op1data(op1data), .op2data(op2data), .r15data(r15data),		 .mWriteOut(mWriteOut), .mReadOut(mReadOut), .mByteOut(mByteOut), .rWriteOut(rWriteOut), .op1Out(op1Out), .op2Out(op2Out), .data1Out(data1Out), .op1dataOut(op1dataOut), .op2dataOut(op2dataOut), .r15dataOut(r15dataOut));

initial $vcdpluson;

initial clk = 1;

initial forever #5 clk = !clk;

initial $monitor("#####Input#####\nclk %b\nmW %b\tmR %b\tmB %b\nrW %b\top1 %1h\top2 %1h\nd1 %2h\top1d %2h\top2d %2h\tr15d %2h\n#####OUTPUT#####\nmW %b\tmR %b\tmB %b\nrW %b\top1 %1h\top2 %1h\nd1 %2h\top1d %2h\top2d %2h\tr15d %2h\n\n",clk, mWrite, mRead, mByte, rWrite, op1, op2, data1, op1data, op2data, r15data, mWriteOut, mReadOut, mByteOut, rWriteOut, op1Out, op2Out, data1Out, op1dataOut, op2dataOut, r15dataOut);

initial
begin
	mWrite = 0;
	mRead = 0;
	mByte = 0;
	rWrite = 2'b00;
	op1 = 4'b0000;
	op2 = 4'b0001;
	data1 = 8'ha0;
	op1data = 8'hff;
	op2data = 8'h82;
	r15data = 8'h15;

	#2

	mWrite = 1;
	mRead = 1;
	mByte = 1;
	rWrite = 2'b01;
	op1 = 4'b0001;
	op2 = 4'b0100;
	data1 = 8'h00;
	op1data = 8'hcc;
	op2data = 8'h31;
	r15data = 8'h90;

	#3	

	#10

	$finish;
end
	

endmodule
