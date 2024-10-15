`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2024 10:49:51 PM
// Design Name: 
// Module Name: store_switch_test
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


module store_switch_test();
    
    reg reset;
    reg [0:9] inp;
    wire [0:9] outp;
    
    store_switch uut (.reset(reset), .inp(inp), .outp(outp));
    
    initial begin
    
        inp = 10'b0000000000;
        reset = 0;

        #30 inp = 10'b1011011101;
        #5 reset = 1;
        #5 reset = 0;

        #35 inp = 10'b0011010110;
        #95 reset = 1;
        #5 reset = 0;

    // End simulation
        #325 $stop;     
    end

endmodule

