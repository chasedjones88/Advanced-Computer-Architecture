`include "hazardUnit.v"
module hazardUnit_fixture();

reg [15:0] instruction;
reg mRead, clk;

wire IFIDWrite, PCWrite;

hazardUnit hazu(.instruction(instruction), .mRead(mRead), .clk(clk), .IFIDWrite(IFIDWrite), .PCWrite(PCWrite));

initial $vcdpluson;
initial clk = 1;
initial forever #5 clk = !clk;

initial $monitor("#####input#####\n%4h\nmR %b\ttime: %4d\n#####output#####\nifidw %1b\tpcW %b\n\n", instruction, mRead, $time, IFIDWrite, PCWrite);

integer i;
initial
begin

	instruction = 16'h0246;
	mRead =1;

	#15
	for(i = 0; i < 2; i = i +1)
	begin
	instruction = 16'h0000;
	
	#10
	instruction = 16'h0246;
	
	#10
	instruction = 16'h0200;

	#10
	instruction = 16'h0246;

	#10
	instruction = 16'h0020;

	#10
	instruction = 16'h0246;

	#10
	instruction = 16'h0220;

	#10;
	instruction = 16'h0246;

	#10
	mRead = !mRead;

	end
	$finish;
end

endmodule
