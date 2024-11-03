`timescale 1ns / 1ps

module Branch_Control (
    
    input branch,           // Branch signal from control unit
    input [2:0] func3,      // Branch type code (e.g., BEQ, BLT)
    input zero,             // Zero flag from ALU
    input negative,         // Sign flag from ALU
    input [31:0] pc,        // Current PC value
    input [31:0] imm,       // Immediate offset for branch
    output reg branch_taken,       // Branch condition met
    output reg [31:0] branch_target // Branch address if taken
);
    always @(*) begin
        // Default values
        branch_taken = 1'b0;
        branch_target = pc + 4;

        if (branch) begin
            case (func3)
                3'b000: branch_taken = zero;                   // BEQ
                3'b001: branch_taken = ~zero;                  // BNE
                3'b100: branch_taken = negative;               // BLT
                3'b101: branch_taken = ~negative;              // BGE
                default: branch_taken = 1'b0;
            endcase

            // Set branch target address if branch is taken
            if (branch_taken) begin
                branch_target = pc + imm; // Adjust target address by immediate offset
            end
        end
    end
endmodule