`timescale 1ns / 1ps

module Control_Unit (
    input [6:0] OP,
    input [2:0] FUNCT3,
    input [6:0] FUNCT7,
    output reg [2:0] ALUOp,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite,
    output reg [31:0] ImmExt
);

always @(*) begin
    // Initialize control signals to default values
    RegWrite = 0;
    MemRead = 0;
    MemWrite = 0;
    MemtoReg = 0;
    Branch = 0;
    ALUSrc = 0;
    ALUOp = 3'b000; // Default ALUOp
    ImmExt = 32'b0;

    case (OP)
        7'b1110011: begin // R-format (AND, OR, ADD, SUB, XOR, SRA, SLL, SLT)
            RegWrite = 1;
            ALUSrc = 0;
            case ({FUNCT3, FUNCT7})
                {3'b000, 7'b0000000}: ALUOp = 3'b000; // AND
                {3'b001, 7'b0000000}: ALUOp = 3'b001; // ADD
                {3'b001, 7'b0100000}: ALUOp = 3'b010; // SUB
                {3'b010, 7'b0000000}: ALUOp = 3'b011; // OR
                {3'b100, 7'b0000000}: ALUOp = 3'b100; // XOR
                {3'b101, 7'b0000000}: ALUOp = 3'b101; // SRA
                {3'b110, 7'b0000000}: ALUOp = 3'b110; // SLL
                {3'b111, 7'b0000000}: ALUOp = 3'b111; // SLT
                default: ALUOp = 3'b000; // Default to AND
            endcase
        end

        7'b0011111: begin // I-format (ADDI, ORI, XORI)
            RegWrite = 1;
            ALUSrc = 1;
            ALUOp = 3'b001; // I-type ADDI, ORI, XORI
            ImmExt = {{20{OP[6]}}, OP[5:0], FUNCT3}; // Immediate extension for I-format
        end

        7'b1000011: begin // LW (Load Word)
            RegWrite = 1;
            MemRead = 1;
            MemtoReg = 1;
            ALUSrc = 1;
            ALUOp = 3'b000; // Address calculation for LW
            ImmExt = {{20{OP[6]}}, OP[5:0], FUNCT3}; // Immediate extension for LW
        end

        7'b1100011: begin // SW (Store Word)
            MemWrite = 1;
            ALUSrc = 1;
            ALUOp = 3'b000; // Address calculation for SW
            ImmExt = {{20{OP[6]}}, OP[5:0], FUNCT3}; // Immediate extension for SW
        end

        7'b1101011: begin // Branch (BEQ, BLT)
            Branch = 1;
            ALUSrc = 0;
            ALUOp = 3'b010; // Branch operations
            case (FUNCT3)
                3'b000: ImmExt = {{19{OP[6]}}, OP[5:0], FUNCT3}; // BEQ Immediate extension
                3'b001: ImmExt = {{19{OP[6]}}, OP[5:0], FUNCT3}; // BLT Immediate extension
            endcase
        end

        7'b0110000: begin // LUI (Load Upper Immediate)
            RegWrite = 1;
            ALUSrc = 1;
            ALUOp = 3'b000; // Direct load of immediate for LUI
            ImmExt = {FUNCT7, FUNCT3, 12'b0}; // Immediate upper 20 bits for LUI
        end

        default: begin
            // Default case for unsupported opcodes
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 0;
            MemtoReg = 0;
            Branch = 0;
            ALUSrc = 0;
            ALUOp = 3'b000;
            ImmExt = 32'b0;
        end
    endcase
end

endmodule
