/*
 * Module by Chase Jones
 */

module regfile(
	input [1:0] rWrite,
	input [3:0] op1, op2, wop1, wop2,
	input [15:0] wdata1, wdata2, r15data,
	input clk, reset,
	
	output reg [15:0] data1, data2, r15dataout,
	output reg [0:255] regout
);

reg [15:0] registers [15:0];
integer i;

always@(posedge clk, negedge reset)
begin
	if(!reset)
	begin
	registers[0] = 16'h0000;
	registers[1] = 16'h0f00;                                                                 
	registers[2] = 16'h0050;                                                                 
	registers[3] = 16'hff0f;                                                                 
	registers[4] = 16'hf0ff;                                                                 
	registers[5] = 16'h0040;                                                                 
	registers[6] = 16'h6666;                                                                 
	registers[7] = 16'h00ff;                                                                 
	registers[8] = 16'hff77;                                                                 
	registers[9] = 16'h0000;                                                                 
	registers[10] = 16'h0000;                                                                
	registers[11] = 16'h0000;                                                                
	registers[12] = 16'hcc89;                                                                
	registers[13] = 16'h0002;                                                                
	registers[14] = 16'h0000;                                                                
	registers[15] = 16'h0000; 
	end

	else 
	begin
		case (rWrite)
	
		2'b00:
		begin
		registers[wop1] <= registers[wop1];
		registers[wop2] <= registers[wop2];
		registers[15] <= registers[15];
 		end

		2'b01:
		begin
		registers[wop1] <= wdata1;
		registers[wop2] <= registers[wop2];
		registers[15] <= registers[15];
		end

		2'b10:
		begin
		registers[wop1] <= wdata1;
		registers[wop2] <= wdata2;
		registers[15] <= registers[15];
		end

		2'b11:
		begin
		registers[wop1] <= wdata1;
		registers[wop2] <= registers[wop2];
		registers[15] <= r15data;
		end
		
		endcase
	end
end

always@(*)
begin
	data1 = registers[op1];
	data2 = registers[op2];
	r15dataout = registers[15];
end

always@(*)
begin
	regout[0:15] <= registers[0];                                              
	regout[16:31] <= registers[1];                                             
	regout[32:47] <= registers[2];                                             
	regout[48:63] <= registers[3];                                             
	regout[64:79] <= registers[4];                                             
	regout[80:95] <= registers[5];                                             
	regout[96:111] <= registers[6];                                            
	regout[112:127] <= registers[7];                                           
	regout[128:143] <= registers[8];                                           
	regout[144:159] <= registers[9];                                           
	regout[160:175] <= registers[10];                                          
	regout[176:191] <= registers[11];                                          
	regout[192:207] <= registers[12];                                          
	regout[208:223] <= registers[13];                                          
	regout[224:239] <= registers[14];                                          
	regout[240:255] <= registers[15];

end

endmodule
