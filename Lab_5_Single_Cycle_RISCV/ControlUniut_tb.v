`timescale 1ns / 1ps

module ControlUnit_tb();

// Inputs
    reg [6:0] OP;
    reg [2:0] FUNCT3;
    reg [6:0] FUNCT7;

    // Outputs
    wire [2:0] ALUOp;
    wire Branch;
    wire MemRead;
    wire MemtoReg;
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;
    wire [31:0] ImmExt;

    Control_Unit uut (
        .OP(OP),
        .FUNCT3(FUNCT3),
        .FUNCT7(FUNCT7),
        .ALUOp(ALUOp),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .ImmExt(ImmExt)
    );

initial begin

        OP = 7'b0;
        FUNCT3 = 3'b0;
        FUNCT7 = 7'b0;

        // ADD
        #10 OP = 7'b1110011; FUNCT3 = 3'b001; FUNCT7 = 7'b0000000;
        #10 if (ALUOp != 3'b001 || RegWrite != 1 || ALUSrc != 0) $display("R-format ADD test failed");

        // ADDI
        #10 OP = 7'b0011111; FUNCT3 = 3'b000;
        #10 if (ALUOp != 3'b001 || RegWrite != 1 || ALUSrc != 1) $display("I-format ADDI test failed");

        // LW
        #10 OP = 7'b1000011; FUNCT3 = 3'b010;
        #10 if (MemRead != 1 || MemtoReg != 1 || ALUSrc != 1 || RegWrite != 1) $display("Load Word LW test failed");

        // SW
        #10 OP = 7'b1100011; FUNCT3 = 3'b010;
        #10 if (MemWrite != 1 || ALUSrc != 1) $display("Store Word SW test failed");

        // BEQ
        #10 OP = 7'b1101011; FUNCT3 = 3'b000;
        #10 if (Branch != 1 || ALUOp != 3'b010) $display("Branch BEQ test failed");

        // LUI 
        #10 OP = 7'b0110000;
        #10 if (ALUOp != 3'b000 || RegWrite != 1 || ALUSrc != 1) $display("LUI test failed");

        // Default case
        #10 OP = 7'b0000000; FUNCT3 = 3'b000; FUNCT7 = 7'b0000000;
        #10 if (RegWrite != 0 && MemRead != 0 && MemWrite != 0 && MemtoReg != 0 && Branch != 0 && ALUSrc != 0 && ALUOp != 3'b000) $display("Default case test failed");

        $display("Testbench completed");
        $finish;
    end

endmodule
