/*
 * Module by Genesis Dionisio
 */

module control(
	input [3:0] opcode, func,
	input jorb, reset,

	// W
	output reg [1:0] rWrite,
	// M
	output reg mWrite, mRead, mByte,
	// Ex
	output reg [1:0] useFunc,
	output reg offsetSel,
	// ID
	output reg j, IFFlush,
	output reg [1:0] bType
);

always@(negedge reset)
begin
	IFFlush = 0;
	bType = 0;
end

always@(*)
begin
	bType = 2'b00;
	j = 0;
	IFFlush = 0;
	
	rWrite = 00;
	mWrite = 1;
	mRead = 1;
	mByte = 0;
	
	useFunc = 2'b00;
	offsetSel = 0;

	case(opcode)
	
	4'b0000:begin // A-type
		rWrite = 2'b01;
		mWrite = 1;
		mRead = 1;
		mByte = 0;		
		useFunc = 2'b00;
		j = 0;
		offsetSel = 0;
		case(func)

		4'b0100: rWrite = 2'b11; //*

		4'b1000: rWrite = 2'b11; // /

		4'b1110: rWrite = 2'b01; // move

		4'b1111: rWrite = 2'b10; // swap

		endcase
	end

	4'b1000:begin // load byte unsigned
		rWrite = 2'b01;
		mWrite = 1;
		mRead = 0;
		mByte = 1;
		useFunc = 2'b01;
	end

	4'b1010:begin // load word
		rWrite = 2'b01;
		mWrite = 1;
		mRead = 0;
		mByte = 0;
		useFunc = 2'b01;
	end

	4'b1001:begin // store byte
		rWrite = 2'b00;
		mWrite = 0;
		mRead = 1;
		mByte = 1;
		useFunc = 2'b01;
	end

	4'b1011:begin // store word
		rWrite = 2'b00;
		mWrite = 0;
		mRead = 1;
		mByte = 0;
		useFunc = 2'b01;
	end

	4'b0100:begin // blt
		bType = 2'b10;
	end

	4'b0101:begin // bgt
		bType = 2'b11;
	end

	4'b0110:begin // beq
		bType = 2'b01;
	end

	4'b0001:begin // and
		rWrite = 2'b01;
		useFunc = 2'b11;
		offsetSel = 1;
	end
	
	4'b0010:begin // or
		rWrite = 2'b01;
		useFunc = 2'b10;
		offsetSel = 1;
	end

	4'b1100:begin // j
		j = 1;
		IFFlush = 1;
	end

	4'b1111:begin // halt
		IFFlush = 1;
	end

	endcase
end

always@(*)
	if(jorb)
		IFFlush <= 1;

endmodule
