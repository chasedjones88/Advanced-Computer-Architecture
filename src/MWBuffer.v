/*
 * Module by Chase Jones
 */

module MWBuffer(
	//#######
	//Inputs
	//#######
	//Writeback variables
	input [1:0] rWrite,
	//Memory variables
	input [15:0] op1data, op2data, r15data,
	input [3:0] op1, op2,
	input clk,

	//#######
	//Outputs
	//#######
	//Writeback variables
	output reg [1:0] rWriteOut,
	//Memory variables	
	output reg [15:0] op1dataOut, op2dataOut, r15dataOut,
	output reg [3:0] op1Out, op2Out
);

always@(posedge clk)
begin
	// WB	
	rWriteOut <= rWrite;
	// M
	op1dataOut <= op1data;
	op2dataOut <= op2data;
	r15dataOut <= r15data;
	op1Out <= op1;
	op2Out <= op2;
end	

endmodule
