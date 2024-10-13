`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2024 09:26:49 AM
// Design Name: 
// Module Name: moore_fsm
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


module moore_fsm(
    input clk,
    input rst,
    input [9:0] switches,
    input switch_pause,
    output reg [6:0] seg_display,
    output reg [3:0] led_state
    );
    
    //State encoding
    parameter state_init = 3'b000;
    parameter state_101_1 = 3'b001;
    parameter state_101_2 = 3'b010;
    parameter state_101_3 = 3'b101;
    parameter state_pause = 3'b100;
    
    reg [2:0] state, next_state;
    reg [3:0] counter_101;
    reg [9:0] sequence;
    
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= state_init;
            counter_101 <= 0;
            sequence <= switches;
       end
       else if (switch_pause == 0) begin
        state <= state_pause;
       end
       else begin
        state <= next_state;
        
endmodule
