/*
 * Module by Genesis Dionisio
 */

module im(
	input [15:0] updatedPC ,
	output reg [15:0]instruction,
	output reg [0:447] imout,
	input reset
);

reg [7:0] im[65535:0];

// combinational read
always @(*)
begin
	instruction = {im[updatedPC], im[updatedPC+1]} ;
end

// async reset
integer j;
always @(negedge reset)
begin
	im[8'h00] <= 8'h01; im[8'h01] <= 8'h20;
	im[8'h02] <= 8'h01; im[8'h03] <= 8'h21;
	im[8'h04] <= 8'h23; im[8'h05] <= 8'hff;
	im[8'h06] <= 8'h13; im[8'h07] <= 8'h4c;
	im[8'h08] <= 8'h05; im[8'h09] <= 8'h64;
	im[8'h0a] <= 8'h04; im[8'h0b] <= 8'h58;
	im[8'h0c] <= 8'h0f; im[8'h0d] <= 8'hf1;
	im[8'h0e] <= 8'h04; im[8'h0f] <= 8'h8d;

	im[8'h10] <= 8'h04; im[8'h11] <= 8'h6f;
	im[8'h12] <= 8'h23; im[8'h13] <= 8'h02;
	im[8'h14] <= 8'h86; im[8'h15] <= 8'h94;
	im[8'h16] <= 8'h96; im[8'h17] <= 8'h96;
	im[8'h18] <= 8'ha6; im[8'h19] <= 8'h96;
	im[8'h1a] <= 8'h67; im[8'h1b] <= 8'h04;
	im[8'h1c] <= 8'h0b; im[8'h1d] <= 8'h10;
	im[8'h1e] <= 8'h47; im[8'h1f] <= 8'h05;

	im[8'h20] <= 8'h0b; im[8'h21] <= 8'h20;
	im[8'h22] <= 8'h57; im[8'h23] <= 8'h02;
	im[8'h24] <= 8'h01; im[8'h25] <= 8'h10;
	im[8'h26] <= 8'h01; im[8'h27] <= 8'h10;
	im[8'h28] <= 8'ha8; im[8'h29] <= 8'h90;
	im[8'h2a] <= 8'h08; im[8'h2b] <= 8'h80;
	im[8'h2c] <= 8'hb8; im[8'h2d] <= 8'h92;
	im[8'h2e] <= 8'haa; im[8'h2f] <= 8'h92;
	
	im[8'h30] <= 8'h0c; im[8'h31] <= 8'hc0;
	im[8'h32] <= 8'h0d; im[8'h33] <= 8'hd1;
	im[8'h34] <= 8'h0c; im[8'h35] <= 8'hd0;
	im[8'h36] <= 8'hf0; im[8'h37] <= 8'h00;

	for(j = 8'h38; j < 65536; j = j + 2)
	begin
		im[j] <= 8'h00; im[j+1] <= 8'h00;
	end
end

always@(*)
begin

        imout[0:15] <= {im[0], im[1]};                                          
        imout[16:31] <= {im[2], im[3]};                                         
        imout[32:47] <= {im[4], im[5]};                                         
        imout[48:63] <= {im[6], im[7]};                                         
        imout[64:79] <= {im[8], im[9]};                                         
        imout[80:95] <= {im[10], im[11]};                                       
        imout[96:111] <= {im[12], im[13]};                                      
        imout[112:127] <= {im[14], im[15]};                                     
        imout[128:143] <= {im[16], im[17]};                                     
        imout[144:159] <= {im[18], im[19]};                                     
        imout[160:175] <= {im[20], im[21]};                                     
        imout[176:191] <= {im[22], im[23]};                                     
        imout[192:207] <= {im[24], im[25]};                                     
        imout[208:223] <= {im[26], im[27]};                                     
        imout[224:239] <= {im[28], im[29]};                                     
        imout[240:255] <= {im[30], im[31]};                                     
        imout[256:271] <= {im[32], im[33]};                                     
        imout[272:287] <= {im[34], im[35]};                                     
        imout[288:303] <= {im[36], im[37]};                                     
        imout[304:319] <= {im[38], im[39]};                                     
        imout[320:335] <= {im[40], im[41]};                                     
        imout[336:351] <= {im[42], im[43]};                                     
        imout[352:367] <= {im[44], im[45]};                                     
        imout[368:383] <= {im[46], im[47]};                                     
        imout[384:399] <= {im[48], im[49]};                                     
        imout[400:415] <= {im[50], im[51]};                                     
        imout[416:431] <= {im[52], im[53]};                                     
        imout[432:447] <= {im[54], im[55]}; 	
	
end

endmodule
