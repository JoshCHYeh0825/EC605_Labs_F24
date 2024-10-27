`timescale 1ns / 1ps

module ALU_32b(
   input [31:0] a, b,          // 32-bit inputs A and B
   input [3:0] OP,             // 4-bit opcode
   output reg [31:0] result,   // 32-bit result
   output zero_flag,           // Zero flag
   output reg n,               // Negative flag
   output reg c,               // Carry flag
   output reg v                // Overflow flag
);  

always @(*) begin
    // Reset flags
    c = 0;
    v = 0;

    case (OP)
        4'b0000: result = a & b;           // AND
        4'b0001: result = a | b;           // OR
        4'b0010: result = a ^ b;           // XOR
        4'b0011: result = a >>> b[4:0];    // Arithmetic shift right
        4'b0100: result = a << b[4:0];     // Logical shift left
        4'b0101: begin                     // Subtract
            result = a - b;
           c = (a < b);                   // Set carry for a subtraction
           v = ((a[31] != b[31]) && (result[31] != a[31])); // Overflow if signs aren't matched
        end
        4'b0110: begin                     // Add
            result = a + b;
           c = (result < a);              // Set carry if overflow
           v = ((a[31] == b[31]) && (result[31] != a[31])); // Overflow if signs aren't matched
        end
        4'b0111: result = (a < b) ? 1 : 0; // Set less than
        default: result = 32'b0;           // Default to 0
    endcase

    // Set negative flag
    n = result[31]; // Set if result is negative (sign bit is 1)

end

// Zero flag is set if the result is zero
assign zero_flag = (result == 32'b0);

endmodule
