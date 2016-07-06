`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
//  sin_cos_unit.v
//
//  Description: This module is a cosine/sine block which outputs g1,g0
// 
//////////////////////////////////////////////////////////////////////////////////


module sin_cos_unit(
    // System signals
    input clock,
    input reset,
    // Data Interface
    input [15:0] data_in,
    output reg [15:0] g0_data_out,
    output reg [15:0] g1_data_out
    );
    // Local Variables
    wire [1:0] quad;
    wire [13:0] x_g_a;
    wire [13:0] x_g_b;
    wire [6:0] addr;
    wire [11:0] c1;
    reg [11:0] c1_r;
    wire [18:0] c0;
    reg [18:0] c0_r;
    wire [15:0] y_g_a;
    
    assign quad = data_in[15:14];
    assign x_g_a = data_in[13:0];
    
    assign addr = x_g_a[13:7];
    
    cos_table u_cos_table (
        .clock(clock),
        .addr(x_g_a[13:7]),
        .c1(c1),
        .c0(c0)
        );
    
    cos_mul_12_7 u_cos_mul_12_7 (
        .clock(clock),
        .a(x_g_a[6:0]),
        .b(c1_r),
        .c(c0_r),
        .p(y_g_a)
        );
    
    always @(posedge clock)
        begin
            c0_r <= c0;
            c1_r <= c1;
        end
    
    always @(posedge clock or posedge reset)
        if (reset)
        begin
            g1_data_out <= 16'b0;
        end
    else 
        begin
            g1_data_out <= y_g_a;
        end
    
    
    
    
    
    
    
    
    
    
endmodule
