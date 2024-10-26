`timescale 1ns / 1ps

module ALU_32b(
   input [32:0] a, b, //A & B 32b inputs
   input [3:0] OP, //4B OPCode
   output [32:0] result, //32b Result
   output 0F, // Zero Flag
   output n, //Flag N
   output z, //Flag Z
   output c, //Flag C
   output v //Flag V

);  
    assign result =
    (OP == 4'b0000) ? a & b:
    (OP == 4'b0001) ? a | b:
    (OP == 4'b0010) ? a ^ b:
    (OP == 4'b0011) ? a >>> b:
    (OP == 4'b1000) ? a << b:
    (OP == 4'b0101) ? a - b:
    (OP == 4'b0110) ? a + b:
    (OP == 4'b0111) ? (a < b)? 1:0:
    
    
endmodule