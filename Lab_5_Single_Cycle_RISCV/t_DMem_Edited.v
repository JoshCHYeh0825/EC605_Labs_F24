`timescale 1ns / 1ps

module t_DMem();
	
    parameter BITSIZE = 32;
	
    reg [5:0] Address;
    reg [BITSIZE-1:0] WriteData;
    reg clk, rst, MemWrite, MemRead;
    wire [BITSIZE-1:0] ReadData;
	
    // Instantiate Data Memory module
    DMem uut (
        .clk(clk),
        .rst(rst),
        .Address(Address),
        .WriteData(WriteData),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ReadData(ReadData)
    );
	
    integer i;
	
    initial begin
        // Initialization
        i = 0;
        rst = 1'b1;
        clk = 1'b0;
        Address = 6'b0;
        WriteData = 32'b0;
        MemWrite = 1'b0;
        MemRead = 1'b0;

        // Reset Memory
        #5 rst = 1'b0;

        // Write Data to Memory
        for (i = 0; i < 64; i = i + 1) begin
            Address = i;
            WriteData = i;
            MemWrite = 1'b1;
            #2 clk = 1'b1;
            #2 clk = 1'b0;
        end

        // Set up Read Operation
        MemWrite = 1'b0;
        MemRead = 1'b1;

        // Read Data from Memory
        for (i = 0; i < 64; i = i + 1) begin
            Address = i;
            #2 clk = 1'b1;
            #2 clk = 1'b0;
        end

        $finish;
    end

endmodule

