/*
 * Module by Chase Jones
 */
`include "IFIDBuffer.v"
module IDIFBuffer_fixture();

reg [15:0]instruction, updatedPC;
reg IFFlush, IFIDWrite, clk;
wire [15:0] iOut, uPCOut;

IFIDBuffer ifidbuf(.instruction(instruction), .updatedPC(updatedPC), .IFFlush(IFFlush), .IFIDWrite(IFIDWrite), .clk(clk), .instructionOut(iOut), .updatedPCOut(uPCOut));

initial $vcdpluson;

initial clk = 1;

initial forever #5 clk = !clk;

initial $monitor("#####Input#####\ni %4h\tpc %4h\t%2d\nif %b\tiw %b\tclk %b\n#####output#####\niO %4h\tPCout %4h\n\n", instruction, updatedPC, $time, IFFlush, IFIDWrite, clk, iOut, uPCOut);

initial
begin

	instruction = 16'hffff;
	updatedPC = 16'h 0001;
	IFFlush = 0;
	IFIDWrite = 1;

	#2
	
	instruction = 16'h0000;
	updatedPC = 16'ha0a1;
	IFFlush = 0;
	IFIDWrite = 1;
	
	#3
	#10
	
	instruction = 16'h3432;
	updatedPC = 16'h bbbb;
	IFFlush = 0;
	IFIDWrite = 0;

	#10

	IFFlush = 1;
	IFIDWrite = 1;
	
	#7
	
	IFFlush = 0;
	
	#3

	#10

	$finish;

end

endmodule
