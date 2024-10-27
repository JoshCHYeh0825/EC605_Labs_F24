	module Data_Memory(Address, WriteData, MemWrite, MemRead, ReadData);

    parameter BITSIZE = 32;
    parameter REGSIZE = 32;

    input [5:0] Address;
    input [31:0] WriteData;
    input MemWrite, MemRead;
    output reg [31:0] ReadData;
    input clk, rst;

    reg [31:0] memory [63:0];        // 64 locations, each 32 bits wide

    integer i;

    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 64; i = i + 1) begin
                memory[i] <= 32'b0;
            end
        end else if (MemWrite) begin
            memory[Address] <= WriteData; // Write data to specified address
        end
    end

    // Read data (asynchronous read)
    always @(*) begin
        if (MemRead) begin
            ReadData = memory[Address];
        end else begin
            ReadData = 32'bz; // High impedance if not reading
        end
    end

endmodule
