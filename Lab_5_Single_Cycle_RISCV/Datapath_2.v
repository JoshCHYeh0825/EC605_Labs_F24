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
    .rst(rst),
    .pc_in(InstructionCountIn),
    .pc_out(InstructionCountOut)
    
    );
    // instantiate program counter

//----------------Instruction Memory----------------//    
    wire [31:0] ReadInstruction;
    
    IMEM Instruction_Memory (
    
    .Address(InstructionCountOut),
    .Instruction(ReadInstruction)
    
    );
    // instantiate instruction memory

//----------------Control Unit----------------//
    wire [4:0] ReadReg1Address, ReadReg2Address, WriteRegAddress;
    wire [31:0] Immediate;
    wire ALU_Src, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
    wire [3:0] ALU_Control;
    
    CtrlUnit Control_Unit(
    
    .OP(ReadInstruction[6:0]),
    .FUNCT3(ReadInstruction[14:12]),
    .FUNCT7(ReadInstruction[31:25]),
    .ALUOP(ALU_Control),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .RegWrite(RegWrite),
    .ImmExt(Immediate)

    );
                                      
    // instantiate control unit

//----------------Register File----------------//

    /*
    Note: the register file module has two PARAMETERs. The instantiation of the register file also
    needs to set the size of the PARAMETERs; the proper format to do so is provided.
    */

    wire [31:0] ReadRegData1, ReadRegData2;
    wire [31:0] WriteRegData;
    
    Register_File #(.BITSIZE(32), .REGSIZE(32)) reg_file (
    
    .ReadSelect1(ReadSelect1),
    .ReadSelect2(ReadSelect2),
    .WriteSelect(WriteSelect),
    .WriteData(WriteData),
    .WriteEnable(WriteEnable),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .clk(clk),
    .rst(rst)
    
    );

    // instantiate: Register_File #(32, 32) regfile(); // #(32, 32) sets the values of the PARAMETERs

//----------------ALU----------------//
    wire [31:0] ALU1, ALU2;
    wire [31:0] ALU_Out;
    wire zero;

    assign ALU2 = ALU_Src ? Immediate : ReadRegData2;

    ALU ALU_32b (
    
        .input1(ReadRegData1),
        .input2(ALU2),
        .alu_control(ALU_Control),
        .result(ALU_Out),
        .zero(zero)
        
        );

    // instantiate ALU
            
//----------------Branch Control----------------//
    
    wire select_branch;
    
    Branch_Ctrl Branch_Control (
    
    .branch(Branch),
    .FUNCT3(ReadInstruction[14:12]),
    .zero_flag (zero),
    .sign(ALU_Out[31]),
    .pc(InstructionCountOut),
    .imm(Immediate),
    .branch_taken(select_branch),
    .pc_out(InstructionCountIn)
    
    );
    
    // instantiate branch control unit

//----------------Data Memory----------------//

    wire [31:0] ReadMemData;

    Data_Memory #(32, 32) DMem (
    
        .clk(clk),
        .Address(ALU_Out),
        .WriteData(ReadRegData2),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ReadData(ReadMemData)
    
    );
    
    assign WriteRegData = MemtoReg ? ReadMemData : ALU_Out;

endmodule
