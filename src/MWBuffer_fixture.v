/*
 * Module by Chase Jones
 */

`include "MWBuffer.v"
module MWBuffer_fixture();

reg clk;
reg [1:0] rWrite;
reg [3:0] op1, op2;
reg [15:0] op1data, op2data, r15data;

wire [1:0] rWriteOut;
wire [3:0] op1Out, op2Out;
wire [15:0] op1dataOut, op2dataOut, r15dataOut;

MWBuffer mwbuf(.clk(clk), .rWrite(rWrite), .op1(op1), .op2(op2), .op1data(op1data), .op2data(op2data), .r15data(r15data),		 .rWriteOut(rWriteOut), .op1Out(op1Out), .op2Out(op2Out), .op1dataOut(op1dataOut), .op2dataOut(op2dataOut), .r15dataOut(r15dataOut));

initial $vcdpluson;

initial clk = 1;

initial forever #5 clk = !clk;

initial $monitor("#####Input#####\nclk %b\nrW %2b\top1 %1h\top2 %1h\nop1d %2h\top2d %2h\tr15d %2h\n#####OUTPUT#####\nrW %2b\top1 %1h\top2 %1h\nop1d %2h\top2d %2h\tr15d %2h\n\n",clk, rWrite, op1, op2, op1data, op2data, r15data, rWriteOut, op1Out, op2Out, op1dataOut, op2dataOut, r15dataOut);

initial
begin
	rWrite = 2'b00;
	op1 = 4'b0000;
	op2 = 4'b0001;
	op1data = 8'hff;
	op2data = 8'h82;
	r15data = 8'h15;

	#2

	rWrite = 2'b01;
	op1 = 4'b0001;
	op2 = 4'b0100;
	op1data = 8'hcc;
	op2data = 8'h31;
	r15data = 8'h90;

	#3	

	#10

	$finish;
end
	

endmodule
