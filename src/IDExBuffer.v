/*
 * Module by Chase Jones
 */

module IDExBuffer(
	//#######
	//Inputs
	//#######
	//Writeback variables
	input [1:0] rWrite,
	//Memory variables
	input mWrite, mRead, mByte,
	//Ex variables
	input [1:0] useFunc,
	input [15:0] data1, data2,
	input [3:0] func,
	input [7:0] offset,
	input [3:0] op1, op2,
	input offsetSel, clk,

	//#######
	//Outputs
	//#######
	//Writeback variables
	output reg [1:0] rWriteOut,
	//Memory variables
	output reg mWriteOut, mReadOut, mByteOut,
	//Ex variables
	output reg [1:0] useFuncOut,
	output reg [15:0] data1Out, data2Out,
	output reg [3:0] funcOut,
	output reg [7:0] offsetOut,
	output reg [3:0] op1Out, op2Out,
	output reg offsetSelOut
);

always@(posedge clk)
begin
	// WB	
	rWriteOut <= rWrite;
	// M
	mWriteOut <= mWrite;
	mReadOut <= mRead;
	mByteOut <= mByte;
	// Ex
	useFuncOut <= useFunc;
	data1Out <= data1;
	data2Out <= data2;
	funcOut <= func;
	offsetOut <= offset;
	op1Out <= op1;
	op2Out <= op2;
	offsetSelOut <= offsetSel;
end	

endmodule
