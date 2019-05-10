/*
 * Module by Genesis Dionisio
 */

module aluCtrl
(
	input [1:0] useFunc,
	input [3:0] func,
	input fwdA,
	input fwdB,
	output reg [2:0] aluSelect,
	output reg [1:0] aMux,
	output reg [1:0] bMux
);

always @(*)
begin
	//aluSelect 
	if ((useFunc == 2'b00 && func == 4'b0000 )|| useFunc == 2'b01)
	begin
	aluSelect = 3'b000;
	end	
	
	else if (useFunc == 2'b00 && func == 4'b0001)
	begin
	aluSelect = 3'b001;
	end
	
	else if (useFunc == 2'b00 && func == 4'b0100)
	begin
	aluSelect = 3'b010;
	end

	else if(useFunc == 2'b00 && func == 4'b1000)
	begin
	aluSelect = 3'b011;
	end
	
	else if(useFunc == 2'b00 && func == 4'b1110)
	begin
	aluSelect = 3'b100;
	end
	
	else if(useFunc == 2'b00 && func == 4'b1111)
	begin
	aluSelect = 3'b101;
	end
	
	else if(useFunc == 2'b11)
	begin
	aluSelect = 3'b110;
	end
	
	else if(useFunc == 2'b10)
	begin
	aluSelect =3'b111;
	end

	else
	begin
	aluSelect = 3'b000;
	end
end

always@(*)
begin
	//aMux
	if(fwdA == 1)
	begin
	aMux = 2'b11;
	end

	else if ((useFunc  == 2'b00 && func != 4'b1110 ) ||  useFunc >= 2'b10)
	begin
	aMux = 2'b00;
	end
	
	else if (useFunc == 2'b01)
	begin
	aMux = 2'b01;
	end
	
	else if (useFunc == 2'b11)
	begin
	aMux = 2'b10;
	end
	
	else
		aMux <= 2'b00;
end

always @(*)
begin
	//bMux
	if(fwdB == 1)
	begin
	bMux = 2'b10;
	end
	
	else if (useFunc >= 2'b10)
	begin
	bMux = 2'b01;
	end
	
	else
	begin
	bMux =2'b00;
	end
	
end

endmodule
