`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
//  AWGN.v
//
//  Description: This module is top level module and integration of several other modules
// 
//////////////////////////////////////////////////////////////////////////////////


module AWGN(
    input clock,
    input reset,
    input [31:0] urgn_seed1,
    input [31:0] urgn_seed2,
    input [31:0] urgn_seed3,
    input [31:0] urgn_seed4,
    input [31:0] urgn_seed5,
    input [31:0] urgn_seed6,
    output reg [15:0] awgn_out
    );  
        
    wire [47:0] u0;
    wire [15:0] u1;
    reg [31:0] a, a_1, a_2, a_3, a_4, a_5;
    reg [31:0] b, b_1, b_2, b_3, b_4, b_5;
    wire [5:0] num_lzd_6;
    wire [15:0] g0_data_out;
    wire [15:0] g1_data_out;
    wire [31:0] log_data_out;
    
    assign u0 = {urgn_seed1[31:0],urgn_seed2[31:16]};
    assign u1 = {urgn_seed2[15:0]};
    
    lzd u_lzd (
        .data_in(u0),
        .data_out(num_lzd_6)
        );
    
    sin_cos_unit u_sin_cos_unit (
        .clock(clock),
        .reset(reset),
        .data_in(u0),
        .g0_data_out(g0_data_out),
        .g1_data_out(g1_data_out)
        );
    
    log_unit u_log_unit (
        .clock(clock),
        .reset(reset),
        .log_data_in(u0),
        .log_data_out(log_data_out)
        );
        
        
    
    always@(posedge clock or posedge reset)
        if (reset)
            begin
                a <= 32'b0;
                b <= 32'b0;
            end
        else 
            begin
                a <= urgn_seed1;
                b <= urgn_seed2;
            end
    
    
    always @(posedge clock or posedge reset)
        if (reset)
            begin
                awgn_out <= 15'b0;
            end
        else
            begin
                awgn_out <= urgn_seed1[15:0]; 
            end            
            
endmodule
