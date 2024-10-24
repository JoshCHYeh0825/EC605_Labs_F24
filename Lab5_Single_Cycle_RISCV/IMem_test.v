`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2024 08:41:19 PM
// Design Name: 
// Module Name: IMem_test
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


module IMem_test();

reg [31:0] address;  // Input address for IMem
wire [31:0] instruction;  // Output instruction from IMem

// Instantiate the Instruction Memory (IMem)
IMem uut (
    .address(address),
    .instruction(instruction)
);

initial begin
    // Initialize the input address
    address = 0;  // Test first instruction (lui)

    #10;
    $display("Address: %h, Instruction: %h", address, instruction);

    // Test next address for the ori instruction
    address = 4;  // Test second instruction (ori)

    #10;
    $display("Address: %h, Instruction: %h", address, instruction);

    // Continue testing more instructions if needed
    // address = ...

    #10;
    $stop;  // End simulation
end

endmodule
