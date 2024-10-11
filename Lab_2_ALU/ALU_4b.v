`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2024 04:26:34 PM
// Design Name: 
// Module Name: ALU_4b
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU_4b(
   input [3:0] a, b, //A & B 4b inputs
   input [2:0] OP, //3B OPCode
   output [3:0] result, //4b Result
   output n, //Flag N
   output z, //Flag Z
   output c, //Flag C
   output v //Flag V
);  
    assign result = (OP==3'b000) ? a & b:
    (OP==3'b001) ? a | b:
    (OP==3'b010) ? ~(a | b):
    (OP==3'b011) ? a >> b:
    (OP==3'b100) ? a << b:
    (OP==3'b101) ? a - b:
    (OP==3'b110) ? a + b:
    (OP==3'b111) ? (a < b)? 1:0:
    
    
endmodule
