`timescale 1ns / 1ns
	module Instruction_Memory(Address, ReadData1);
	parameter BITSIZE = 32;
	parameter REGSIZE = 32;
	input [REGSIZE-1:0] Address;
	output reg [BITSIZE-1:0] ReadData1;

	reg [BITSIZE-1:0] memory_file [0:REGSIZE-1];	// Entire list of memory


	// Asyncronous read of memory. Was not specified.
	always @(Address, memory_file[Address])
	begin
		ReadData1 = memory_file[Address];
	end

	integer i;
	// method of filling the memory instead of through a test bench
	initial
		begin
            i = 0;

            i = i+1;
            memory_file[i] = 32'b000000000001_00000_000_00001_0011111;  
            
            i = i+1;
            memory_file[i] = 32'b0000000_00000_00001_001_00010_1110011;  

            i = i+1;
            memory_file[i] = 32'b0000000_00010_00001_010_00000_1100011;  

            // Address 0: lui x1, 0x00010
            i = i+1;
            memory_file[i] = 32'b0000000000010000100_10001_0110111;

            // Address 4: ori x1, x1, 0x004
            i = i+1;
            memory_file[i] = 32'b0000000_00100_00001_000_00101_11000111;

            // Address 8: add x2, x1, x0 (x2 <= x1 + x0)
            i = i+1;
            memory_file[i] = 32'b0000000_00000_00001_000_00010_0110011;

            // Address C: sub x3, x1, x0 (x3 <= x1 - x0)
            i = i+1;
            memory_file[i] = 32'b0100000_00000_00001_000_00011_0110011;

            // Address 10: beq x1, x2, 8 (Branch if x1 == x2, offset 8)
            i = i+1;
            memory_file[i] = 32'b0000000_00010_00001_000_00000_1100011;


            // Address 14: lw x4, 0(x1) (Load word from address in x1 into x4)
            i = i+1;
            memory_file[i] = 32'b000000000000_00001_010_00100_0000011;

            // Address 18: sw x2, 4(x1) (Store word from x2 to address x1 + 4)
            i = i+1;
            memory_file[i] = 32'b0000000_00010_00001_010_00010_0100011;

            // Address 1C: jal x5, 16 (Jump and link to PC + 16)
            i = i+1;
            memory_file[i] = 32'b000000000001_00001_000_00101_1101111;

        end
	endmodule

