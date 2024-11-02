`timescale 1ns / 1ns
module Data_Memory(clk, rst, Address, WriteData, MemWrite, MemRead, ReadData);

    parameter BITSIZE = 32;
    parameter HEIGHT = 64;

    input [5:0] Address;
    input [BITSIZE-1:0] WriteData;
    input MemWrite, MemRead;
    output reg [BITSIZE-1:0] ReadData;
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

    // Read data (asynchronous read)
	assign ReadData = (MemRead)? memory[Address]: 32'bz;

endmodule

module t_Data_Memory();
	
	parameter BITSIZE = 32;
	
	reg [5:0] Address;
	reg [BITSIZE-1:0] WriteData;
	reg clk, rst, MemWrite, MemRead;
	wire [BITSIZE-1:0] ReadData;
	
	module Data_Memory DM (clk, rst, Address, WriteData, MemWrite, MemRead, ReadData);
	
	integer i;
	
	initial
	begin
	i = 0;
	rst = 1'b1;
	clk = 1'b0;
	Address = 6'b0;
	WriteData = 32'b0;
	MemWrite = 1'b0;
	MemRead = 1'b0;
	for(i=0; i<64; i= i+1)
	begin
	Address = i;
	WriteData = i;
	MemWrite = 1'b1;
	#2
	clk = 1'b1;
	#2
	clk = 1'b0;
	end
	Address = 6'b0;
	MemRead = 1'b1;
	for(i=0; i<64; i= i+1)
	begin
	Address = i;
	end
	$finish
endmodule
	
	