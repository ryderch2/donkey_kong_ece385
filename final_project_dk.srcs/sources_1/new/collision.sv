`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ryder and Sam
// 
// Create Date: 12/03/2023 05:31:32 PM
// Design Name: 
// Module Name: collision
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module collision(
    input logic frame_clk,
    input logic [9:0] BallX, BallY, JumpX, JumpY,
    output logic Collision
    );
    
    parameter [9:0] JumpSX = 16;
    parameter [9:0] JumpSY = 32;
    parameter [9:0] BallS = 6;
    parameter [9:0] Barrel_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Barrel_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Barrel_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Barrel_Y_Max=471;     // Bottommost point on the Y axis
    parameter [9:0] Barrel_X_Step=2;      // Step size on the X axis
    parameter [9:0] Barrel_Y_Step=2;      // Step size on the Y axis
    
    
    always_ff @ (posedge frame_clk)
    begin
        if (BallX - BallS >= Barrel_X_Max)
            Collision <= 1'b0;
        else if( ((BallX - BallS >= JumpX && BallX - BallS < JumpX + JumpSX) || (BallX - BallS >= JumpX && BallX + BallS < JumpX + JumpSX))
         && (BallY >= JumpY) && (BallY < JumpY + JumpSY))
            Collision <= 1'b1;
        else
            Collision <= 1'b0;
    end
endmodule
