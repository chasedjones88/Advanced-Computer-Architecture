/*
 * fixture by Chase Jones
 */

`include "aluCtrl.v"

module aluCtrl_fixture();

reg [1:0] useFunc;
reg [3:0] func;
reg fwdA, fwdB;

wire [2:0] aluSelect, aMux, bMux;

aluCtrl	aluCtrl(.useFunc(useFunc), .func(func), .fwdA(fwdA), .fwdB(fwdB), .aluSelect(aluSelect), .aMux(aMux), .bMux(bMux));

initial $vcdpluson;

initial $monitor("######input######\nuseFunc = %2b\tfunc = %4b\nfwdA = %b\tfwdB = %b\n######output#####\naluSelect = %3b\t aMux = %2b\t bMux = %2b\n\n\n", useFunc, func, fwdA, fwdB, aluSelect,aMux, bMux);

initial
begin
	$display("Testing aluSelect 000, useFunc = 00 and func = 0000");
	useFunc = 2'b00;
	func = 4'b0000;

	#5
	$display("Testing no useFunc");
	useFunc = 2'b01;
	func = 4'b1000;

	#5
	$display("Testing 001");
	useFunc = 2'b00;
	func = 4'b0001;
	
	#5
	$display("Testing 010");
	func = 4'b0100;
	
	#5	
 	$display("Testing 011");
	func = 4'b1000;	

	#5
	$display("Testing 100");
	func = 4'b1110;		

	#5
	$display("Testing 101");
	func = 4'b1111;
	
	#5
	$display("Testing 110");
	useFunc = 2'b11;

	#5
	$display("Testing 111");
	useFunc = 2'b10;

	#5
	$display("Testing bMux");
	fwdB = 1;

	#5
	fwdB = 0;
	useFunc = 2'b10;

	#5
	useFunc = 2'b11;

	#5
	useFunc = 2'b0;

	#5
	$display("Testing aMux");
	fwdA = 1;

	#5
	useFunc = 2'b10;
	
	#5
	fwdA = 0;

	#5
	useFunc = 0;
	func = 4'b1111;
	
	#5
	func = 0;

	#5
	useFunc = 2'b01;
		
	#5 $finish;

end

endmodule
