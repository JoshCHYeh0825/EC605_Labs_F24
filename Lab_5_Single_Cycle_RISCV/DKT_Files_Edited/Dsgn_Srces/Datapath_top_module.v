`timescale 1ns / 1ps

/* 

The top module for the datapath instantiates all the other modules you created for task 1.
The module only takes clk and rst as inputs; all other logic is carried out by internal signals.
Below, each section declares necessary input and output wires for each module to instantiate when
they first appear. These wires may be used in other modules as well.

You may need to add additional logic and/or signals to implement your version of the datapath,
depending on your module designs for task 1 and the drawing you made for your datapath design.

*/

module Datapath(clk, rst);

    input clk, rst;
    
//----------------Program Counter----------------//

    wire [31:0] InstructionCountIn;
    wire [31:0] InstructionCountOut;
    
    Program_Counter PC (
        .clk(clk), 
        .reset(rst),
        .pc_next(InstructionCountIn),
        .pc_out(InstructionCountOut)
    
    );
    // instantiate program counter

//----------------Instruction Memory----------------//    

    wire [31:0] ReadInstruction;
    
    Instruction_Memory IMem (
        .Address(InstructionCountOut),
        .Instruction(ReadInstruction)
    
    );
    // instantiate instruction memory

//----------------Control Unit----------------//

    wire [4:0] ReadReg1Address, ReadReg2Address, WriteRegAddress;
    wire [31:0] Immediate;
    wire ALU_Src, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
    wire [3:0] ALU_Control;
    
    Control_Unit CU ( 
        .Instruction(ReadInstruction[6:0]),
        .ALUOp(ALU_Control),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .RegWrite(RegWrite),
        .ImmExt(Immediate),
        .ALUSrc(ALU_Src)
    );
                                      
    // instantiate control unit

//----------------Register File----------------//

    /*
    Note: the register file module has two PARAMETERs. The instantiation of the register file also
    needs to set the size of the PARAMETERs; the proper format to do so is provided.
    */

    wire [31:0] ReadRegData1, ReadRegData2;
    wire [31:0] WriteRegData;
    
    Register_File #(.BITSIZE(32), .REGSIZE(32)) RF(
        .clk(clk),
        .rst(rst), 
        .ReadSelect1(ReadReg1Address),
        .ReadSelect2(ReadReg2Address),
        .WriteSelect(WriteRegAddress),
        .WriteData(WriteRegData),
        .WriteEnable(RegWrite),
        .ReadData1(ReadRegData1),
        .ReadData2(ReadRegData2)
    
    );

    // instantiate: Register_File #(32, 32) regfile(); // #(32, 32) sets the values of the PARAMETERs

//----------------ALU----------------//

    wire [31:0] ALU1, ALU2;
    wire [31:0] ALU_Out;
    wire zero;

    assign ALU1 = ReadRegData1;
    assign ALU2 = ALU_Src ? Immediate : ReadRegData2;

    ALU_32b ALU (
        .a(ALU1),
        .b(ALU2),
        .OP(ALU_Control),
        .result(ALU_Out),
        .zero_flag(zero),
        .n(n),
        .c(c),
        .v(v)

    );

    // instantiate ALU
            
//----------------Branch Control----------------//
    
    wire select_branch;
       
    Branch_Control BC(
        .branch(Branch),
        .FUNCT3(ReadInstruction[14:12]),
        .zero_flag (zero),
        .n(n),
        .pc(InstructionCountOut),
        .imm(Immediate),
        .pc_out(InstructionCountIn)

    );
    
    // instantiate branch control unit

//----------------Data Memory----------------//

    wire [31:0] ReadMemData;
    
    Data_Memory  DMem (
        .clk(clk),
        .rst(rst),
        .Address(ALU_Out),
        .WriteData(ReadRegData2),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ReadData(ReadMemData)
    
    );
    
    assign WriteRegData = MemtoReg ? ReadMemData : ALU_Out;

endmodule
