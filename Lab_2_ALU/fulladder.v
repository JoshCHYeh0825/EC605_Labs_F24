`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2024 07:25:46 PM
// Design Name: 
// Module Name: fulladder
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


module fulladder(
    input a,
    input b,
    input c_in,
    output sum,
    output c_out
    );
    
    wire w1, w2, w3;
    
    xor xor1(w1, a, b);
    xor #(2) xo2(sum, w1, c_in);

    and #(1) and_1(w2, b, a);
    and #(1) and_2(w3, c_in, w1);
    
    or #(1) or1(c_out, w2, w3);
    
endmodule
