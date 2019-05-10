module comparator(
	//inputs
	input [15:0] data1,
	input [15:0] r15,
	input reset,
	
	//outputs
	output reg gt,
	output reg lt,
	output reg equal
);


always@(*)
begin
	equal = 0;
	lt = 0;
	gt = 0;

	if (data1<r15)
		lt = 1;
	
	if (data1==r15) 
		equal = 1;
	
	if (data1>r15)
		gt = 1;
end

always@(negedge reset)
begin
	gt <= 0;
	lt <= 0;
	equal <= 0;
end

endmodule
	
