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

            // Loading large number with lui and ori: Number 0x12345678

            /* Address 0: lui x1, 0x12345 (x1 <= 0x12345)
            (U-Format - imm[31:12] (Only the upper 20b' are loaded), rd[11:7], opcode[6:0])
            */
            i = i+1;
            memory_file[i] = 32'b00000001001000110101_00001_0110111;  // LUI x1, 0x12345

            /* Address 4: ori x1, x1, 0x678 (x1 <= x1 | 0x678)
            (I-Format - imm[31:20], rs1[19:15], func3[14:12], rd[11:7], opcode[6:0])
            */
            i = i+1;
            memory_file[i] = 32'b000000110011_00001_001_00001_0010011;  // ORI x1, x1, 0x678

            /* Address 8: add x2, x1, x0 (x2 <= x1 + x0)
            (R-Format - funct7[31:25], rs2[24:20], rs1[19:15], func3[14:12], rd[11:7], opcode[6:0])
            */
            i = i+1;
            memory_file[i] = 32'b0000000_00000_00001_001_00010_1110011;

            /* Address C: sub x3, x1, x0 (x3 <= x1 - x0)
            (R-Format - funct7[31:25], rs2[24:20], rs1[19:15], func3[14:12], rd[11:7], opcode[6:0])
            */
            i = i+1;
            memory_file[i] = 32'b0100000_00000_00001_001_00011_1110011;

            /* Address 10: beq x1, x2, 8 (Branch if x1 == x2, offset 8)
            (B-Format - imm[31:25|11:7], rs2[24:20], rs1[19:15], func3[14:12], imm[11:7], opcode[6:0])
            */
            i = i+1;
            memory_file[i] = 32'b0000000_00010_00001_000_00010_1101011;

            /* Address 14: lw x4, 0(x1) (x4 <= Mem[x1 + 0])
            (I-Format - imm[31:20], rs1[19:15], func3[14:12], rd[11:7], opcode[6:0])
            */
            i = i+1;
            memory_file[i] = 32'b000000000000_00001_010_00100_1000011;

            /* Address 18: sw x2, 4(x1) (Mem[x1 + 4] <= x2)
            (S-Format - imm[31:25|11:7], rs2[24:20], rs1[19:15], func3[14:12], imm[11:7], opcode[6:0])
            */
            i = i+1;
            memory_file[i] = 32'b0000000_00010_00001_010_00010_1100011;

            /* Address 1C: and x5, x1, x2 (x5 <= x1 & x2)
            (R-Format - funct7[31:25], rs2[24:20], rs1[19:15], func3[14:12], rd[11:7], opcode[6:0])
            */
            i = i+1;
            memory_file[i] = 32'b0000000_00010_00001_000_00101_1110011;

        end
	endmodule

