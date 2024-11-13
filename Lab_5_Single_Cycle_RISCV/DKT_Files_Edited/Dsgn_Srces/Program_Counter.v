`timescale 1ns / 1ps
module Program_Counter (
	input [BITSIZE-1:0] pc_next,
    input clk,
    input reset,
    output reg [BITSIZE-1:0] pc_out
);  
   parameter BITSIZE = 32;

   always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_out <= 0; // Reset to address of 1st instruction
        end else begin
            pc_out <= pc_next; // select inc by 1 or branch addr
        end
    end

endmodule
