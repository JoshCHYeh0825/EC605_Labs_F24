`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2024 03:12:09 PM
// Design Name: 
// Module Name: ripplecarry
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


module ripplecarry(
    input [7:0] a,
    input [7:00] b,
    input c_in,
    output [7:0] sum,
    output c_out
    );
    
    wire [6:0] c;
    
    fulladder F1(a[0], b[0], c_in, sum[0], c[0]);
    fulladder F2(a[1], b[1], c[0], sum[1], c[1]);
    fulladder F3(a[2], b[2], c[1], sum[2], c[2]);
    fulladder F4(a[3], b[3], c[2], sum[3], c[3]);
    fulladder F5(a[4], b[4], c[3], sum[4], c[4]);
    fulladder F6(a[5], b[5], c[4], sum[5], c[5]);
    fulladder F7(a[6], b[6], c[5], sum[6], c[6]);
    fulladder F8(a[7], b[7], c[6], sum[7], c_out);
    
endmodule
