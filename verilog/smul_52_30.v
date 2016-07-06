`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
//  smul_52_30.v
//
//  This module is for multiplication and addition as per horners rule.
// 
//////////////////////////////////////////////////////////////////////////////////


module smul_52_30(
    input clock,
    input [39:0] a,
    input [53:0] b,
    input [29:0] c,
    output [31:0] data_out
    );
    
        // Behavioral model
    reg signed [39:0] a_reg;
    reg signed [52:0] b_reg;
    reg signed [29:0] c_reg;
    reg signed [52:0] prod;
    wire signed [52:0] sum;
    reg [53:0] result;
    
    always @ (posedge clock) begin
        a_reg <= a;
        b_reg <= b[52:0];
        c_reg <= c[20:0];
    end
    
    always @ (posedge clock) begin
        prod <= a_reg * b_reg;
    end
    
    assign sum = prod - c_reg;  // substracting as value of C1 is negative always
    
    always @ (posedge clock) begin
        result <= {1'b1,c[18],sum};
    end
    
    assign data_out = result;  

endmodule
