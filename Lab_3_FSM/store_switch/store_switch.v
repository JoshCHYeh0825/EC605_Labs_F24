`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2024 10:45:49 PM
// Design Name: 
// Module Name: store_switch
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


module store_switch(
    input wire rst,
    input wire [0:9] inp,
    output reg [0:9] outp
    );
    
    always @(rst) begin
        if (rst) begin
            outp <= inp;
        end
     end
endmodule
