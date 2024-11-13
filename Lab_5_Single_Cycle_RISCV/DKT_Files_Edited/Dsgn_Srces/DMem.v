`timescale 1ns / 1ns

module Data_Memory(clk, rst, Address, WriteData, MemWrite, MemRead, ReadData);

    parameter BITSIZE = 32;
    parameter HEIGHT = 64;
    input [31:0] Address;
    input [BITSIZE-1:0] WriteData;
    input MemWrite, MemRead;
    output [BITSIZE-1:0] ReadData;
    input clk, rst;

    reg [BITSIZE-1:0] memory [HEIGHT-1:0];        // 64 locations, each 32 bits wide

    integer i;

    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < HEIGHT; i = i + 1) begin
                memory[i] <= 32'b0;
            end
        end else if (MemWrite) begin
            memory[Address] <= WriteData; // Write data to specified address
        end
    end

    // Continuous assignment for ReadData
    assign ReadData = (MemRead) ? memory[Address] : 32'b0;
    
endmodule