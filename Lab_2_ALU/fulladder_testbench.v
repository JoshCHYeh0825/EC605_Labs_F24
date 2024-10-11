`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2024 07:43:08 PM
// Design Name: 
// Module Name: fulladder_testbench
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


module fulladder_testbench(

    );
    
    reg a, b, c_in;
    wire sum, c_out;
    
    fulladder tb1(a, b, c_in, sum, c_out);
    
    initial
    begin
     a = 0; b = 0; c_in = 0;
      
     #10 a = 1'b0; b = 1'b0; c_in = 1'b1;
     #10 a = 1'b0; b = 1'b1; c_in = 1'b0;  
     #10 a = 1'b0; b = 1'b1; c_in = 1'b1;
     #10 a = 1'b1; b = 1'b0; c_in = 1'b0;
     #10 a = 1'b1; b = 1'b0; c_in = 1'b1;
     #10 a = 1'b1; b = 1'b1; c_in = 1'b0; 
     #10 a = 1'b1; b = 1'b1; c_in = 1'b1;  
     #10 $finish;
    end

endmodule
