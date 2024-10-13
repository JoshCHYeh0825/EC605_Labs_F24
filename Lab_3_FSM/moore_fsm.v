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
    
    // State 0 Initiation
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= state_init;
            counter_101 <= 0;
            sequence <= switches;
        
        end else if (switch_pause == 0) begin
            state <= state_pause;
        
        end else begin
            state <= next_state;
        end
    end
    
    // State Transitions
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= state_init;
            match_counter <= 0;
            sequence <= switches; // Load switches into sequence register on reset
        end else if (switch_pause == 0) begin
            state <= state_pause; // Paused state when switch10 is low
        end else begin
            state <= next_state; // Update to the next state when unpaused
        end
    end

    // Next state and output
    always @(*) begin
        next_state = state; // Default state
        case (state)
            state_init: begin
                seg_display = 7'b1000000; // Display "0"
                if (switch_pause == 1) begin
                    if (sequence[9:7] == 3'b101) begin // Detect "101"
                        next_state = state_101_1;
                        match_counter = match_counter + 1;
                    end
                end
            end
            
            state_101_1: begin
                seg_display = 7'b1111001; // Display "1"
                if (sequence[6:4] == 3'b101) begin
                    next_state = state_101_2;
                    match_counter = match_counter + 1;
                end
            end
            
            state_101_2: begin
                seg_display = 7'b0100100; // Display "2"
                if (sequence[3:1] == 3'b101) begin
                    next_state = state_101_3;
                    match_counter = match_counter + 1;
                end
            end
            
            state_101_3: begin
                seg_display = 7'b0000001; // Display "3"
                // Stay here or go back to initial state after full detection
            end
            
            state_pause: begin
                seg_display = 7'b1111110; // Display "OFF" (just an example)
                if (switch_pause == 1) begin
                    next_state = state; // Stay in pause state
                end
            end
        endcase
    end
    
    // LED indicator for debugging (shows the current state)
    always @(*) begin
        case (state)
            state_init: led_state = 4'b0001;
            state_101_1: led_state = 4'b0010;
            state_101_2: led_state = 4'b0100;
            state_101_3: led_state = 4'b1000;
            state_pause: led_state = 4'b1111; // Show "pause" with all LEDs on
        endcase
    end
        
endmodule
