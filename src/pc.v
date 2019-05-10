module pc(
	input reset, clk, PCWrite,
	input [15:0] PCin,
	output reg [15:0] updatedPC
);

always @(posedge clk, negedge reset)
begin
    	if (!reset)
    	begin
    		updatedPC <= 16'h0000;
    	end
		
    	else 
		begin
			if (PCWrite == 1) 
			begin
				updatedPC <= PCin;
			end
    	end
end

endmodule
