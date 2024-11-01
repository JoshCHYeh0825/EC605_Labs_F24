`timescale 1ns / 1ps

module Program_Counter (
    input clk,
    input reset,
    output reg [31:0] pc_out
);  

   always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_out <= 0; // Reset to address of 1st instruction
        end else begin
            pc_out <= pc_out + 1; // Increment by 1
        end
    end

endmodule
