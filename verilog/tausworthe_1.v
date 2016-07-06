`timescale 1ns / 1ps

module tausworthe_2(
    input clock,
    input reset,
    output [31:0] random_out,
    output reg valid_out
    );
    
   
    wire [31:0] b1,b2,b3;
    wire [31:0] next_S0, next_S1, next_S2;
    reg [31:0] S0_reg, S1_reg, S2_reg;
    
    assign b1      = (((S0_reg << 13) ^ S0_reg) >> 19);
    assign next_S0 = (((S0_reg & 32'hfffffffe) << 12) ^ b1);
    assign b2      = (((S1_reg << 2 ) ^ S1_reg) >> 25);
    assign next_S1 = (((S1_reg & 32'hfffffff8) << 4 ) ^ b2);
    assign b3      = (((S2_reg << 3 ) ^ S2_reg) >> 11);
    assign next_S2 = (((S2_reg & 32'hfffffff0) << 17) ^ b3);
    
    assign random_out = S0_reg ^ S1_reg ^ S2_reg;
    
    always @(posedge clock or posedge reset)
      if (reset)
      begin
        S0_reg <= 32'hf0f0f0f0;
        S1_reg <= 32'hc0c0c0c0;
        S2_reg <= 32'hff00ff00;
        valid_out <= 1'b0;
      end
      else
      begin 
        S0_reg <= next_S0;
        S1_reg <= next_S1;
        S2_reg <= next_S2;
        valid_out <= 1'b1;
      end
endmodule