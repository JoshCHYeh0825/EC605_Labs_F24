`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2024 11:46:12 PM
// Design Name: 
// Module Name: clk_divider_test
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


module clk_divider_test();
    
    reg clk;
    reg rst;
    wire clk_out;
    
    clk_divider uut(.rst(rst), .clk(clk), .clk_out(clk_out));
    
     // Generate 100 MHz clock (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle every 5ns to create 100 MHz clock
    end

    initial begin
        rst = 1;
        #20;  
        rst = 0;  

        #1_000_000_000;  
        $stop;  
    end

endmodule
