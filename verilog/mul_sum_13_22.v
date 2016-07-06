`timescale 1ns / 1ps
//------------------------------------------------------------------------------
//
// mul_sum_13_22.v
//
// Description
//     Signed multiplier 40-bit x 13-bit follows signed adder 22-bit.
//
//------------------------------------------------------------------------------


module mul_sum_13_22(
    input clock,
    input [39:0] a,
    input [12:0] b,
    input [21:0] c,
    output [53:0] data_out
    );
    
    // Behavioral model
    reg signed [39:0] a_reg;    // remaining bits from x
    reg signed [12:0] b_reg;    // sum of previous degree coeffs
    reg signed [20:0] c_reg;    // c0 coeff
    reg signed [52:0] prod;
    wire signed [52:0] sum;
    reg [53:0] result;
    
    always @ (posedge clock) begin
        a_reg <= a;
        b_reg <= b;
        c_reg <= c[20:0];
    end
    
    always @ (posedge clock) begin
        prod <= a_reg * b_reg;
    end
    
    assign sum = prod + c_reg;  // substracting as value of C1 is negative always
    
    always @ (posedge clock) begin
        result <= {1'b1,c[18],sum};
    end
    
    assign data_out = result;  
        
endmodule
