`timescale 1ns / 1ps

module t_ALU_32b();
    parameter BITSIZE = 32;

    reg [BITSIZE-1:0] a, b;
    reg [3:0] OP;
    wire [BITSIZE-1:0] result;
    wire zero_flag, n, c, v;

    // Instantiate the ALU
    ALU_32b uut (
        .a(a),
        .b(b),
        .OP(OP),
        .result(result),
        .zero_flag(zero_flag),
        .n(n),
        .c(c),
        .v(v)
    );

    initial begin
        // Initialize inputs
        a = 32'b0;
        b = 32'b0;
        OP = 4'b0;

        #10;
        // Test cases for the ALU operations
        a = 32'hAAAAAAAA;
        b = 32'hFFFFFFFF;
        
        #10;
        OP = 4'b0001;  // OR operation
        
        #10;
        OP = 4'b0010;  // XOR operation

        #2;
        a = 32'hBEEFFEED;
        b = 32'h0000FFFF;
        
        #10;
        OP = 4'b0011;  // Arithmetic shift right

        #2;
        a = 32'h80000000;
        b = 32'h00000003;
        
        #10;
        OP = 4'b0100;  // Logical shift left

        #2;
        a = 32'h0000BEEF;
        b = 32'h0000000F;
        
        #10;
        OP = 4'b0101;  // Subtract operation

        #2;
        a = 32'h00000001;
        b = 32'h00000002;
        
        #10;
        a = 32'h00000001;
        b = 32'h00000001;

        #10;
        OP = 4'b0110;  // Add operation

        #2;
        a = 32'hFFFFFFFF;
        b = 32'h00000001;
        
        #10;
        a = 32'h40000000;
        b = 32'h40000000;
        
        #10;
        a = 32'h80000000;
        b = 32'h80000000;
        
        #10;
        OP = 4'b0111;  // Set less than operation

        #2;
        a = 32'h00000001;
        b = 32'h00000002;
        
        #10;
        // End of simulation
        $finish;
    end
endmodule
