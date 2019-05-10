/*
 * Module by Chase Jones
 */

module alu(
	input signed [15:0]a, b, 
	input [2:0] aluSelect, 
	output reg signed[15:0] op1data, op2data, r15
);

reg signed [31:0] a32, b32, o32;

always@(*)
begin
	a32 = 32'b0;
	b32 = 32'b0;
	o32 = 32'b0;

	case(aluSelect)
	
	3'b000:begin
		op1data = a+b;
		op2data = 16'b0;
		r15 = 16'b0;
	end	

	3'b001:begin
		op1data = a-b;
		op2data = 16'b0;
		r15 = 16'b0;
	end
	
	3'b010:begin
		a32 = { {16{a[15]}}, a[15:0]};
		b32 = { {16{b[15]}}, b[15:0]};
		o32 = a32 * b32;
	
		op1data = o32[15:0];
		r15 = o32[31:16];
		op2data = 16'b0;
	end

	3'b011:begin
		op1data = a/b;
		r15 = a%b;
		op2data = 16'b0;
	end

	3'b100:begin
		op1data = b;
		op2data = 16'b0;
		r15 = 16'b0;
	end

	3'b101:begin
		op1data = b;
		op2data = a;
		r15 = 16'b0;
	end

	3'b110:begin
		op1data = a & { {8'b0}, b[7:0]};
		op2data = 16'b0;
		r15 = 16'b0;
	end

	3'b111:begin
		op1data = a | { {8'b0}, b[7:0]};
		op2data = 16'b0;
		r15 = 16'b0;
	end

	default:begin
		op1data = a+b;
		op2data = 16'b0;
		r15 = 16'b0;
	end

	endcase
end



endmodule
