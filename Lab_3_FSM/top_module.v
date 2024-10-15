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
    input wire clk,          
    input wire rst,          
    input wire [9:0] switches, 
    input wire button,       
    output wire [6:0] seg, 
    output wire [6:0] seg1, 
    output wire [6:0] seg2, 
    output wire [6:0] seg3  
    );

    wire clk_1hz;           // Output of the clock divider
    wire [9:0] sequence_out; // Output from the store_switch
    wire [6:0] seg_fsm;     // Output from the state machine to the seven-segment display
    wire sm_active; // To track if the state machine is active or paused


    // Instantiate the clock divider
    clk_divider clk_div_fpga (
        .clk(clk),        
        .rst(rst),        
        .clk_out(clk_1hz) 
    );

    // Instantiate store_switch
    store_switch store_switch_fpga (
        .rst(rst),           
        .inp(switches),        
        .outp(sequence_out)    
    );

    // Instantiate Moore FSM
    moore_fsm fsm_fpga (
        .clk(clk_1hz),          
        .rst(rst),            
        .switches(sequence_out),
        .switch_pause(button),         
        .seg_display(seg_fsm),
        .led_state(sm_active) // State machine status (active = 1, paused = 0)           
    );

  // Output the seven-segment display
    assign seg = seg_fsm;
    
    // Optionally, use three more seven-segment displays to indicate ON/OFF state
    // for debugging or display purposes (if needed).
    assign seg1 = sm_active ? 7'b1000110 : 7'b1111110; // 'O' or ' '
    assign seg2 = sm_active ? 7'b0000110 : 7'b1111110; // 'N' or ' '
    assign seg3 = sm_active ? 7'b0111111 : 7'b1111110; // 'F' or ' '

endmodule