/*
 * Module by Chase Jones
 */
`include "comparator.v"
module comparator_fixture();

reg [15:0] a, b;
wire lt, gt, eq;

comparator cmp(.data1(a), .r15(b), .lt(lt), .gt(gt), .equal(eq), .reset(reset));

initial $monitor("#####INPUT#####\na: %2h\tb: %2h\n#####OUTPUT#####\nlt: %b\tgt: %b\teq: %b\n\n", a, b, lt, gt, eq);

initial $vcdpluson;

initial
begin

	a= 0;
	b= 0;

	#5
	a= 15;
	b = 7;

	#5
	a= 20;
	b= 40;
	
	#5 $finish;

end

endmodule
