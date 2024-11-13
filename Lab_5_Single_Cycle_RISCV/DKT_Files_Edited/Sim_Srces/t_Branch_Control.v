`timescale 1ns / 1ps

module t_Branch_Control();
    parameter BITSIZE = 32;
    reg branch;
    reg [2:0] FUNCT3; 
    reg zero_flag; 
    reg n;
    reg [BITSIZE-1:0] pc;
    reg [BITSIZE-1:0] imm;
    wire [BITSIZE-1:0] pc_out;

Branch_Control BC(branch, FUNCT3, zero_flag, n, pc, imm, pc_out);

initial begin
    branch = 0;
    FUNCT3 = 3'b0;
    zero_flag = 0;
    n = 0;
    pc = 32'b0;
    imm = 32'b0;
    
    #5 pc = pc + 1;
    #5 pc = pc + 1;
    imm = 32'h7FFFFFFF;
    branch = 1'b1;
    zero_flag = 1'b1;
    
    #1 zero_flag = 1'b0;
    #1 zero_flag = 1'b1;
    zero_flag = 1'b0;
    FUNCT3 = 3'b1;
    imm = 32'hA0A0A0A0;
    
    #1 n = 1'b1;

    #5 $finish;
    
   end
endmodule
