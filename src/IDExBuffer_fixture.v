/*
 * Module by Chase Jones
 */

`include "IDExBuffer.v"
module IDExBuffer_fixture();

reg clk, mWrite, mRead, mByte, offsetSel;
reg [1:0] rWrite, useFunc;
reg [3:0] op1, op2, func;
reg [7:0] offset;
reg [15:0] data1, data2;

wire mWriteOut, mReadOut, mByteOut, offsetSelOut;
wire [1:0] rWriteOut, useFuncOut;
wire [3:0] op1Out, op2Out, funcOut;
wire [7:0] offsetOut;
wire [15:0] data1Out, data2Out;

IDExBuffer idexbuf(.clk(clk), .mWrite(mWrite), .mRead(mRead), .mByte(mByte), .offsetSel(offsetSel), .rWrite(rWrite), .useFunc(useFunc), .op1(op1), .op2(op2), .func(func), .data1(data1), .data2(data2), .offset(offset),		 .mWriteOut(mWriteOut), .mReadOut(mReadOut), .mByteOut(mByteOut), .offsetSelOut(offsetSelOut), .rWriteOut(rWriteOut), .useFuncOut(useFuncOut),  .op1Out(op1Out), .op2Out(op2Out), .funcOut(funcOut), .data1Out(data1Out), .data2Out(data2Out), .offsetOut(offsetOut));

initial $vcdpluson;

initial clk = 1;

initial forever #5 clk = !clk;

initial $monitor("#####Input#####\nclk %b\nmW %b\tmR %b\tmB %b\tofss %b\nrW %2b\tuF %2b\top1 %1h\top2 %1h\nd1 %2h\td2 %2h\tofs %1h\n#####OUTPUT#####\nmW %b\tmR %b\tmB %b\tofss %b\nrW %2b\tuF %2b\top1 %1h\top2 %1h\nd1 %2h\td2 %2h\tofs %1h\n\n",clk, mWrite, mRead, mByte, offsetSel, rWrite, useFunc, op1, op2, data1, data2, offset, mWriteOut, mReadOut, mByteOut, offsetSelOut, rWriteOut, useFuncOut, op1Out, op2Out, data1Out, data2Out, offsetOut);

initial
begin
	mWrite = 0;
	mRead = 0;
	mByte = 0;
	offsetSel = 0;
	rWrite = 2'b00;
	op1 = 4'b0000;
	op2 = 4'b0001;
	data1 = 16'ha0;
	data2 = 16'hff;
	offset = 8'ha;
	useFunc = 2'b00;
	func = 4'h2;

	#2

	mWrite = 1;
	mRead = 1;
	mByte = 1;
	offsetSel = 1;
	rWrite = 2'b10;
	op1 = 4'b0100;
	op2 = 4'b1011;
	data1 = 16'h0f;
	data2 = 16'h0f;
	offset = 8'h3;
	useFunc = 2'b11;
	func = 4'hb;	

	#3	

	#10

	$finish;
end
	

endmodule
