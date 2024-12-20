`timescale 1ns / 1ps

module t_Datapath();
    reg clk;
    reg rst;

    Datapath DP (clk, rst);

initial begin
    clk = 0;
    rst = 1;
    
    #20 rst = 0;

    forever #5 clk = ~clk;
  end
endmodule
