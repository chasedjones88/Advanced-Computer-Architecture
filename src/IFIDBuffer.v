/*
 * Module by Chase Jones
 */

module IFIDBuffer(
	input [15:0] instruction, updatedPC, 
	input IFFlush, IFIDWrite, clk,
	output reg [15:0] instructionOut, updatedPCOut
);

always@(posedge clk)
begin
	if(IFFlush)
	begin
		instructionOut <= 0;
		updatedPCOut <= 0;
	end
	else if (!IFIDWrite)
	begin
		instructionOut <= instructionOut;
		updatedPCOut <= updatedPCOut;
	end
	else
	begin
		instructionOut <= instruction;
		updatedPCOut <= updatedPC;
	end
end

endmodule
