`timescale 1ns / 1ps

module Branch_Control_tb();

// Inputs
    reg branch;
    reg [2:0] FUNCT3;
    reg zero_flag;
    reg n;
    reg [31:0] pc;
    reg [31:0] imm;

    // Outputs
    wire branch_taken;
    wire [31:0] pc_out;
    
    Branch_Control uut (
        .branch(branch),
        .FUNCT3(FUNCT3),
        .zero_flag(zero_flag),
        .n(n),
        .pc(pc),
        .imm(imm),
        .branch_taken(branch_taken),
        .pc_out(pc_out)
    );

initial begin

        branch = 0;
        FUNCT3 = 3'b000;
        zero_flag = 0;
        n = 0;
        pc = 32'h00000000;
        imm = 32'h00000004;

        // Test Case: BEQ with zero_flag = 1 (should branch)
        #10 branch = 1; FUNCT3 = 3'b000; zero_flag = 1; n = 0; pc = 32'h00000010; imm = 32'h00000004;
        #10 if (!branch_taken || pc_out != (pc + (imm << 1))) $display("Test Case 1 Failed: BEQ branch not taken correctly");

        // Test Case: BEQ with zero_flag = 0 (should not branch)
        #10 branch = 1; FUNCT3 = 3'b000; zero_flag = 0; n = 0; pc = 32'h00000010; imm = 32'h00000004;
        #10 if (branch_taken || pc_out != (pc + 1)) $display("Test Case 2 Failed: BEQ branch taken incorrectly");

        // Test Case 3: BLT with n = 1 (should branch)
        #10 branch = 1; FUNCT3 = 3'b001; zero_flag = 0; n = 1; pc = 32'h00000020; imm = 32'h00000008;
        #10 if (!branch_taken || pc_out != (pc + (imm << 1))) $display("Test Case 3 Failed: BLT branch not taken correctly");

        // Test Case 4: BLT with n = 0 (should not branch)
        #10 branch = 1; FUNCT3 = 3'b001; zero_flag = 0; n = 0; pc = 32'h00000020; imm = 32'h00000008;
        #10 if (branch_taken || pc_out != (pc + 1)) $display("Test Case 4 Failed: BLT branch taken incorrectly");

        // Test Case 5: Branch disabled (branch = 0)
        #10 branch = 0; FUNCT3 = 3'b000; zero_flag = 1; n = 1; pc = 32'h00000030; imm = 32'h00000004;
        #10 if (branch_taken || pc_out != (pc + 1)) $display("Test Case 5 Failed: Branch taken with branch signal disabled");

        $display("Branch Control Testbench completed");
        $finish;
    end

endmodule
