`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
//  log_unit.v
//
//  Description: this module is for logarithmic block.
// 
//////////////////////////////////////////////////////////////////////////////////


module log_unit(
    // System signals
    input clock,
    input reset,
    // Data Interface
    input [47:0] log_data_in,
    output [31:0] log_data_out
    );
       
    // Local Variables
    wire [7:0] addr;
    wire [12:0] c2;
    wire [21:0] c1;
    wire [29:0] c0;
    wire [53:0] prod;
    reg [53:0] prod_r;
    wire [31:0] log_out;
    
    assign addr = log_data_in[47:40];
    
    // coefficient table
    log_coeff_table u_log_coeff_table(
         .clock(clock),
         .log_addr(addr),
         .log_c2(c2),
         .log_c1(c1),
         .log_c0(c0)
         );
    
    // Polynomial int. of degree 2
    mul_sum_13_22 u_mul_sum_13_22 (
        .clock(clock),
        .a(log_data_in[39:0]),
        .b(c2),
        .c(c1),
        .data_out(prod)
        );
        
     smul_52_30 u_smul_52_30 (
        .clock(clock),
        .a(log_data_in[39:0]),
        .b(prod),
        .c(c0),
        .data_out(log_out)
        );        
        
     
     always @(posedge clock)
        begin
            prod_r <= prod;
        end
     
    
    
    
endmodule
