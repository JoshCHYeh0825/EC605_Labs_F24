`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2024 07:05:26 AM
// Design Name: 
// Module Name: top_module
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


module top_module(
    input wire clk,          // 100 MHz input clock
    input wire rst,          // Reset button input
    input wire [9:0] switches, // 10-bit binary sequence input
    input wire button,       // On/Off control (pause button)
    output wire [6:0] seg,   // Main seven-segment display output
    output wire [6:0] seg1,  // Additional seven-segment display 1
    output wire [6:0] seg2,  // Additional seven-segment display 2
    output wire [6:0] seg3,   // Additional seven-segment display 3
    output wire [3:0] led_state //LED state output
);

    wire clk_1hz;           // Clock divider output (1 Hz clock)
    wire [9:0] sequence_out; // Output from the store_switch
    wire [6:0] seg_fsm;     // Seven-segment display output from FSM
    wire sm_active;         // State machine active status (on = 1, off = 0)

    // Instantiate the clock divider
    clk_divider clk_div_fpga (
        .clk(clk),           // 100 MHz clock input
        .rst(rst),           // Reset input
        .clk_out(clk_1hz)    // 1 Hz clock output
    );

    // Instantiate store_switch
    store_switch store_switch_fpga (
        .rst(rst),           // Reset signal
        .inp(switches),        // 10-bit sequence input from switches
        .outp(sequence_out)    // Stored 10-bit sequence output
    );

    // Instantiate the Moore FSM 
    moore_fsm fsm_fpga (
        .clk(clk_1hz),         // 1 Hz clock input
        .rst(rst),             // Reset input
        .switches(sequence_out), // Sequence input from store_switch
        .switch_pause(button),  // Pause switch (On/Off control)
        .seg_display(seg_fsm),  // Seven-segment display output
        .led_state(led_state)   // Active state indicator
    );

    // Main seven-segment display
    assign seg = seg_fsm;

    // Additional seven-segment displays for showing "ON" or "OFF"
    assign seg1 = sm_active ? 7'b1000110 : 7'b1111110; // 'O' or ' ' (blank)
    assign seg2 = sm_active ? 7'b0000110 : 7'b1111110; // 'N' or ' ' (blank)
    assign seg3 = sm_active ? 7'b1111111 : 7'b0001110; // ' ' (blank) or 'F'

endmodule
