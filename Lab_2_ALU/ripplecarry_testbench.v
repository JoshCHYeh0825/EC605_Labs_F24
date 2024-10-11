`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2024 08:36:35 AM
// Design Name: 
// Module Name: ripplecarry_testbench
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


module ripplecarry_testbench(
    
    );
    
    reg[7:0] a, b;
    reg c_in;
    wire [7:0] sum;
    wire c_out;
    
    ripplecarry tb1(.a(a), .b(b), .c_in(c_in), .sum(sum), .c_out(c_out));
    
    initial
    begin
    
    // Monitor changes to inputs and outputs
    $monitor("a = %b, b = %b, c_in = %b, sum = %b, c_out = %b", a, b, c_in, sum, c_out);

    // Test Case 1: Adding 8'b00000001 and 8'b00000001, c_in = 0
    a = 8'b00000001;
    b = 8'b00000001;
    c_in = 1'b0;
    #10;

    // Test Case 2: Adding 8'b11111111 and 8'b00000001, c_in = 0
    a = 8'b11111111;
    b = 8'b00000001;
    c_in = 1'b0;
    #10;

    // Test Case 3: Adding 8'b10101010 and 8'b01010101, c_in = 1
    a = 8'b10101010;
    b = 8'b01010101;
    c_in = 1'b1;
    #10;

    // Test Case 4: Adding 8'b11110000 and 8'b00001111, c_in = 1
    a = 8'b11110000;
    b = 8'b00001111;
    c_in = 1'b1;
    #10;

    // Test Case 5: Adding 8'b00000000 and 8'b00000000, c_in = 0
    a = 8'b00000000;
    b = 8'b00000000;
    c_in = 1'b0;
    #10;

    // End simulation
    $stop;
  
  end 
    
endmodule
