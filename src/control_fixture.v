/*
 * Module by Chase Jones
 */
`include "control.v"
module control_fixture();

reg [3:0] opcode, func;
reg jorb, reset;
wire [1:0] bType, rWrite, useFunc;
wire mWrite, mRead, mByte, j, offsetSel;

control	ctrl(.opcode(opcode), .func(func), .bType(bType), .rWrite(rWrite), .mWrite(mWrite), .useFunc(useFunc), .mRead(mRead), .mByte(mByte), .j(j), .offsetSel(offsetSel), .jorb(), .reset(reset));

initial $vcdpluson;

initial $monitor("#####INPUTS#####\nopcode %4b\tfunc %4b\n#####OUTPUTS#####\nbType: %2b\trWrite: %2b\tuseFunc: %2b\nmWrite: %b\tmRead: %b\tmByte: %b\tj: %b\toffsetSel: %b\n\n", opcode, func, bType, rWrite, useFunc, mWrite, mRead, mByte, j, offsetSel);

initial 
begin
#5
$display("testing add");
opcode = 4'b0000;                                                            
func = 4'b0000;                                                              

#5
$display("testing sub");                                                                             
opcode = 4'b0000;                                                            
func = 4'b0001;         
 
#5                                                    
$display("testing mult");                                                                             
opcode = 4'b0000;                                                            
func = 4'b0100;                                                              
 
#5                        
$display("testing div");                                                    
opcode = 4'b0000;                                                            
func = 4'b1000;                                                              
 
#5                       
$display("testing move");                                                     
opcode = 4'b0000;                                                            
func = 4'b1110;                                                              
 
#5                        
$display("testing swap");                                                    
opcode = 4'b0000;                                                            
func = 4'b1111;                                                              
 
#5                        
$display("testing lbu");                                                    
opcode = 4'b1000;                                                            
 
#5                       
$display("testing lw");                                                     
opcode = 4'b1010;      
 
#5                    
$display("testing sb");
opcode = 4'b1001;
 
#5                                
$display("testing sw");                                                                             
opcode = 4'b1011;                                                            
 
#5                      
$display("testing blt");                                                      
opcode = 4'b0100;                                                            
 
#5                      
$display("testing bgt");                                                      
opcode = 4'b0101;                                                            
 
#5                       
$display("testing beq");                                                     
opcode = 4'b0110;                                                            
 
#5                       
$display("testing and");                                                     
opcode = 4'b0001;                                                            
 
#5                       
$display("testing or");                                                     
opcode = 4'b0010;                                                            
 
#5                       
$display("testing j");                                                     
opcode = 4'b1100;                                                            
 
#5                     
$display("testing halt");                                                      
opcode = 4'b1111;

end

endmodule
