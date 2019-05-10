/*
 * cpu module by Chase Jones & Genesis Dionisio
 */

// Buffers
`include "IFIDBuffer.v"
`include "IDExBuffer.v"
`include "ExMBuffer.v"
`include "MWBuffer.v"

// IF Stage
`include "pc.v"
`include "im.v"
// ID Stage
`include "hazardUnit.v" 
`include "regfile.v"
`include "control.v"
`include "comparator.v"
`include "haltUnit.v"

// Ex stage
`include "alu.v" 
`include "forwardingUnit.v"
`include "aluCtrl.v"

// M stage
`include "mem.v"

module cpu(
	input clk, reset,
	
	//##########
	// IF
	output [15:0] instruction, updatedPC,
	output reg [15:0] PCin,
	output IFIDWrite, IFFlush, PCWrite,
	output [0:447] imout,

	//##########
	// ID
	output reg jumping,
	output reg [15:0] branchPC,
	output eq, gt, lt,
	output reg [3:0] opcode, op1, op2, func,
	output [7:0] offset,
	output [15:0] data1, data2, id_r15data,
	// Control signals
	output [1:0] bType, 
	output reg [1:0] id_rWrite, id_useFunc,
	output reg id_mWrite, id_mRead, id_mByte, id_offsetSel, 
	output j, IDExFlush,
	output [0:255] regout,

	//##########
	// EX
	output [1:0] ex_rWrite,
	output ex_mWrite, ex_mRead, ex_mByte,
	output [2:0] aluop, 
	output reg [15:0] ex_a_fromreg, 
	output [15:0] ex_a, ex_b, ex_data1, ex_data2, ex_r15data,
	output [3:0] ex_op1, ex_op2,
	output fwdA, fwdB,
	output [15:0] fA, fB,

	//##########
	// M
	output [15:0] addr, wData,
	output [1:0] m_rWrite,
	output m_mWrite, m_mRead, m_mByte,
	output [15:0] mem_data,
	output reg [15:0] m_data1, 
	output [15:0] m_data2, m_r15data,
	output [3:0] m_op1, m_op2,
	output [0:447] memout,

	//##########
	// W
	output [1:0] w_rWrite,
	output [15:0] w_data1, w_data2, w_r15data,
	output [3:0] w_op1, w_op2
);

/*
 * module instantiations
 */
// IF
reg [15:0] pc_plus_2;
im im(.updatedPC(updatedPC), .reset(reset), .instruction(instruction), .imout(imout));
pc pc(.clk(clk), .reset(reset), .PCWrite(PCWrite), .PCin(PCin), .updatedPC(updatedPC));

// IFID
wire [15:0] id_instruction, id_pc;

IFIDBuffer ifidbuf(.instruction(instruction), .updatedPC(pc_plus_2), .IFFlush(IFFlush), .IFIDWrite(IFIDWrite), .clk(clk), .instructionOut(id_instruction), .updatedPCOut(id_pc));

// ID
reg branch;
wire [1:0] control_rWrite, control_useFunc;
wire control_mWrite, control_mRead, control_mByte, control_offsetSel;

comparator cmp(.data1(data1), .r15(id_r15data), .lt(lt), .gt(gt), .equal(eq), .reset(reset));

control ctrl(.opcode(opcode), .func(func), .bType(bType), .rWrite(control_rWrite), .mWrite(control_mWrite), .useFunc(control_useFunc), .mRead(control_mRead), .mByte(control_mByte), .j(j), .offsetSel(control_offsetSel), .IFFlush(IFFlush), .jorb(j || branch), .reset(reset));

haltUnit hu(.Opcode(opcode), .IDExFlush(IDExFlush));

hazardUnit hazu(.instruction(id_instruction), .mRead(ex_mRead), .clk(clk), .IFIDWrite(IFIDWrite), .PCWrite(PCWrite), .reset(reset));

regfile regfile( .rWrite(w_rWrite), .op1(op1), .op2(op2), .wop1(w_op1), .wop2(w_op2), .wdata1(w_data1), .wdata2(w_data2), .r15data(w_r15data), .clk(clk), .reset(reset), .data1(data1), .data2(data2), .r15dataout(id_r15data), .regout(regout));

// IDEx
wire ex_offsetSel;
wire [1:0] ex_useFunc;
wire [3:0] ex_func;
wire [7:0] ex_offset;

IDExBuffer idexbuf(.clk(clk), .mWrite(id_mWrite), .mRead(id_mRead), .mByte(id_mByte), .offsetSel(id_offsetSel), .rWrite(id_rWrite), .useFunc(id_useFunc), .op1(op1), .op2(op2), .func(func), .data1(data1), .data2(data2), .offset(offset),		 .mWriteOut(ex_mWrite), .mReadOut(ex_mRead), .mByteOut(ex_mByte), .offsetSelOut(ex_offsetSel), .rWriteOut(ex_rWrite), .useFuncOut(ex_useFunc),  .op1Out(ex_op1), .op2Out(ex_op2), .funcOut(ex_func), .data1Out(ex_a), .data2Out(ex_b), .offsetOut(ex_offset));

// Ex
wire [1:0] aMux, bMux;
reg [15:0] a, b, addrOffset;
reg [15:0] const;
alu alu(.a(a), .b(b), .aluSelect(aluop), .op1data(ex_data1), .op2data(ex_data2), .r15(ex_r15data));

aluCtrl aluCtrl(.useFunc(ex_useFunc), .func(ex_func), .fwdA(fwdA), .fwdB(fwdB), .aluSelect(aluop), .aMux(aMux), .bMux(bMux));

forwardingUnit fu(.op1(ex_op1), .op2(ex_op2), .memop1(m_op1), .memop2(m_op2), .memop1data(addr), .memop2data(m_data2), .memr15data(m_r15data), .rWrite(m_rWrite), .fA(fA), .fB(fB), .fwdA(fwdA), .fwdB(fwdB));

// ExM
ExMBuffer exmbuf(.clk(clk), .mWrite(ex_mWrite), .mRead(ex_mRead), .mByte(ex_mByte), .rWrite(ex_rWrite), .op1(ex_op1), .op2(ex_op2), .data1(ex_a_fromreg), .op1data(ex_data1), .op2data(ex_data2), .r15data(ex_r15data),		 .mWriteOut(m_mWrite), .mReadOut(m_mRead), .mByteOut(m_mByte), .rWriteOut(m_rWrite), .op1Out(m_op1), .op2Out(m_op2), .data1Out(wData), .op1dataOut(addr), .op2dataOut(m_data2), .r15dataOut(m_r15data));

// M
mem mem(.addr(addr), .wData(wData), .mWrite(m_mWrite), .mByte(m_mByte), .mRead(m_mRead), .reset(reset), .data(mem_data), .memout(memout), .clk(clk));

// MW
MWBuffer mwbuf(.clk(clk), .rWrite(m_rWrite), .op1(m_op1), .op2(m_op2), .op1data(m_data1), .op2data(m_data2), .r15data(m_r15data),		 .rWriteOut(w_rWrite), .op1Out(w_op1), .op2Out(w_op2), .op1dataOut(w_data1), .op2dataOut(w_data2), .r15dataOut(w_r15data));

/*
 * combination logic
 */

// IF
// 	Update pc
always@(*)
begin	
	pc_plus_2 <= updatedPC + 2;
end
//	pcin mux
always@(*)
begin
	if(jumping)
		PCin <= branchPC;
	else 
		PCin <= pc_plus_2;

end

// ID
reg signed [15:0] jOffset, bOffset, pc_offset;
// 	updateoffset for jump
always@(*)
begin
	opcode <= id_instruction[15:12];
	op1 <= id_instruction[11:8];
	op2 <= id_instruction[7:4];
	func <= id_instruction[3:0];
end
always@(*)
	jOffset <= {{3{id_instruction[11]}}, id_instruction[11:0], {1'b0}};
//	update offset for branch
always@(*)
	bOffset <= {{7{id_instruction[7]}}, id_instruction[7:0], {1'b0}};
//	branchpc mux
always@(*)
begin
	if(j)
		pc_offset <= jOffset;
	else
		pc_offset <= bOffset;	
end
//	add branchPC offset toPC
always@(*)
begin
	branchPC <= pc_offset + id_pc;
end
//	branch mux
always@(*)
begin
	branch <= 0;

	case(bType)
	
	2'b00:branch <= 0;

	2'b01:if(eq) branch <= 1;

	2'b10:if(lt) branch <= 1;

	2'b11:if(gt) branch <= 1;
	endcase
end
//	jumping assignment
always@(*)
begin
	if(branch === 1'bx || j === 1'bx)
		jumping <= 1'b0;
	else
		jumping <= branch || j;
end
always@(negedge reset)
begin
	jumping = 0;
end

//	flush control signals
always@(*)
begin

	if(IDExFlush)
	begin
		id_rWrite <= 0;
		id_mWrite <= 1;
		id_mRead <= 1;
		id_mByte <= 0;		
		id_useFunc <= 0;
		id_offsetSel <= 0;
	end

	else
	begin
		id_rWrite <= control_rWrite;
		id_mWrite <= control_mWrite;
		id_mRead <= control_mRead;
		id_mByte <= control_mByte;		
		id_useFunc <= control_useFunc;
		id_offsetSel <= control_offsetSel;
	end
end

// Ex
//	A mux
always@(*)
begin
	case (aMux)

	2'b00: a <= ex_a;

	2'b01: a <= addrOffset;

	2'b10: a <= 16'h0000;
	
	2'b11: a <= fA;
	
	default: a <= 16'b0;

	endcase
end

//	B mux
always@(*)
begin
	case (bMux)

	2'b00: b <= ex_b;
	
	2'b01: b <= const;

	2'b10: b <= fB;

	2'b11: b <= 16'h0000;
	
	default: b <= 16'b0;
	endcase
end

//	offset/func Mux
always@(*)
begin
	if(ex_offsetSel)
		const <= {{8{1'b0}}, ex_offset[7:0]};
	else 
		const <= {{12{1'b0}}, ex_func[3:0]};
end

//	SE addrOffset
always@(*)
begin
	addrOffset <= {{12{const[3]}}, const[3:0]};
end

//	data1 forwarding
always@(*)
begin
	if(fwdA)
		ex_a_fromreg <= fA;
	else
		ex_a_fromreg <= ex_a;
end

// M
//	mux to select output for op1data to MWBuf
always@(*)
begin
	if(m_mRead)
		m_data1 <= mem_data;
	else
		m_data1 <= addr;
end

endmodule
