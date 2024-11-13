`timescale 1ns / 1ps

module Control_Unit (
    input [31:0] Instruction, 
    output reg [3:0] ALUOp,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite,
    output reg [31:0] ImmExt
);

    wire [6:0] OP = Instruction[6:0];      // OPCode
    wire [2:0] FUNCT3 = Instruction[14:12]; // FUNCT3 
    wire [6:0] FUNCT7 = Instruction[31:25]; // FUNCT7 

    always @(*) begin
        // Initialize control signals to default values
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        MemtoReg = 0;
        Branch = 0;
        ALUSrc = 0;
        ALUOp = 4'b0000;
        ImmExt = 32'b0;

        case (OP)
            // R-format: AND, OR, ADD, SUB, XOR, SRA, SLL, SLT
            7'b1110011: begin
                RegWrite = 1;
                ALUSrc = 0;
                case ({FUNCT3, FUNCT7})
                {3'b000, 7'b0000000}: ALUOp = 4'b0000; // AND
                {3'b001, 7'b0000000}: ALUOp = 4'b0001; // ADD
                {3'b001, 7'b0100000}: ALUOp = 4'b0010; // SUB
                {3'b010, 7'b0000000}: ALUOp = 4'b0011; // OR
                {3'b100, 7'b0000000}: ALUOp = 4'b0100; // XOR
                {3'b101, 7'b0000000}: ALUOp = 4'b0101; // SRA
                {3'b110, 7'b0000000}: ALUOp = 4'b0110; // SLL
                {3'b111, 7'b0000000}: ALUOp = 4'b0111; // SLT
                default: ALUOp = 4'b0000;
                endcase
            end

            // I-format: ADDI, ORI, XORI
            7'b0011111: begin
                RegWrite = 1;
                ALUSrc = 1;
                case (FUNCT3)
                    3'b000: ALUOp = 4'b0110; // ADDI
                    3'b001: ALUOp = 4'b0001; // ORI
                    3'b010: ALUOp = 4'b0010; // XORI
                    default: ALUOp = 4'b0000;
                endcase
                ImmExt = {{20{Instruction[31]}}, Instruction[31:20]}; // I-type immediate
            end

            // LW, I-type
            7'b1000011: begin
                RegWrite = 1;
                MemRead = 1;
                MemtoReg = 1;
                ALUSrc = 1;
                ALUOp = 4'b0110; // Add
                ImmExt = {{20{Instruction[31]}}, Instruction[31:20]}; // I-type immediate
            end

            // SW 
            7'b1100011: begin
                MemWrite = 1;
                ALUSrc = 1;
                ALUOp = 4'b0110; // Add
                ImmExt = {{20{Instruction[31]}}, Instruction[31:25], Instruction[11:7]}; // S-type immediate
            end

            // BEQ, BLT
            7'b1101011: begin
                Branch = 1;
                ALUSrc = 0;
                ALUOp = 4'b0101; // Subtract
                case (FUNCT3)
                    3'b000: ImmExt = {{19{Instruction[31]}}, Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0}; // BEQ
                    3'b001: ImmExt = {{19{Instruction[31]}}, Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0}; // BLT
                    default: ImmExt = 32'b0;
                endcase
            end

            // LUI, U-type
            7'b0110000: begin
                RegWrite = 1;
                ALUSrc = 1;
                ALUOp = 4'b0000; // No ALU operation; loads immediate directly
                ImmExt = {Instruction[31:12], 12'b0}; // Immediate upper 20 bits with lower 12 bits set to 0
            end

            default: begin
                // Default case for unsupported opcodes
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                MemtoReg = 0;
                Branch = 0;
                ALUSrc = 0;
                ALUOp = 4'b0000;
                ImmExt = 32'b0;
            end
        endcase
    end

endmodule
