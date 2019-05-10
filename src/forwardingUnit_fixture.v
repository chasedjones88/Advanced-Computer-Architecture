`include "forwardingUnit.v"
module forwardingUnit_fixture();

reg [3:0] op1, op2, memop1, memop2;
reg [15:0] memop1data, memop2data, memr15data;
reg [1:0] rWrite;

wire [15:0] fA, fB;
wire fwdA, fwdB;

forwardingUnit fu( .op1(op1), .op2(op2), .memop1(memop1), .memop2(memop2), .memop1data(memop1data), .memop2data(memop2data), .memr15data(memr15data), .rWrite(rWrite), .fA(fA), .fB(fB), .fwdA(fwdA), .fwdB(fwdB));

initial $vcdpluson;
initial $monitor("#####input#####\nop1 %1h\top2 %1h\tmop1 %1h\tmop2 %1h\nmd1 %4h\tmd2 %4h\tm15 %4h\tmW %2b\n#####output#####\nfA %4h\tfB %4h\tfwdA %b\tfwdB %b\n\n",op1, op2, memop1, memop2, memop1data, memop2data, memr15data, rWrite, fA, fB, fwdA, fwdB);

initial 
begin
	$display ("testinf rWrite = 0");
	rWrite = 0;
	op1 = 0;
	op2 = 0;

	memop1data = 16'haaaa;
	memop2data = 16'hbbbb;

	#5
	$display("Testing rWrite = 1");

	rWrite = 1;
	memop1 = 5;
	memop2 = 6;

	#5
	op1 = 5;

	#5
	op1 = 6;

	#5
	op1 =5;
	op2 = 5;
	
	#5
	op1 = 0;
	op2 = 6;

	#5
	op1 = 15;
	op2 = 0;

	#5
	op1 = 0;
	op2 = 15;

	#5
	op1 = 15;
	op1 = 15;

	#5
	$display("Testing rWrite = 2\n\n");

	rWrite = 2;
	memop1 = 5;
	memop2 = 6;

	#5
	op1 = 5;

	#5
	op1 = 6;

	#5
	op1 =5;
	op2 = 5;
	
	#5
	op1 = 0;
	op2 = 6;

	#5
	op1 = 15;
	op2 = 0;

	#5
	op1 = 0;
	op2 = 15;

	#5
	op1 = 15;
	op1 = 15;
		

	#5
	$display("Testing rWrite = 3\n\n");

	rWrite = 3;
	memop1 = 5;
	memop2 = 6;

	#5
	op1 = 5;

	#5
	op1 = 6;

	#5
	op1 =5;
	op2 = 5;
	
	#5
	op1 = 0;
	op2 = 6;

	#5
	op1 = 15;
	op2 = 0;

	#5
	op1 = 0;
	op2 = 15;

	#5
	op1 = 15;
	op1 = 15;

end

endmodule
