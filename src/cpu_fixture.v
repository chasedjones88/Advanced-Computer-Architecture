`include "cpu.v"
module cpu_fixture();

// Inputs
reg clk, reset;

// Outputs to display;
//#########
// IF
wire [15:0] instruction, updatedPC;
wire [15:0] PCin;
wire IFIDWrite, IFFlush, PCWrite;
wire [0:447] imout;
//##########
// ID
wire jumping;
wire [15:0] branchPC;
wire eq, gt, lt;
wire [3:0] opcode, op1, op2, func;
wire [7:0] offset;
wire [15:0] data1, data2, id_r15data;
// Control signals
wire [1:0] bType;
wire [1:0] id_rWrite, id_useFunc;
wire id_mWrite, id_mRead, id_mByte, id_offsetSel;
wire j, IDExFlush;
wire [0:255] regout;
//##########
// EX
wire [1:0] ex_rWrite;
wire ex_mWrite, ex_mRead, ex_mByte;
wire [2:0] aluop;
wire [15:0] ex_a_fromreg;
wire [15:0] ex_a, ex_b, ex_data1, ex_data2, ex_r15data;
wire [3:0] ex_op1, ex_op2;
wire fwdA, fwdB;
wire [15:0] fA, fB;
//##########
// M
wire [15:0] addr, wData;
wire [1:0] m_rWrite;
wire m_mWrite, m_mRead, m_mByte;
wire [15:0] mem_data;
wire [15:0] m_data1;
wire [15:0] m_data2, m_r15data;
wire [3:0] m_op1, m_op2;
wire [0:447] memout;
//##########
// W
wire [1:0] w_rWrite;
wire [15:0] w_data1, w_data2, w_r15data;
wire [3:0] w_op1, w_op2;

cpu cpu(.clk(clk), .reset(reset), .instruction(instruction), .updatedPC(updatedPC), .PCin(PCin), .IFIDWrite(IFIDWrite), .IFFlush(IFFlush), .PCWrite(PCWrite), .imout(imout), .jumping(jumping), .branchPC(branchPC), .eq(eq), .gt(gt), .lt(lt), .opcode(opcode), .op1(op1), .op2(op2), .func(func), .offset(offset), .data1(data1), .data2(data2), .id_r15data(id_r15data), .bType(bType), .id_rWrite(id_rWrite), .id_useFunc(id_useFunc), .id_mWrite(id_mWrite), .id_mRead(id_mRead), .id_mByte(id_mByte), .id_offsetSel(id_offsetSel), .j(j), .IDExFlush(IDExFlush), .regout(regout), .ex_rWrite(ex_rWrite), .ex_mWrite(ex_mWrite), .ex_mRead(ex_mRead), .ex_mByte(ex_mByte), .aluop(aluop), .ex_a_fromreg(ex_a_fromreg), .ex_a(ex_a), .ex_b(ex_b), .ex_data1(ex_data1), .ex_data2(ex_data2), .ex_r15data(ex_r15data), .ex_op1(ex_op1), .ex_op2(ex_op2), .fwdA(fwdA), .fwdB(fwdB), .fA(fA), .fB(fB), .addr(addr), .wData(wData), .m_rWrite(m_rWrite), .m_mWrite(m_mWrite), .m_mRead(m_mRead), .m_mByte(m_mByte), .mem_data(mem_data), .m_data1(m_data1), .m_data2(m_data2), .m_r15data(m_r15data), .m_op1(m_op1), .m_op2(m_op2), .memout(memout), .w_rWrite(w_rWrite), .w_data1(w_data1), .w_data2(w_data2), .w_r15data(w_r15data), .w_op1(w_op1), .w_op2(w_op2));

initial $vcdpluson;
initial clk = 1;
initial reset = 0;
initial #11 reset = 1;
initial
begin
	forever
	begin
		#5 clk <= !clk;
	end
end

always@(posedge clk, negedge reset)
begin
	if(!reset)
		$display("#################################\n#\t\t\t\t#\n#\tCPU IS IN RESET!\t#\n#\t\t\t\t#\n#################################\n\n");
	else
	begin

$display("\
===========================\n\
###########################\n\
#     	SYSTEM OUTPUT     #\n\
###########################\n\
clk: %b            reset: %b\n\
\n\
###########################\n\
#     IF STAGE OUTPUT     #\n\
###########################\n\
instruction: %4h \t pc: %4h \n\
next PC: %4h\n\
IFIDWrite: %b \t IFFlush: %b\n\
====== IM ======\n\
00: %2h %2h    02: %2h %2h\n\
04: %2h %2h    06: %2h %2h\n\
08: %2h %2h    0a: %2h %2h\n\
0c: %2h %2h    0e: %2h %2h\n\
10: %2h %2h    12: %2h %2h\n\
14: %2h %2h    16: %2h %2h\n\
18: %2h %2h    1a: %2h %2h\n\
1c: %2h %2h    1e: %2h %2h\n\
20: %2h %2h    22: %2h %2h\n\
24: %2h %2h    26: %2h %2h\n\
28: %2h %2h    2a: %2h %2h\n\
2c: %2h %2h    2e: %2h %2h\n\
30: %2h %2h    32: %2h %2h\n\
34: %2h %2h    36: %2h %2h\n\
\n\
###########################\n\
#     ID STAGE OUTPUT     #\n\
###########################\n\
opcode: %1h op1: %1h op2: %1h func %1h\n\
branchPC: %4h \tj|br: %1b\n\
lt: %b \t gt: %b \t eq: %b\n\
data1: %4h data2: %4h r15data: %4h\n\
====== REGFILE ======\n\
00: %2h %2h    01: %2h %2h\n\
02: %2h %2h    03: %2h %2h\n\
04: %2h %2h    05: %2h %2h\n\
06: %2h %2h    07: %2h %2h\n\
08: %2h %2h    09: %2h %2h\n\
0a: %2h %2h    0b: %2h %2h\n\
0c: %2h %2h    0d: %2h %2h\n\
0e: %2h %2h    0f: %2h %2h\n\
====== CONTROL ======\n\
IDExFlush %b\n\
rWrite %2b \t useFunc %2b\n\
mWrite %1b \t mRead %1b\n\
mByte %1b \t offsetSel %1b\n\
\n\
###########################\n\
#     Ex STAGE OUTPUT     #\n\
###########################\n\
a %4h \t b %4h \t aluop %3b\n\
alu_data1 %4h \t alu_data2 %4h\n\
alu_r15data %4h\n\
====== RF ======\n\
fwdA %1b \t fA %4h\n\
fwdB %1b \t fB %4h\n\
op1 %1h \t prevop1 %1h\n\
op2 %1h \t prevop2 %1h\n\
mem_rWrite %2b\n\
====== CONTROL ======\n\
rWrite %2b \t mWrite %1b\n\
mRead %1b \t mByte %1b\n\
\n\
###########################\n\
#      M STAGE OUTPUT     #\n\
###########################\n\
addr %4h \t wData %4h\n\
mWrite %1b\n\
mRead %1b \t mByte %1b\n\
data_from_mem %4h\n\
data_to_buffer %4h\n\
====== MEM ======\n\
00: %2h %2h    02: %2h %2h\n\
04: %2h %2h    06: %2h %2h\n\
08: %2h %2h    0a: %2h %2h\n\
0c: %2h %2h    0e: %2h %2h\n\
10: %2h %2h    12: %2h %2h\n\
14: %2h %2h    16: %2h %2h\n\
18: %2h %2h    1a: %2h %2h\n\
1c: %2h %2h    1e: %2h %2h\n\
20: %2h %2h    22: %2h %2h\n\
24: %2h %2h    26: %2h %2h\n\
28: %2h %2h    2a: %2h %2h\n\
2c: %2h %2h    2e: %2h %2h\n\
30: %2h %2h    32: %2h %2h\n\
34: %2h %2h    36: %2h %2h\n\
====== CONTROL ======\n\
rWrite %2b \t op1 %1h \t op2 %1h\n\
data2 %4h \t r15data %4h\n\
###########################\n\
#      W STAGE OUTPUT     #\n\
###########################\n\
w_op1 %1h \t w_data1 %4h\n\
w_op2 %1h \t w_data2 %4h\n\
w_r15data %4h\n\
rWrite %1b\n\
\n\
time: %5d\n\
===========================\n\n\n\n\n\
", clk, reset, instruction, updatedPC, PCin, IFIDWrite, IFFlush, imout[0:7], imout[8:15], imout[16:23], imout[24:31], imout[32:39], imout[40:47], imout[48:55], imout[56:63], imout[64:71], imout[72:79], imout[80:87], imout[88:95], imout[96:103], imout[104:111], imout[112:119], imout[120:127], imout[128:135], imout[136:143], imout[144:151], imout[152:159], imout[160:167], imout[168:175], imout[176:183], imout[184:191], imout[192:199], imout[200:207], imout[208:215], imout[216:223], imout[224:231], imout[232:239], imout[240:247], imout[248:255], imout[256:263], imout[264:271], imout[272:279], imout[280:287], imout[288:295], imout[296:303], imout[304:311], imout[312:319], imout[320:327], imout[328:335], imout[336:343], imout[344:351], imout[352:359], imout[360:367], imout[368:375], imout[376:383], imout[384:391], imout[392:399], imout[400:407], imout[408:415], imout[416:423], imout[424:431], imout[432:439], imout[440:447], opcode, op1, op2, func, branchPC, jumping, lt, gt, eq, data1, data2, id_r15data, regout[0:7], regout[8:15], regout[16:23], regout[24:31], regout[32:39], regout[40:47], regout[48:55], regout[56:63], regout[64:71], regout[72:79], regout[80:87], regout[88:95], regout[96:103], regout[104:111], regout[112:119], regout[120:127], regout[128:135], regout[136:143], regout[144:151], regout[152:159], regout[160:167], regout[168:175], regout[176:183], regout[184:191], regout[192:199], regout[200:207], regout[208:215], regout[216:223], regout[224:231], regout[232:239], regout[240:247], regout[248:255], IDExFlush, id_rWrite, id_useFunc, id_mWrite, id_mRead, id_mByte, id_offsetSel, ex_a, ex_b, aluop, ex_data1, ex_data2, ex_r15data, fwdA, fA, fwdB, fB, ex_op1, m_op1, ex_op2, m_op2, m_rWrite, ex_rWrite, ex_mWrite, ex_mRead, ex_mByte, addr, wData, m_mWrite, m_mRead, m_mByte, mem_data, m_data1, memout[0:7], memout[8:15], memout[16:23], memout[24:31], memout[32:39], memout[40:47], memout[48:55], memout[56:63], memout[64:71], memout[72:79], memout[80:87], memout[88:95], memout[96:103], memout[104:111], memout[112:119], memout[120:127], memout[128:135], memout[136:143], memout[144:151], memout[152:159], memout[160:167], memout[168:175], memout[176:183], memout[184:191], memout[192:199], memout[200:207], memout[208:215], memout[216:223], memout[224:231], memout[232:239], memout[240:247], memout[248:255], memout[256:263], memout[264:271], memout[272:279], memout[280:287], memout[288:295], memout[296:303], memout[304:311], memout[312:319], memout[320:327], memout[328:335], memout[336:343], memout[344:351], memout[352:359], memout[360:367], memout[368:375], memout[376:383], memout[384:391], memout[392:399], memout[400:407], memout[408:415], memout[416:423], memout[424:431], memout[432:439], memout[440:447], m_rWrite, m_op1, m_op2, m_data2, m_r15data, w_op1, w_data1, w_op2, w_data2, w_r15data, w_rWrite, $time);
	end

end

initial
	#330 $finish;

endmodule
