`timescale 1ns / 1ps

module seven_segment(input [3:0] in, output reg [3:0] seven_enable, output reg A,  output reg B, output reg C, output reg D, output reg E, output reg F, output reg G);

    initial
    begin
        A <= 1'b0;
        B <= 1'b0;
        C <= 1'b0;
        D <= 1'b0;
        E <= 1'b0;
        F <= 1'b0;
        G <= 1'b1;
        seven_enable <= 4'b1110;
    end

    always @(*) begin
        case(in)
            4'b0000: // HEX 0
            begin
                A = 1'b0;
                B = 1'b0;
                C = 1'b0;
                D = 1'b0;
                E = 1'b0;
                F = 1'b0;
                G = 1'b1;
            end
            4'b0001: // HEX 1 
            begin
                A = 1'b1;
                B = 1'b0;
                C = 1'b0;
                D = 1'b1;
                E = 1'b1;
                F = 1'b1;
                G = 1'b1;
            end
            4'b0010: // HEX 2
            begin
                A = 1'b0;
                B = 1'b0;
                C = 1'b1;
                D = 1'b0;
                E = 1'b0;
                F = 1'b1;
                G = 1'b0;
            end
            4'b0011: // HEX 3
            begin
                A = 1'b0;
                B = 1'b0;
                C = 1'b0;
                D = 1'b0;
                E = 1'b1;
                F = 1'b1;
                G = 1'b0;
            end
            4'b0100: // HEX 4
            begin
                A = 1'b1;
                B = 1'b0;
                C = 1'b0;
                D = 1'b1;
                E = 1'b1;
                F = 1'b0;
                G = 1'b0;
            end
            4'b0101: // HEX 5
            begin
                A = 1'b0;
                B = 1'b1;
                C = 1'b0;
                D = 1'b0;
                E = 1'b1;
                F = 1'b0;
                G = 1'b0;
            end
            4'b0110: // HEX 6
            begin
                A = 1'b0;
                B = 1'b1;
                C = 1'b0;
                D = 1'b0;
                E = 1'b0;
                F = 1'b0;
                G = 1'b0;
            end
            4'b0111: // HEX 7
            begin
                A = 1'b0;
                B = 1'b0;
                C = 1'b0;
                D = 1'b1;
                E = 1'b1;
                F = 1'b1;
                G = 1'b1;
            end
            4'b1000: // HEX 8
            begin
                A = 1'b0;
                B = 1'b0;
                C = 1'b0;
                D = 1'b0;
                E = 1'b0;
                F = 1'b0;
                G = 1'b0;
            end
            4'b1001: // HEX 9
            begin
                A = 1'b0;
                B = 1'b0;
                C = 1'b0;
                D = 1'b1;
                E = 1'b1;
                F = 1'b0;
                G = 1'b0;
            end
            4'b1010: // HEX A
            begin
                A = 1'b0;
                B = 1'b0;
                C = 1'b0;
                D = 1'b1;
                E = 1'b0;
                F = 1'b0;
                G = 1'b0;
            end
            4'b1011: // HEX B
            begin
                A = 1'b1;
                B = 1'b1;
                C = 1'b0;
                D = 1'b0;
                E = 1'b0;
                F = 1'b0;
                G = 1'b0;
            end
            4'b1100: // HEX C
            begin
                A = 1'b0;
                B = 1'b1;
                C = 1'b1;
                D = 1'b0;
                E = 1'b0;
                F = 1'b0;
                G = 1'b1;
            end
            4'b1101: // HEX D
            begin
                A = 1'b1;
                B = 1'b0;
                C = 1'b0;
                D = 1'b0;
                E = 1'b0;
                F = 1'b1;
                G = 1'b0;
            end
            4'b1110: // HEX E
            begin
                A = 1'b0;
                B = 1'b1;
                C = 1'b1;
                D = 1'b0;
                E = 1'b0;
                F = 1'b0;
                G = 1'b0;
            end
            4'b1111: // HEX F
            begin
                A = 1'b0;
                B = 1'b1;
                C = 1'b1;
                D = 1'b1;
                E = 1'b0;
                F = 1'b0;
                G = 1'b0;
            end
        endcase

    end

endmodule

module Top_module(clk, rst, switches, leds, seven_seg, seven_enable, btn);
    input clk, rst; // Needed for synchronous inputs
    input [1:0] btn; // For better control of simulation
    input [15:0] switches; // Input switches
    output [3:0] leds; // Display N, V, C, Z
    output [6:0] seven_seg; // Display outputs to seven segment
    output  [3:0] seven_enable; // Select which seven segment to display
    
    reg [3:0] A;
    reg [3:0] B;
    reg [3:0] SEL;
    wire [3:0] out;

    /**************** SAVE INPUT TO REGISTERS ******************/
    /* This always block saves switch inputs into      */
    /* registers when buttons are pressed.             */
    always @ (posedge clk or posedge rst)
    begin
        if (rst)
            begin
                A = 4'b0;
                B = 4'b0;
                SEL = 4'b0;
            end
        else
            begin
                if (btn[0]) begin
                    A <= switches[3:0];
                    B <= switches[7:4];
                end
                if (btn[1])
                    SEL <= switches[11:8];
            end
    end
    /********* End always block **********/



    /**************** CONNECT FLAGS WITH LEDS ******************/
    ALU alu(.A(A), .B(B), .OPCODE(SEL), .Cin(switches[12]), .Y(out), .N(leds[3]), .Z(leds[2]), .C(leds[1]), .V(leds[0]));

    /********* End connect flags with LEDS implementation **********/



    /**************** CONNECT ALU OUTPUT WITH SEVEN SEGMENT DISPLAY ******************/
    /* Here you initialize seven_seg, the register for the output of the seven segment dsiplay*/
    seven_segment sev_seg(.in(out), .seven_enable(seven_enable), .A(seven_seg[0]), .B(seven_seg[1]), .C(seven_seg[2]), .D(seven_seg[3]), .E(seven_seg[4]), .F(seven_seg[5]), .G(seven_seg[6]));


    /********* End connect alu output to seven seg implementation**********/





endmodule
/************ End module *************/





