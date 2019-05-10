`include "regfile.v"
module regfile_fixture();

reg [1:0] rWrite;
reg [3:0] op1, op2, wop1, wop2;
reg [15:0] wdata1, wdata2, r15data;
reg clk, reset;

wire [15:0] data1, data2, r15dataout;
wire [0:255] regout;

regfile regfile( .rWrite(rWrite), .op1(op1), .op2(op2), .wop1(wop1), .wop2(wop2), .wdata1(wdata1), .wdata2(wdata2), .r15data(r15data), .clk(clk), .reset(reset), .data1(data1), .data2(data2), .r15dataout(r15dataout), .regout(regout));

initial $monitor("####input####\nrW %2b\top1 %1h\top2 %1h\twop1 %1h\twop2 %1h\nwd1 %4h\twd2 %4h\tr15 %4h\nclk %b\treset %b\n#####output#####\nd1 %4h\td2 %4h\tr15o %4h\n===reg contents===\n00: %2h %2h\t01: %2h %2h\n02: %2h %2h\t03: %2h %2h\n04: %2h %2h\t05: %2h %2h\n06: %2h %2h\t07: %2h %2h\n08: %2h %2h\t09: %2h %2h\n0a: %2h %2h\t0b: %2h %2h\n0c: %2h %2h\t0d: %2h %2h\n0e: %2h %2h\t0f: %2h %2h\n\n", rWrite, op1, op2, wop1, wop2, wdata1, wdata2, r15data, clk, reset, data1, data2, r15dataout, regout[0:7], regout[8:15], regout[16:23], regout[24:31], regout[32:39], regout[40:47], regout[48:55], regout[56:63], regout[64:71], regout[72:79], regout[80:87], regout[88:95], regout[96:103], regout[104:111], regout[112:119], regout[120:127], regout[128:135], regout[136:143], regout[144:151], regout[152:159], regout[160:167], regout[168:175], regout[176:183], regout[184:191], regout[192:199], regout[200:207], regout[208:215], regout[216:223], regout[224:231], regout[232:239], regout[240:247], regout[248:255]);

initial clk = 1;
initial forever #5 clk = !clk;
initial reset = 0;

initial
begin	
	op1 = 0;
	op2 = 1;
	wop1 = 8;
	wop2 = 9;
	#10
	
	reset <=1;
	rWrite <= 0;
	$display("testing reads");
	op1 <= 2;
	op2 <= 3;

	#10;
	op1 <= 4;
	op2 <= 5;

	#2
	$display("testing writes");
	rWrite <= 2'b01;
	wdata1 <= 16'hafaf;
	wdata2 <= 16'hbcbc;
	r15data <= 16'h000d;
	#3

	#10
	rWrite <= 2'b10;
	wop1 <= 4'ha;
	wop2 <= 4'hb;
	wdata1 <= 16'heeee;
	wdata2 <= 16'h0110;
	r15data <= 16'h1001;

	#10
	rWrite <= 2'b11;
	wop1 <= 4'hc;
	wop2 <= 4'hd;
	wdata1 <= 16'haaaa;
	wdata2 <= 16'h0331;
	r15data <= 16'h5555;

	#20
	
	$finish;
	
end

endmodule
