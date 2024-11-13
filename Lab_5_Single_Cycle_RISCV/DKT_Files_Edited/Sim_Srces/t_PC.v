`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2024 01:37:43 PM
// Design Name: 
// Module Name: t_PC
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

module t_PC();
parameter BITSIZE = 32;
reg [BITSIZE-1:0] pc_next;
reg clk, reset;
wire [BITSIZE-1:0] pc_out;

Program_Counter PC(pc_next,
 clk,
 reset,
 pc_out);

initial begin
clk = 0;
reset = 0;
pc_next = 32'b0;
forever #5 clk <= ~clk;
end

always @(posedge clk) begin
#7  pc_next = pc_next +  1;
#12 reset = 1;
#15 reset = 0;
#20 pc_next = 32'hFFFFFFFF;
#25 $finish;
end

endmodule
