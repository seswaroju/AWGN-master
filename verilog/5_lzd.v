`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 5_lzd.v 
//
//  description:
//          This file is used to find the leading zero detection for 32 bit number
//
//////////////////////////////////////////////////////////////////////////////////


module lzd_5(
    input [31:0] data_in,
    output [4:0] data_out
    );
    
       // local variables
     wire [31:0] d;
     wire p1 [15:0];
     wire [15:0] v1;
     wire [1:0] p2 [7:0];
     wire [7:0] v2;
     wire [2:0] p3 [3:0];
     wire [3:0] v3;
     wire [3:0] p4 [1:0];
     wire [1:0] v4;
     wire [4:0] p5;
     
     // Parallel structure
     assign d = data_in;
     
     assign p1[0 ] = ~d[1 ];
     assign p1[1 ] = ~d[3 ];
     assign p1[2 ] = ~d[5 ];
     assign p1[3 ] = ~d[7 ];
     assign p1[4 ] = ~d[9 ];
     assign p1[5 ] = ~d[11];
     assign p1[6 ] = ~d[13];
     assign p1[7 ] = ~d[15];
     assign p1[8 ] = ~d[17];
     assign p1[9 ] = ~d[19];
     assign p1[10] = ~d[21];
     assign p1[11] = ~d[23];
     assign p1[12] = ~d[25];
     assign p1[13] = ~d[27];
     assign p1[14] = ~d[29];
     assign p1[15] = ~d[31];
     
     assign v1[0 ] = d[0 ] | d[1 ];
     assign v1[1 ] = d[2 ] | d[3 ];
     assign v1[2 ] = d[4 ] | d[5 ];
     assign v1[3 ] = d[6 ] | d[7 ];
     assign v1[4 ] = d[8 ] | d[9 ];
     assign v1[5 ] = d[10] | d[11];
     assign v1[6 ] = d[12] | d[13];
     assign v1[7 ] = d[14] | d[15];
     assign v1[8 ] = d[16] | d[17];
     assign v1[9 ] = d[18] | d[19];
     assign v1[10] = d[20] | d[21];
     assign v1[11] = d[22] | d[23];
     assign v1[12] = d[24] | d[25];
     assign v1[13] = d[26] | d[27];
     assign v1[14] = d[28] | d[29];
     assign v1[15] = d[30] | d[31];
         
     assign p2[0 ] = {~v1[1 ], (v1[1 ] ? p1[1 ] : p1[0 ])};
     assign p2[1 ] = {~v1[3 ], (v1[3 ] ? p1[3 ] : p1[2 ])};
     assign p2[2 ] = {~v1[5 ], (v1[5 ] ? p1[5 ] : p1[4 ])};
     assign p2[3 ] = {~v1[7 ], (v1[7 ] ? p1[7 ] : p1[6 ])};
     assign p2[4 ] = {~v1[9 ], (v1[9 ] ? p1[9 ] : p1[8 ])};
     assign p2[5 ] = {~v1[11], (v1[11] ? p1[11] : p1[10])};
     assign p2[6 ] = {~v1[13], (v1[13] ? p1[13] : p1[12])};
     assign p2[7 ] = {~v1[15], (v1[15] ? p1[15] : p1[14])};
  
     assign v2[0 ] = v1[1 ] | v1[0 ];
     assign v2[1 ] = v1[3 ] | v1[2 ];
     assign v2[2 ] = v1[5 ] | v1[4 ];
     assign v2[3 ] = v1[7 ] | v1[6 ];
     assign v2[4 ] = v1[9 ] | v1[8 ];
     assign v2[5 ] = v1[11] | v1[10];
     assign v2[6 ] = v1[13] | v1[12];
     assign v2[7 ] = v1[15] | v1[14];
      
     assign p3[0] = {~v2[1 ], (v2[1 ] ? p2[1 ] : p2[0 ])};
     assign p3[1] = {~v2[3 ], (v2[3 ] ? p2[3 ] : p2[2 ])};
     assign p3[2] = {~v2[5 ], (v2[5 ] ? p2[5 ] : p2[4 ])};
     assign p3[3] = {~v2[7 ], (v2[7 ] ? p2[7 ] : p2[6 ])};

     assign v3[0] = v2[1 ] | v2[0 ];
     assign v3[1] = v2[3 ] | v2[2 ];
     assign v3[2] = v2[5 ] | v2[4 ];
     assign v3[3] = v2[7 ] | v2[6 ];
   
     
     assign p4[0] = {~v3[1], (v3[1] ? p3[1] : p3[0])};
     assign p4[1] = {~v3[3], (v3[3] ? p3[3] : p3[2])};
     
     assign v4[0] = v3[1] | v3[0];
     assign v4[1] = v3[3] | v3[2];
         
     assign p5 = {~v4[1], (v4[1] ? p4[1] : p4[0])};
     
     
     // Output data
     assign data_out = p5;
  
endmodule
