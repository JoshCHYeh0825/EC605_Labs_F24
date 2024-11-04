`timescale 1ns / 1ps

module Branch_Control (
    
    input branch, // Branch signal from control unit
    input [2:0] FUNCT3, // Branch type code (e.g., BEQ, BLT)
    input zero_flag, // Zero flag from ALU
    input n, // Sign flag from ALU
    input [31:0] pc, // Current PC value
    input [31:0] imm, // Immediate offset for branch
    output reg branch_taken, // Branch condition met
    output reg [31:0] pc_out // PC address if branch is true
);
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
                pc_out = pc + (imm << 1); // Adjust target address by immediate offset
            end
        end
    end
endmodule
