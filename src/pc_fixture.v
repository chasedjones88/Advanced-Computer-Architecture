`include "pc.v"
module pc_fixture();

reg clk, reset, PCWrite;
reg [15:0] PCin;
wire [15:0] PCout;

pc	pc(.clk(clk), .reset(reset), .PCWrite(PCWrite), .PCin(PCin), .updatedPC(PCout));

initial $vcdpluson;
initial clk = 1;
initial forever #5 clk = !clk;
initial $monitor("####input####\nclk %b\treset %b\tpcW %b\npcin %4h\n#####output#####\npcout %4h\n\n", clk, reset, PCWrite, PCin, PCout);

initial
begin
	reset = 0;
	#1 reset = 1;
	#4

	PCWrite = 1;
	PCin = 16'hafaa;

	#7 

	PCin = 16'hffff;
	
	#3

	#10
	PCin = 16'h1110;
	PCWrite = 0;
	
	#10
	PCin = 16'h4646;
	reset = 0;

	#10
	$finish;

end

endmodule
