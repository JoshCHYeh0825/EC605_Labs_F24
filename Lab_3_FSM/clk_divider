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
    input wire clk,   // 100 MHz input clock
    input wire rst,   // Reset signal
    output reg clk_out  // 1 Hz output clock
    );

    reg [26:0] counter; // 27-bit counter to hold up to 100,000,000

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            clk_out <= 0;
        end
        else begin
            if (counter == 50_000_000 - 1) begin  // Count up to half of 100,000,000
                counter <= 0;
                clk_out <= ~clk_out;  // Toggle output clock
            end
            else begin
                counter <= counter + 1;
            end
        end
    end

endmodule
