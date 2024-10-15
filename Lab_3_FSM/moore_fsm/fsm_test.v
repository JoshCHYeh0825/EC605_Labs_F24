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
    reg [9:0] switches;   
    reg switch_pause;     
    wire [6:0] seg_display; 
    wire [3:0] led_state;  

    moore_fsm uut (
        .clk(clk),
        .rst(rst),
        .switches(switches),
        .switch_pause(switch_pause),
        .seg_display(seg_display),
        .led_state(led_state)
    );


    always #5 clk = ~clk;  

    initial begin
        clk = 0;
        rst = 0;
        switch_pause = 1;   
        switches = 10'b1010101010; 

        // Apply reset
        #10 rst = 1;
        #10 rst = 0;
        
        #50; 

        // Pause the state machine
        switch_pause = 0;
        #50;

        // Resume the state machine
        switch_pause = 1;
        #50;

        #200 $stop;
    end


endmodule
