`timescale 1ns / 1ns

	module Instruction_Memory(Address, Instruction);
	   parameter BITSIZE = 32;
	   parameter REGSIZE = 32;
	   input [REGSIZE-1:0] Address;
	   output reg [BITSIZE-1:0] Instruction;

	   reg [BITSIZE-1:0] memory_file [0:REGSIZE-1];	// Entire list of memory


	// Asyncronous read of memory. Was not specified.
	always @(Address, memory_file[Address])
	begin
		Instruction = memory_file[Address];
	end

	integer i;

	initial 
		begin
            i = 0;

            i = i+1;
            memory_file[i] = 32'b0000000_00001_00000_000_00001_0011111;
			//addi x1<=x0+1
            
            i = i+1;
            memory_file[i] = 32'b0000000_00000_00001_001_00010_1110011;  
			//add x2 <= x0+x1
			
            i = i+1;
            memory_file[i] = 32'b0000000_00010_00001_010_00000_1100011; 
			//sw Mem[x1+0] <= x2

            // Loading large number with lui and ori: Number 0x12345678

            /* Address 0: lui x1, 0x12345 (x1 <= 0x12345)
            (U-Format - imm[31:12] (Only the upper 20b' are loaded), rd[11:7], opcode[6:0])
            */
            i = i+1;
            memory_file[i] = 32'b00010010001101000101_00001_0110000;  // LUI x1, 0x12345

            /* Address 4: ori x1, x1, 0x678 (x1 <= x1 | 0x678)
            (I-Format - imm[31:20], rs1[19:15], func3[14:12], rd[11:7], opcode[6:0])
            */
            i = i+1;
            memory_file[i] = 32'b011001111000_00001_001_00001_0011111;  // ORI x1, x1, 0x678

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
            memory_file[i] = 32'b0000000_00010_00001_000_01000_1101011;

            /* Address 14: lw x4, 0(x1) (x4 <= Mem[x1 + 0])
            (I-Format - imm[31:20], rs1[19:15], func3[14:12], rd[11:7], opcode[6:0])
            */
            i = i+1;
            memory_file[i] = 32'b000000000000_00001_010_00100_1000011;

            /* Address 18: sw x2, 4(x1) (Mem[x1 + 4] <= x2)
            (S-Format - imm[31:25|11:7], rs2[24:20], rs1[19:15], func3[14:12], imm[11:7], opcode[6:0])
            */
            i = i+1;
            memory_file[i] = 32'b0000000_00010_00001_010_00100_1100011;

            /* Address 1C: and x5, x1, x2 (x5 <= x1 & x2)
            (R-Format - funct7[31:25], rs2[24:20], rs1[19:15], func3[14:12], rd[11:7], opcode[6:0])
            */
            i = i+1;
            memory_file[i] = 32'b0000000_00010_00001_000_00101_1110011;
			
            //or x6 <= x1 | x2
			i = i+1;
			memory_file[i] = 32'b0000000_00001_00010_010_00110_1110011;
			
            //xor x7 <= x1 ^ x4
			i = i+1;
			memory_file[i] = 32'b0000000_00001_00100_100_00111_1110011;
			
            //sra x8 <= x6 >> x2
			memory_file[i] = 32'b0000000_00010_00110_101_01000_1110011;
			
            //sll x9 <= x1 << x8
			memory_file[i] = 32'b0000000_01000_00001_110_01001_1110011;
			
            //slt x10 <= if(x1 < x4)
			memory_file[i] = 32'b0000000_00100_00001_111_01010_1110011;
			
            //blt PC-10 <= if(x1 < x4)
			memory_file[i] = 32'b1111111_00010_00001_001_10101_1101011;
			
            //xori x11 <= x8 ^ 0xAAA
			memory_file[i] = 32'b101010101010_01000_010_01011_0011111;
        end
	endmodule


		