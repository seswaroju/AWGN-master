`timescale 1ns / 1ps
//------------------------------------------------------------------------------
//
// cos_mul_12_7.v
//
// This file is part of the Gaussian Noise Generator IP Core
//
// Description
//     Signed multiplier 12-bit x 7-bit follows signed adder 18-bit.
//
//------------------------------------------------------------------------------


module cos_mul_12_7(
    // System signals
    input clock,
    // data interface
    input [6:0] a,
    input [11:0] b,
    input [18:0] c,
    output [15:0] p
    );
    
    // Behavioral model
    reg signed [6:0] a_reg;
    reg signed [11:0] b_reg;
    reg signed [17:0] c_reg;
    reg signed [18:0] prod;
    wire signed [14:0] sum;
    reg [15:0] result;
    
    always @ (posedge clock) begin
        a_reg <= a;
        b_reg <= b;
        c_reg <= c[17:0];
    end
    
    always @ (posedge clock) begin
        prod <= a_reg * b_reg;
    end
    
    assign sum = c_reg - prod;  // substracting as value of C1 is negative always
    
    always @ (posedge clock) begin
        result <= {c[18],sum};
    end
    
    assign p = result;
    
endmodule
