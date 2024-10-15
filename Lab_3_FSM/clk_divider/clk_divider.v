`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2024 11:44:06 PM
// Design Name: 
// Module Name: clk_divider
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


module clk_divider(
    input clk,   
    input rst,   
    output reg clk_out  
    );

    reg [26:0] div_count; // 27-bit counter to hold up to 100,000,000

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            div_count <= 0;
            clk_out <= 0;
        end
        else begin 
            if (div_count == 50_000_000 - 1) begin
                div_count <= 0;
                clk_out <= ~clk_out;
                end
                else begin
                    div_count <= div_count + 1;
                end
             end
          end
             
endmodule