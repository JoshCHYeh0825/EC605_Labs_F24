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


module moore_fsm (
    input clk,
    input rst,
    input [9:0] switches,   // This input will now directly take the sequence from store_switch
    input switch_pause,
    output reg [6:0] seg_display,
    output reg [3:0] led_state
);
    
    // State machine registers
    reg [2:0] state, next_state;
    reg [3:0] counter_101;  // Counter for "101" detections
    
    // State 0 Initiation
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= state_init;
            counter_101 <= 0;
        end else if (switch_pause == 0) begin
            state <= state_pause;
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        next_state = state; // Default state
        case (state)
            state_init: begin
                seg_display = 7'b1000000; // Display "0"
                if (switch_pause == 1) begin
                    if (switches[9:7] == 3'b101) begin // Detect "101"
                        next_state = state_101_1;
                        counter_101 = counter_101 + 1;
                    end
                end
            end
        endcase
    end

    // LED indicator for debugging (same as before)
    always @(*) begin
        case (state)
            state_init: led_state = 4'b0001;
            state_101_1: led_state = 4'b0010;
            state_101_2: led_state = 4'b0100;
            state_101_3: led_state = 4'b1000;
            state_pause: led_state = 4'b1111;
        endcase
    end      
endmodule
