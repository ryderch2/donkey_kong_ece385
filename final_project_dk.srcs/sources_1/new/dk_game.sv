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
    input logic [0:0] collisions, save_princess,
    input logic [7:0] keycode,
    output int timer10, timer1,
    output logic [3:0] game_state,
    output logic [1:0] lives,
    output logic reset_game, ball2off
    
    );
    
    enum logic[3:0] {start_menu, three_life, three_life_swap, two_life, two_life_swap, one_life, one_life_swap, game_over, win_game} curr_state, next_state;
    
    assign game_state = curr_state;
    
    int counter;
    
    always_ff @ (posedge Clk or posedge Reset)
     begin : next_state_logic 
         if(Reset)
         begin
            timer10 <= 9;
            timer1 <= 9;
            counter <= 0;
            curr_state <= start_menu;
         end
         else
         begin
            if(counter >= 60)
            begin
                counter = 0;
                if(timer1 == 0)
                begin
                    if(timer10 != 0)
                    begin
                        timer1 <= 9;
                        timer10 <= timer10 - 1;
                    end
                end
                else
                    timer1 <= timer1 - 1;
            end
            else
            begin
                if(game_state != 4'b0000 && game_state != 4'b0111 && game_state != 4'b1000)
                    counter <= counter + 1;
            end
         
            case(curr_state)
                start_menu: 
                    if(keycode == 8'h28) //enter
                        next_state = three_life;
                    else if (timer10 == 0 && timer1 == 0)
                        next_state = game_over;
                    else
                        next_state = start_menu;
                three_life:
                    if (collisions[0])
                        next_state = three_life_swap;
                    else if (save_princess)
                        next_state = win_game;
                    else if (timer10 == 0 && timer1 == 0)
                        next_state = game_over;
                    else
                        next_state = three_life;
                three_life_swap:
                    if (!collisions[0])
                        next_state = two_life;
                    else if (timer10 == 0 && timer1 == 0)
                        next_state = game_over;
                    else
                        next_state = three_life_swap;
                two_life:
                    if (collisions[0])
                        next_state = two_life_swap;
                    else if (save_princess)
                        next_state = win_game;
                    else if (timer10 == 0 && timer1 == 0)
                        next_state = game_over;
                    else
                        next_state = two_life;
                two_life_swap:
                    if (!collisions[0])
                        next_state = one_life;
                    else if (timer10 == 0 && timer1 == 0)
                        next_state = game_over;
                    else
                        next_state = two_life_swap;
                one_life:
                    if (collisions[0])
                        next_state = one_life_swap;
                    else if (save_princess)
                        next_state = win_game;
                    else if (timer10 == 0 && timer1 == 0)
                        next_state = game_over;
                    else
                        next_state = one_life;
                one_life_swap:
                    if (!collisions[0])
                        next_state = game_over;
                    else if (timer10 == 0 && timer1 == 0)
                        next_state = game_over;
                    else
                        next_state = one_life_swap;
                game_over:
                if(keycode == 8'h28) //enter
                        next_state = three_life;
                else
                    next_state = game_over;
                win_game:
                if(keycode == 8'h28) //enter
                    next_state = three_life;
                else
                    next_state = win_game;
            endcase
                
                curr_state <= next_state;
        end
     end
     
     always_comb begin
        case(game_state)
            start_menu: 
            begin
                lives = 2'b11;
                reset_game = 1'b1;
            end
            
            three_life: 
            begin
                lives = 2'b11;
                reset_game = 1'b0;
            end
            three_life_swap: 
            begin
                lives = 2'b11;
                reset_game = 1'b1;
            end
            
            two_life: 
            begin
                lives = 2'b10;
                reset_game = 1'b0;
            end
            two_life_swap: 
            begin
                lives = 2'b10;
                reset_game = 1'b1;
            end
            
            one_life: 
            begin
                lives = 2'b01;
                reset_game = 1'b0;
            end
            one_life_swap: 
            begin
                lives = 2'b01;
                reset_game = 1'b1;
            end
            
            game_over: 
            begin
                lives = 2'b00;
                reset_game = 1'b1;
            end
            
            win_game: 
            begin
                lives = 2'b11;
                reset_game = 1'b1;
            end
            default:
            begin
                lives = 2'b11;
                reset_game = 1'b0;
            end
        endcase
     end
     
    
endmodule
