/*
 * Module by Chase Jones
 */

module hazardUnit(
	input [15:0] instruction, 
	input mRead, clk, reset,
	
	output reg IFIDWrite, PCWrite
);

reg [4:0] op1, op2;
reg [4:0] prevOp1;

always@(*)
begin

	op1 = instruction[11:8];
	op2 = instruction[7:4];

	if(!mRead)
	begin
		if(op1 == prevOp1 || op2 == prevOp1)
		begin
			IFIDWrite = 1'b0;
			PCWrite = 1'b0;
		end
	end
	
	else
	begin
		IFIDWrite = 1'b1;
		PCWrite = 1'b1;
	end
end

always@(posedge clk, negedge reset)
begin
	if(!reset)	
	begin
		PCWrite <= 0;
		IFIDWrite <= 0;
	end
	prevOp1 <= op1;
end
always@(posedge reset)
begin
		PCWrite <= 1;
		IFIDWrite <= 1;
end

endmodule

