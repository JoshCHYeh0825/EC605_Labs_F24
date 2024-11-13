`timescale 1ns / 1ps

module Branch_Control (
    
    input branch, // Branch signal from control unit
    input [2:0] FUNCT3, // Branch type code (e.g., BEQ, BLT)
    input zero_flag, // Zero flag from ALU
    input n, // Sign flag from ALU
    input [BITSIZE-1:0] pc, // Current PC value
    input [BITSIZE-1:0] imm, // Immediate offset for branch
    output reg [BITSIZE-1:0] pc_out // PC address if branch is true
);
    parameter BITSIZE = 32;
    reg branch_taken = 1'b0;
    always @(*) begin
        // Default values
        branch_taken = 1'b0;
        pc_out = pc + 1;

        if (branch) begin
            case (FUNCT3)
                3'b000: branch_taken = zero_flag; // BEQ
                3'b001: branch_taken = n;         // BLT
                default: branch_taken = 1'b0;
            endcase

            // Set branch target address if branch is taken
            if (branch_taken) begin
                pc_out = pc + imm; // Adjust target address by immediate offset
            end
        end
    end
endmodule