`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2024 09:56:49 PM
// Design Name: 
// Module Name: fsm_test
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


module fsm_test();
    
    reg clk;
    reg rst;
    reg [9:0] switches;   // 10-bit input sequence
    reg switch_pause;     // Pause switch (switch10)
    wire [6:0] seg_display; // Seven-segment display output
    wire [3:0] led_state;  // LED state output for debugging

    // Instantiate the state machine
    moore_fsm uut (
        .clk(clk),
        .rst(rst),
        .switches(switches),
        .switch_pause(switch_pause),
        .seg_display(seg_display),
        .led_state(led_state)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10ns period (100 MHz)

    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        switch_pause = 1;   // Start with the state machine unpaused
        switches = 10'b1010101010; // Set a sample input sequence

        // Apply reset
        #10 rst = 1;
        #10 rst = 0; // Release reset after 10 time units
        
        // Run the state machine normally
        #50; // Wait and observe

        // Pause the state machine
        switch_pause = 0;  // Pause signal activated
        #50;  // Wait while the machine is paused

        // Resume the state machine
        switch_pause = 1;  // Resume operation
        #50;  // Observe resumed operation

        // End the simulation
        #200 $stop;
    end


endmodule
