/*
 * Module by Genesis Dionisio
 */

module mem(
	input [15:0] addr,
	input [15:0] wData,
	input mWrite, mByte, mRead, reset, clk,
	output reg [15:0] data,

	output reg [0:447] memout
);

reg [7:0] mem[65535:0];

// combinational read
always @(*)
begin
	if(!mRead)
	begin	
		if(!mByte)
			data = {mem[addr], mem[addr+1]};
		else
			data = {{8{1'b0}}, mem[addr]}; 
	end
	else
		data = 16'b0;
end


integer j;
always @(posedge clk, negedge reset)
begin	
	if(!reset)
	begin
	mem[8'h00] <= 8'h3a; mem[8'h01] <= 8'hdc;
	mem[8'h02] <= 8'h00; mem[8'h03] <= 8'h00;
	mem[8'h04] <= 8'h13; mem[8'h05] <= 8'h42;
	mem[8'h06] <= 8'had; mem[8'h07] <= 8'hde;
	mem[8'h08] <= 8'hef; mem[8'h09] <= 8'hbe;
	mem[8'h0a] <= 8'hff; mem[8'h0b] <= 8'hff;
	mem[8'h0c] <= 8'h00; mem[8'h0d] <= 8'h00;
	mem[8'h0e] <= 8'haa; mem[8'h0f] <= 8'haa;

		for(j = 8'h10; j < 65536; j = j + 2)
		begin
			mem[j] <= 8'h00; mem[j+1] <= 8'h00;
		end
	end
	else if(!mWrite)
	begin
		if(!mByte)
		begin
		mem[addr+1] = wData[7:0];
		mem[addr] = wData[15:8];
		end
		else
		mem[addr] = wData[7:0];
	end
end

always@(*)
begin
	memout[0:15] <= {mem[0], mem[1]};                                                                   
	memout[16:31] <= {mem[2], mem[3]};                                                                  
	memout[32:47] <= {mem[4], mem[5]};                                                                  
	memout[48:63] <= {mem[6], mem[7]};                                                                  
	memout[64:79] <= {mem[8], mem[9]};                                                                  
	memout[80:95] <= {mem[10], mem[11]};                                                                
	memout[96:111] <= {mem[12], mem[13]};                                                               
	memout[112:127] <= {mem[14], mem[15]};                                                              
	memout[128:143] <= {mem[16], mem[17]};                                                              
	memout[144:159] <= {mem[18], mem[19]};                                                              
	memout[160:175] <= {mem[20], mem[21]};                                                              
	memout[176:191] <= {mem[22], mem[23]};                                                              
	memout[192:207] <= {mem[24], mem[25]};                                                              
	memout[208:223] <= {mem[26], mem[27]};                                                              
	memout[224:239] <= {mem[28], mem[29]};                                                              
	memout[240:255] <= {mem[30], mem[31]};                                                              
	memout[256:271] <= {mem[32], mem[33]};                                                              
	memout[272:287] <= {mem[34], mem[35]};                                                              
	memout[288:303] <= {mem[36], mem[37]};                                                              
	memout[304:319] <= {mem[38], mem[39]};                                                              
	memout[320:335] <= {mem[40], mem[41]};                                                              
	memout[336:351] <= {mem[42], mem[43]};                                                              
	memout[352:367] <= {mem[44], mem[45]};                                                              
	memout[368:383] <= {mem[46], mem[47]};                                                              
	memout[384:399] <= {mem[48], mem[49]};                                                              
	memout[400:415] <= {mem[50], mem[51]};                                                              
	memout[416:431] <= {mem[52], mem[53]};                                                              
	memout[432:447] <= {mem[54], mem[55]}; 
end

endmodule
