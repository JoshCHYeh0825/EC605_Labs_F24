`timescale 1ns / 1ps

module ALU_32b(a, b, OP, result, zero_flag, n, c, v);
    parameter BITSIZE = 32;

    input [BITSIZE-1:0] a;               // 32-bit input A
    input [BITSIZE-1:0] b;               // 32-bit input B
    input [4:0] OP;                      // 4-bit opcode
    output reg [BITSIZE-1:0] result;     // 32-bit result
    output zero_flag;                    // Zero flag
    output reg n;                        // Negative flag
    output reg c;                        // Carry flag
    output reg v;     

always @(a, b, OP) begin
    // Reset flags
    c = 0;
    v = 0;

    case (OP)
        4'b0000: result = a & b;           // AND
        4'b0001: result = a | b;           // OR
        4'b0010: result = a ^ b;           // XOR
        4'b0011: result = $signed(a) >>> b;    // Arithmetic shift right
        4'b0100: result = a << b;     // Logical shift left
        4'b0101: result = a - b;      // Subtract
        4'b0110: result = a + b;          // Add
        4'b0111: result = (a < b) ? 1 : 0; // Set less than
        default: result = 32'b0;           // Default to 0
    endcase
	
	if(result[31] == 1) n = 1; else n = 0; //neg flag
    //if((a[31] & b[31])|(a[31] | b[31])) & ((result[31] == 0)|(a[30] & b[30])) c = 1; else c = 0; //carry-out indicates overflow for unsigned
	if((a[31] & b[31]) | (b[31] & (b[30] & a[30])) | (a[31] & (a[30] & b[30]))) c = 1; else c = 0; //carry-out
    //if((a[31] == b[31]) & (result[31] ^ c)) v = 1; else v = 0;//overflow for signed
	if((a[30] & b[30]) | ((b[31] & a[31]) & ~(a[30])) | ((a[31] & b[31]) & ~(b[30]))); //overflow
end

// Zero flag is set if the result is zero
assign zero_flag = (result == 32'b0)?1:0;
                                                                                                                                                                   
endmodule