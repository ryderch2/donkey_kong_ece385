`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 08:13:06 PM
// Design Name: 
// Module Name: dk_game
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


module dk_game(
    input logic Clk, Reset,
    input logic [0:0] collisions,
    input logic [7:0] keycode,
    output logic [2:0] game_state,
    output logic reset_game
    
    );
    
    enum logic[2:0] {coin, three_life, three_life_swap, two_life, two_life_swap, one_life, one_life_swap, game_over} curr_state, next_state;
    
    assign game_state = curr_state;
    
    always_ff @ (posedge Clk or posedge Reset)
     begin : next_state_logic 
         if(Reset)
         begin
            curr_state = coin;
         end
         else
         begin
         
            case(curr_state)
                coin: 
                    if(keycode == 8'h28) //enter
                        next_state = three_life;
                    else
                        next_state = coin;
                three_life:
                    if (collisions[0])
                        next_state = three_life_swap;
                    else
                        next_state = three_life;
                three_life_swap:
                    if (!collisions[0])
                        next_state = two_life;
                    else
                        next_state = three_life_swap;
                two_life:
                    if (collisions[0])
                        next_state = two_life_swap;
                    else
                        next_state = two_life;
                two_life_swap:
                    if (!collisions[0])
                        next_state = one_life;
                    else
                        next_state = two_life_swap;
                one_life:
                    if (collisions[0])
                        next_state = one_life_swap;
                    else
                        next_state = one_life;
                one_life_swap:
                    if (!collisions[0])
                        next_state = game_over;
                    else
                        next_state = one_life_swap;
                game_over:
                    next_state = game_over;
            endcase
                
                curr_state <= next_state;
        end
     end
     
     always_comb begin
        case(game_state)
            coin: reset_game = 1'b1;
            three_life_swap: reset_game = 1'b1;
            two_life_swap: reset_game = 1'b1;
            one_life_swap: reset_game = 1'b1;
            game_over: reset_game = 1'b1;
            default: reset_game = 1'b0;
        endcase
     end
     
    
endmodule
