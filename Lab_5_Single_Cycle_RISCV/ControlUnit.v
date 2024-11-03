`timescale 1ns / 1ps

module Control_Unit (
    
    input [6:0] OP,
    input [2:0] FUNCT3,
    input [2:0] FUNCT7,
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
        ALUOp = 2'b00;
        ImmExt = 32'b0;

        case (opcode)
            7'b0110011: begin // R-format instructions (AND, OR, ADD, SUB, etc.)
                RegWrite = 1;
                ALUSrc = 0;
                ALUOp = 2'b10; // R-type operations
            end

            7'b0010011: begin // I-format (e.g., ADDI, ORI, XORI)
                RegWrite = 1;
                ALUSrc = 1;
                ALUOp = 2'b11; // Custom I-type operation handling
                // Extend immediate for I-type instructions
                ImmExt = {{20{funct7[6]}}, funct7[5:0], funct3}; 
            end

            7'b0000011: begin // LW (Load Word)
                RegWrite = 1;
                MemRead = 1;
                MemtoReg = 1;
                ALUSrc = 1;
                ALUOp = 2'b00; // Use ALU to calculate address
                ImmExt = {{20{funct7[6]}}, funct7[5:0], funct3}; 
            end

            7'b0100011: begin // SW (Store Word)
                MemWrite = 1;
                ALUSrc = 1;
                ALUOp = 2'b00; // Address calculation
                ImmExt = {{20{funct7[6]}}, funct7[5:0], funct3}; 
            end

            7'b1100011: begin // Branch (BEQ, BLT)
                Branch = 1;
                ALUSrc = 0;
                ALUOp = 2'b01; // Branch operations
                ImmExt = {{19{funct7[6]}}, funct7[5:0], funct3}; 
            end

            7'b0110111: begin // LUI (Load Upper Immediate)
                RegWrite = 1;
                ALUSrc = 1;
                ALUOp = 2'b00; // Direct load of immediate
                ImmExt = {funct7, funct3, 12'b0}; // Upper 20 bits only
            end

            default: begin
                // Default case for unsupported opcodes
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                MemtoReg = 0;
                Branch = 0;
                ALUSrc = 0;
                ALUOp = 2'b00;
                ImmExt = 32'b0;
            end
        endcase
    end
endmodule
