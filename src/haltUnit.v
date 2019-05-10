module haltUnit
(
	input [3:0] Opcode,
	output reg IDExFlush
);

always @(*)
begin
	if(Opcode == 4'b1111)
		begin
		//active high
		IDExFlush <= 1;
		end
	else
		begin
		IDExFlush <= 0;
		end
	end
endmodule	
