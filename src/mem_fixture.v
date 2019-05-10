/*
 * Module by Chase Jones
 */
`include "mem.v"
module mem_fixture();

reg clk;
reg [15:0] addr, wData;
reg mWrite, mByte, mRead, reset;
wire [15:0] data;
wire [0:447] memout;

mem	mem(.addr(addr), .wData(wData), .mWrite(mWrite), .mByte(mByte), .mRead(mRead), .reset(reset), .data(data), .memout(memout), .clk(clk));

initial $vcdpluson;

initial $monitor("#####INPUT#####\naddr = %4h\twData = %4h\nmW %b\tmByte %b\tmRead %b\treset = %b\tclk %b\n#####OUTPUT#####\ndata = %4h\n===mem===\n00: %h %h\t02: %h %h\n04: %h %h\t06: %h %h\n08: %h %h\t0a: %h %h\n0c: %h %h\t0e: %h %h\n10: %h %h\t12: %h %h\n14: %h %h\t16: %h %h\n18: %h %h\t1a: %h %h\n1c: %h %h\t1e: %h %h\n20: %h %h\t22: %h %h\n24: %h %h\t26: %h %h\n28: %h %h\t2a: %h %h\n2c: %h %h\t2e: %h %h\n30: %h %h\t32: %h %h\n34: %h %h\t36: %h %h\n\n", addr, wData, mWrite, mByte, mRead, reset, clk, data, memout[0:7], memout[8:15], memout[16:23], memout[24:31], memout[32:39], memout[40:47], memout[48:55], memout[56:63], memout[64:71], memout[72:79], memout[80:87], memout[88:95], memout[96:103], memout[104:111], memout[112:119], memout[120:127], memout[128:135], memout[136:143], memout[144:151], memout[152:159], memout[160:167], memout[168:175], memout[176:183], memout[184:191], memout[192:199], memout[200:207], memout[208:215], memout[216:223], memout[224:231], memout[232:239], memout[240:247], memout[248:255], memout[256:263], memout[264:271], memout[272:279], memout[280:287], memout[288:295], memout[296:303], memout[304:311], memout[312:319], memout[320:327], memout[328:335], memout[336:343], memout[344:351], memout[352:359], memout[360:367], memout[368:375], memout[376:383], memout[384:391], memout[392:399], memout[400:407], memout[408:415], memout[416:423], memout[424:431], memout[432:439], memout[440:447]);

initial reset = 0;
initial clk = 1;
initial forever #5 clk = !clk;
integer i;

initial 
begin
	reset = 0;

	#5
	reset <= 1;
	addr <= 0;
	mRead <= 0;
	mWrite <= 1;
	mByte <= 0;
	wData <= 16'hbbbb;

	for(i = 0; i < 10; i= i+1)
	begin
	#10
	wData <= wData + i;
	addr <= addr+2;
	mRead <= !mRead;
	mWrite <= !mWrite;
	end

	#10
	reset = 0;
	#10
	reset = 1;
	mByte = 1;
	addr = 0;	
	for(i = 0; i < 10; i= i+1)
	begin
	#10
	wData <= wData + 2*i;
	addr <= addr+3;
	mRead <= !mRead;
	mWrite <= !mWrite;
	end

	$finish;

end

endmodule
