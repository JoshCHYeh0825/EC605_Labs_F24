`timescale 1ns / 1ps

module ALU_32b(a, b, OP, result, zero_flag, n, c, v);
    parameter BITSIZE = 32;

    input [BITSIZE-1:0] a;               // 32-bit input A
    input [BITSIZE-1:0] b;               // 32-bit input B
    input [3:0] OP;                      // 4-bit opcode
    output reg [BITSIZE-1:0] result;     // 32-bit result
    output zero_flag;                    // Zero flag
    output reg n;                        // Negative flag
    output reg c;                        // Carry flag
    output reg v;                        // Overflow flag

    always @(*) begin
        // Reset flags
        c = 0;
        v = 0;

        case (OP)
            4'b0000: result = a & b;                    // AND
            4'b0001: result = a | b;                    // OR
            4'b0010: result = a ^ b;                    // XOR
            4'b0011: result = $signed(a) >>> b;         // Arithmetic shift right
            4'b0100: result = a << b;                   // Logical shift left
            4'b0110: begin  // Add
                result = a + b;
                c = (result < a);                          // Carry for addition
                v = (a[BITSIZE-1] == b[BITSIZE-1]) && (result[BITSIZE-1] != a[BITSIZE-1]); // Overflow for signed addition
            end
            4'b0101: begin  // Subtract
                result = a - b;
                c = (a < b);                               // Carry for subtraction
                v = (a[BITSIZE-1] != b[BITSIZE-1]) && (result[BITSIZE-1] != a[BITSIZE-1]); // Overflow for signed subtraction
            end
            default: result = 0;                          // Default result for unsupported opcodes
        endcase

        // Negative flag (sign of result)
        n = result[BITSIZE-1];
    end

    // Zero flag is set if the result is zero
    assign zero_flag = (result == 0);

endmodule
