/*
 * Module by Chase Jones
 */

module forwardingUnit(
	input [3:0] op1, op2, memop1, memop2, 
	input [15:0] memop1data, memop2data, memr15data,
	input [1:0] rWrite,

	output reg [15:0] fA, fB,
	output reg fwdA, fwdB
);

always@(*)
begin
	fwdA = 0;
	fwdB = 0;
	fA = 0;
	fB = 0;
	
	if(memop1 === 1'bx || memop2 === 1'bx)
	begin
		fwdA <= 0;
		fwdB <= 0;
		fA <= 0;
		fB <= 0;
	end
	
	else
	begin
	case(rWrite)

	2'b00: begin
		fA = 0;
		fB = 0;
	end
	
	2'b01: begin
		if(op1 == memop1)
		begin
			fwdA = 1;
			fA = memop1data;
		end
		if (op2 == memop1)
		begin
			fwdB = 1;
			fB = memop1data;
		end
	end

	2'b10: begin 
		// forward for first op
		if(op1 == memop1)
		begin
			fwdA = 1;
			fA = memop1data;
		end

		else if(op1 == memop2)
		begin
			fwdA = 1;
			fA = memop2data;
		end
		
		// forward for second op
		if (op2 == memop1)
		begin
			fwdB = 1;
			fB = memop1data;
		end

		else if (op2 == memop2)
		begin
			fwdB = 1;
			fB = memop2data;
		end
	end

	2'b11: begin 
		// forward for first op
		if(op1 == memop1)
		begin
			fwdA = 1;
			fA = memop1data;
		end

		else if(op1 == 15)
		begin
			fwdA = 1;
			fA = memr15data;
		end
		
		// forward for second op
		if (op2 == memop1)
		begin
			fwdB = 1;
			fB = memop1data;
		end

		else if (op2 == 15)
		begin
			fwdB = 1;
			fB = memr15data;
		end
	end

	endcase
	end

end

endmodule
