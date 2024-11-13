`timescale 1ns / 1ns
	module t_Instruction_Memory();
	
	parameter BITSIZE = 32;
	parameter REGSIZE = 32;
	reg clock;
	reg [BITSIZE-1:0] Address;
	wire [BITSIZE-1:0] ReadData1;
	
	Instruction_Memory IM (Address, ReadData1);
	
	integer i;
	
	initial begin
        clock = 0;
		forever #5 clock = ~clock;
	end
	
	initial begin
		Address = 32'b0;
		i = 0;
	
		forever @(posedge clock)
		begin
			if(Address < (BITSIZE-1)) begin
			i = i+1;
			Address = i;
			end else begin
			Address = 32'b0;
		end
		end
		end
		
		initial begin
		#1000;
	   $finish;
	   end
       endmodule