`timescale 1ns / 1ns
module t_Register_File();
	
	parameter BITSIZE = 32;
	parameter REGSIZE = 32;
	reg [$clog2(REGSIZE)-1:0] RS1, RS2, WS;
	reg [BITSIZE-1:0] WD;
	reg WEn, clk, rst;
	wire [BITSIZE-1:0] RD1, RD2;
	
	Register_File RF (RS1, RS2, WS, WD, WEn, RD1, RD2, clk, rst);
	
	initial begin
        clk = 0;
        
        forever #5 clk = ~clk;
	
	end
	
	integer i;
	initial begin
	
	   RS1 = 5'b0;
	   RS2 = 5'b0;
	   WS = 5'b0;
	   WD = 32'b0;
	   WEn = 1'b1;
	   rst = 1'b0;
	   i = 0;
	   
	end
	
	always @(posedge clk) begin
		rst <= 1'b0;
		
		if (i < REGSIZE) begin
		  i <= i + 1;
		  WS <= i;
		  WD <= 32'hAAAAAAAA;
		  RS1 <= i;
		  RS2 <= i;
		  
		#20;
		
		end else begin
		  rst <= 1'b1;
		  i <= 0;
		end	
	end
	
	
	
	initial begin
	#1000;	
	
	$finish;

    end
	
endmodule