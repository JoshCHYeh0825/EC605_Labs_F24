`timescale 1ns / 1ps

module t_Control_Unit();
    reg [31:0] Instruction;
    wire [3:0] ALUOp;
    wire Branch;
    wire MemRead;
    wire MemtoReg;
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;
    wire [31:0] ImmExt;

    // Instantiate the Control_Unit module
    Control_Unit CU (
        .Instruction(Instruction),
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
    
        Instruction = 32'b0;
        #10;
        
        // R-format tests
        Instruction = 32'b0000000_00001_00010_000_00011_1110011; // AND
        #20;
        Instruction = 32'b0000000_00001_00010_010_00011_1110011; // OR
        #20;
        Instruction = 32'b0000000_00001_00010_100_00011_1110011; // XOR
        #20;
        Instruction = 32'b0100000_00001_00010_001_00011_1110011; // SUB
        #20;
        
        // I-format tests
        Instruction = 32'b000000000001_00010_000_00011_0011111; // ADDI
        #20;
        Instruction = 32'b000000000001_00010_001_00011_0011111; // ORI
        #20;
        Instruction = 32'b000000000001_00010_010_00011_0011111; // XORI
        #20;

        // LW (load word) test
        Instruction = 32'b000000000001_00010_010_00011_1000011; // LW
        #20;
        
        // SW (store word) test
        Instruction = 32'b0000000_00001_00010_010_00011_1100011; // SW
        #20;

        // Branch tests
        Instruction = 32'b0000000_00001_00010_000_00011_1101011; // BEQ
        #20;
        Instruction = 32'b0000000_00001_00010_001_00011_1101011; // BLT
        #20;
        
        // LUI test
        Instruction = 32'b00000000000000000001_00011_0110000; // LUI
        #20;

        #10 $finish;
    end
endmodule
