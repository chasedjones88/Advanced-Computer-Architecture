/*
 * fixture by Chase Jones
 */

`include "alu.v"

module alu_fixture();

reg signed [15:0] a, b;
reg [2:0] aluSelect;
wire signed [15:0] data1, data2; 
wire [15:0] r15;

alu	alu(.a(a), .b(b), .aluSelect(aluSelect), .op1data(data1), .op2data(data2), .r15(r15));

initial $vcdpluson;

initial $monitor("input: %5d\t%5d\tselect: %1d\noutput: %5d\t%5d\%5d\n", a,b,aluSelect,data1,data2,r15);

initial
begin
	$display("Testing add");
	a = 15;
	b = 10;
	aluSelect = 0;
	
	#5
	a = -5;
	b = 25;
	
	#5
	$display("Testing subtraction");
	a = 30;
	b = 15;
 	aluSelect = 1;
	
	#5
	a = 50;
	b = -10;

	#5
	$display("Testing multiplication");
	a = 10;
	b = 3;
	aluSelect = 2;		

	#5
	a = 5;
	b = -5;

	#5
	$display("Testing Division");
	a = 10;
	b = 2;
	aluSelect = 3;

	#5
	a = 5;
	b = 2;

	#5
	$display("Testing move");
	a = 15;
	b = 55;
	aluSelect = 4;

	#5
	$display("Testing Swap");
	a = 100;
	b = 2;
	aluSelect = 5;

	#5
	$display("Testing &");
	$display("4 & 2 should be 0");
	a = 4;
	b = 2;
	aluSelect = 6;

	#5
	$display("5 and 4 should be 4");
	a = 5;
	b = 4;

	#5
	$display("Testing |");
	$display("4 | 2 should be 6");
	a = 4;
	b = 2;
	aluSelect = 7;

	#5
	$display("4 | 3 should be 7");
	a = 4;
	b = 3;
	
	#5 $finish;

end

endmodule
