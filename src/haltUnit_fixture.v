`include "haltUnit.v"
module haltUnit_fixture();

reg [3:0]Opcode;
wire IDExFlush, IFIDFlush;

haltUnit	hu(.Opcode(Opcode), .IDExFlush(IDExFlush), .IFIDFlush(IFIDFlush));

initial $vcdpluson;
initial $monitor("op %1h\nidexF %b\nifidF%b\n\n", Opcode, IDExFlush, IFIDFlush);

integer i;
initial
begin
	for(i = 0; i < 16; i = i +1)
	begin
		#5
		Opcode = i;
	end
	#5
	$finish;
end

endmodule
