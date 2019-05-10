/*
 * Module by Chase Jones
 */
`include "im.v"
module im_fixture();

reg [15:0] updatedPC;
reg reset;
wire [15:0] instruction;
wire [0:447] imout;

im	im(.updatedPC(updatedPC), .reset(reset), .instruction(instruction), .imout(imout));

initial $vcdpluson;

initial $monitor("#####INPUT#####\nupdatedPC = %4h\treset = %b\n#####OUTPUT#####\ninstruction = %4h\n00: %h %h\t02: %h %h\n04: %h %h\t06: %h %h\n08: %h %h\t0a: %h %h\n0c: %h %h\t0e: %h %h\n10: %h %h\t12: %h %h\n14: %h %h\t16: %h %h\n18: %h %h\t1a: %h %h\n1c: %h %h\t1e: %h %h\n20: %h %h\t22: %h %h\n24: %h %h\t26: %h %h\n28: %h %h\t2a: %h %h\n2c: %h %h\t2e: %h %h\n30: %h %h\t32: %h %h\n34: %h %h\t36: %h %h\n\n", updatedPC, reset, instruction, imout[0:7], imout[8:15], imout[16:23], imout[24:31], imout[32:39], imout[40:47], imout[48:55], imout[56:63], imout[64:71], imout[72:79], imout[80:87], imout[88:95], imout[96:103], imout[104:111], imout[112:119], imout[120:127], imout[128:135], imout[136:143], imout[144:151], imout[152:159], imout[160:167], imout[168:175], imout[176:183], imout[184:191], imout[192:199], imout[200:207], imout[208:215], imout[216:223], imout[224:231], imout[232:239], imout[240:247], imout[248:255], imout[256:263], imout[264:271], imout[272:279], imout[280:287], imout[288:295], imout[296:303], imout[304:311], imout[312:319], imout[320:327], imout[328:335], imout[336:343], imout[344:351], imout[352:359], imout[360:367], imout[368:375], imout[376:383], imout[384:391], imout[392:399], imout[400:407], imout[408:415], imout[416:423], imout[424:431], imout[432:439], imout[440:447]);

initial reset = 0;


integer i;

initial 
begin
	#5
	reset = 1;
	updatedPC = 0;

	for(i = 0; i < 5; i= i+1)
	begin
	#5 updatedPC = updatedPC+2;
	end

	#5
	$finish;

end

endmodule
