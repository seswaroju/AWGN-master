`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
//  AWGN_tb.v
//
//  Description: This module is used to generate clock and feed uniform random input to awgn
// 
//////////////////////////////////////////////////////////////////////////////////


module AWGN_tb;
    reg clock;
    reg reset;
    reg [31:0] urgn_seed1;
    reg [31:0] urgn_seed2;
    reg [31:0] urgn_seed3;
    reg [31:0] urgn_seed4;
    reg [31:0] urgn_seed5;
    reg [31:0] urgn_seed6;
    wire [15:0] awgn_out;
    wire valid_out;
    wire [31:0] random_out;
    reg [31:0] ram [0:9999];
    integer i;
    `define NULL 0   
    
    
    reg [31:0] random_out_reg;
    
    /*
    tausworthe U1 (
        .clock(clock),
        .reset(reset),
        .random_out(random_out),
        .valid_out(valid_out)
        );
    */
    
    AWGN U2 (
        .clock(clock),
        .reset(reset),
        .urgn_seed1(urgn_seed1),
        .urgn_seed2(urgn_seed2),
        .urgn_seed3(urgn_seed3),
        .urgn_seed4(urgn_seed4),
        .urgn_seed5(urgn_seed5),
        .urgn_seed6(urgn_seed6),
        .awgn_out(awgn_out)
        );

    initial $readmemh("C:\Users\saisrikanth\project_2\project_2.srcs\sources_1\new\random_out.dat", ram);

    always #5 clock =! clock;
    
    initial
        begin
            urgn_seed1 <= ram[0];
            urgn_seed2 <= ram[1];
            urgn_seed3 <= ram[2];
            urgn_seed4 <= ram[3];
            urgn_seed5 <= ram[4];
            urgn_seed6 <= ram[5];
        end
        
    initial 
        begin
            for (i = 0; i < 10000; i = i + 1)
                 begin
                    $display("data:");           
                    for (i=0; i < 9999; i=i+1)         
                    $display("%d:%h",i,RAM[i]);           
                 end 
        

    initial 
        begin
            clock = 0;
            reset = 1;
            #20;
            reset = 0;
            #2000;
            $finish;
        end
        
    initial 
        begin
            $monitor("%d, %h, %h, %h, %h, %h, %h, %h", $time, urgn_seed1, urgn_seed2, urgn_seed3, urgn_seed4, urgn_seed5, urgn_seed6, awgn_out);
        end     
    
endmodule
