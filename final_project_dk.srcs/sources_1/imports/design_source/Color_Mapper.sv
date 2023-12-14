//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Zuofu Cheng   08-19-2023                               --
//                                                                       --
//    Fall 2023 Distribution                                             --
//                                                                       --
//    For use with ECE 385 USB + HDMI                                    --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input  logic [9:0]  DrawX, DrawY, BallX, BallY, Ball_size, JumpX, JumpY,
                       input logic [9:0] Ball2X, Ball2Y, Ball3X, Ball3Y, Ball4X, Ball4Y, Ball5X, Ball5Y,
                       input logic [3:0] game_state,
                       input logic [1:0] lives,
                       input logic BallOn, Jumping, Clk, Direction, Climbing, Frame, Running,
                       input logic Ball2On, Ball3On, Ball4On, Ball5On,
                       input int timer10, timer1,
                       output logic [7:0]  Red, Green, Blue
                       );

	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*BallS, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))
       )

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 120 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	      
    logic barrel_on, girder_on, jump_on, ladder_on, dk_on, princess_on, lives_on, tens_on, ones_on;
    logic barrel2_on, barrel3_on, barrel4_on, barrel5_on;

    logic [10:0] shape_x = 0;
    logic [10:0] shape_y = 150;
    logic [10:0] shape_size_x = 480;
    logic [10:0] shape_size_y = 16;
    
    logic [10:0] shape2_x = 160;
    logic [10:0] shape2_y = 250;
    logic [10:0] shape2_size_x = 480;
    logic [10:0] shape2_size_y = 16;
    
    logic [10:0] shape3_x = 20;
    logic [10:0] shape3_y = 350;
    logic [10:0] shape3_size_x = 540;
    logic [10:0] shape3_size_y = 16; 
    
    logic [10:0] shape4_x = 0;
    logic [10:0] shape4_y = 472;
    logic [10:0] shape4_size_x = 640;
    logic [10:0] shape4_size_y = 8;
    
    logic [9:0] ladder1_X_start = 440;
    logic [9:0] ladder1_X_end = 460;
    logic [9:0] ladder1_Y_start = 162;
    logic [9:0] ladder1_Y_end = 250;
    
    logic [9:0] ladder2_X_start = 200;
    logic [9:0] ladder2_X_end = 220;
    logic [9:0] ladder2_Y_start = 262;
    logic [9:0] ladder2_Y_end = 350;
    
    logic [9:0] ladder3_X_start = 500;
    logic [9:0] ladder3_X_end = 520;
    logic [9:0] ladder3_Y_start = 362;
    logic [9:0] ladder3_Y_end = 472;
    
    logic [9:0] dk_X_start = 10;
    logic [9:0] dk_X_end = 90;
    logic [9:0] dk_Y_start = 86;
    logic [9:0] dk_Y_end = 150;
    
    logic [9:0] princess_X_start = 90;
    logic [9:0] princess_X_end = 120;
    logic [9:0] princess_Y_start = 106;
    logic [9:0] princess_Y_end = 150;
    
    logic [9:0] lives_X_start = 48;
    logic [9:0] lives_X_end = 56;
    logic [9:0] lives_Y_start = 4;
    logic [9:0] lives_Y_end = 14;
    
    logic [9:0] tens_X_start = 616;
    logic [9:0] tens_X_end = 624;
    logic [9:0] tens_Y_start = 4;
    logic [9:0] tens_Y_end = 14;
    
    logic [9:0] ones_X_start = 624;
    logic [9:0] ones_X_end = 632;
    logic [9:0] ones_Y_start = 4;
    logic [9:0] ones_Y_end = 14;
    
    logic [10:0] jump_idle_size_x = 24;
    logic [10:0] jump_idle_size_y = 32;
    logic [10:0] jump_jump_size_x = 32;
    logic [10:0] jump_jump_size_y = 30;
    logic [10:0] jump_climb_size_x = 26;
    logic [10:0] jump_climb_size_y = 32;
    logic [10:0] jump_run1_size_x = 30;
    logic [10:0] jump_run1_size_y = 32;
    logic [10:0] jump_run2_size_x = 30;
    logic [10:0] jump_run2_size_y = 30;
    
    logic [23:0] barrel_0_color, barrel_2_color, dk_color, princess_color, start_text_color, game_text_color, end_text_color, win_text_color, lives_text_color;
    logic [23:0] tens_text_color, ones_text_color;
    logic [23:0] mario_jump_color, mario_idle_color, mario_climb_color, mario_run1_color, mario_run2_color;
    logic [23:0] barrel2_0_color, barrel2_2_color, barrel3_0_color, barrel3_2_color, barrel4_0_color, barrel4_2_color, barrel5_0_color, barrel5_2_color;
    
    logic [18:0] barrel_address, dk_address, text_address, princess_address, lives_address, tens_address, ones_address;
    logic [18:0] mario_jump_address, mario_idle_address, mario_climb_address, mario_run1_address, mario_run2_address;
    logic [18:0] barrel2_address, barrel3_address, barrel4_address, barrel5_address;

    int DistX, DistY, Dist2X, Dist2Y, Dist3X, Dist3Y, Dist4X, Dist4Y, Dist5X, Dist5Y, Size;
    
    assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Dist2X = DrawX - Ball2X;
    assign Dist2Y = DrawY - Ball2Y;
    assign Dist3X = DrawX - Ball3X;
    assign Dist3Y = DrawY - Ball3Y;
    assign Dist4X = DrawX - Ball4X;
    assign Dist4Y = DrawY - Ball4Y;
    assign Dist5X = DrawX - Ball5X;
    assign Dist5Y = DrawY - Ball5Y;
    
    assign Size = Ball_size;
    
    assign barrel_address=(DistY+10'd8)*24+(DistX+10'd12);
    assign barrel2_address=(Dist2Y+10'd8)*24+(Dist2X+10'd12);
    assign barrel3_address=(Dist3Y+10'd8)*24+(Dist3X+10'd12);
    assign barrel4_address=(Dist4Y+10'd8)*24+(Dist4X+10'd12);
    assign barrel5_address=(Dist5Y+10'd8)*24+(Dist5X+10'd12);
    
    assign dk_address = (DrawY - dk_Y_start) * 80 + (DrawX - dk_X_start);
    assign princess_address = (DrawY - princess_Y_start) * 30 + (DrawX - princess_X_start);
    assign text_address = (DrawY - 10'd4) * 640 + DrawX;
    assign lives_address = (lives * 8 * 14) + (DrawY - 10'd4) * 8 + (DrawX - lives_X_start);
    assign tens_address = (timer10 * 8 * 14) + (DrawY - 10'd4) * 8 + (DrawX - tens_X_start);
    assign ones_address = (timer1 * 8 * 14) + (DrawY - 10'd4) * 8 + (DrawX - ones_X_start);
    
    always_comb
    begin:Ball_on_proc
    
        if (Direction)
        begin
            mario_jump_address <= (DrawY - JumpY) * 32 + (31 - (DrawX - JumpX - 1));
            mario_idle_address <= (DrawY - JumpY) * 24 + (23 - (DrawX - JumpX - 1));
            mario_run1_address <= (DrawY - JumpY) * 30 + (29 - (DrawX - JumpX - 1));
            mario_run2_address <= (DrawY - JumpY) * 30 + (29 - (DrawX - JumpX - 1));
        end
        else
        begin
            mario_jump_address <= (DrawY - JumpY) * 32 + (DrawX - JumpX - 1);
            mario_idle_address <= (DrawY - JumpY) * 24 + (DrawX - JumpX - 1);
            mario_run1_address <= (DrawY - JumpY) * 30 + (DrawX - JumpX - 1);
            mario_run2_address <= (DrawY - JumpY) * 30 + (DrawX - JumpX - 1);
        end
        
        if (Frame)
        begin
            mario_climb_address <= (DrawY - JumpY) * 26 + (25 - (DrawX - JumpX));
        end
        else
        begin
            mario_climb_address <= (DrawY - JumpY) * 26 + (DrawX - JumpX);
        end
    
    
        if (DrawX >= JumpX && DrawX < JumpX + jump_idle_size_x &&
            DrawY >= JumpY && DrawY < JumpY + jump_idle_size_y && Jumping == 1'b0 && Climbing == 1'b0 && Running == 1'b0)
        begin
            jump_on = 1'b1;
        end 
        else if (DrawX >= JumpX && DrawX < JumpX + jump_jump_size_x &&
            DrawY >= JumpY && DrawY < JumpY + jump_jump_size_y && Jumping == 1'b1 && Climbing == 1'b0)
        begin
            jump_on = 1'b1;
        end  
        else if (DrawX >= JumpX && DrawX < JumpX + jump_climb_size_x &&
            DrawY >= JumpY && DrawY < JumpY + jump_climb_size_y && Climbing == 1'b1)
        begin
            jump_on = 1'b1;
        end    
        else if (DrawX >= JumpX && DrawX < JumpX + jump_run1_size_x &&
            DrawY >= JumpY && DrawY < JumpY + jump_run1_size_y && Jumping == 1'b0 && Climbing == 1'b0 && Running == 1'b1)
        begin
            jump_on = 1'b1;
        end      
        else if (DrawX >= JumpX && DrawX < JumpX + jump_run2_size_x &&
            DrawY >= JumpY && DrawY < JumpY + jump_run2_size_y && Jumping == 1'b0 && Climbing == 1'b0 && Running == 1'b1)
        begin
            jump_on = 1'b1;
        end  
        else if ( (DistX*DistX + DistY*DistY) <= (Size * Size) )
        begin
            barrel_on = 1'b1;
            jump_on = 1'b0;
        end  
        else if ( (Dist2X*Dist2X + Dist2Y*Dist2Y) <= (Size * Size) )
        begin
            barrel2_on = 1'b1;
            jump_on = 1'b0;
        end  
        else if ( (Dist3X*Dist3X + Dist3Y*Dist3Y) <= (Size * Size) )
        begin
            barrel3_on = 1'b1;
            jump_on = 1'b0;
        end  
        else if ( (Dist4X*Dist4X + Dist4Y*Dist4Y) <= (Size * Size) )
        begin
            barrel4_on = 1'b1;
            jump_on = 1'b0;
        end  
        else if ( (Dist5X*Dist5X + Dist5Y*Dist5Y) <= (Size * Size) )
        begin
            barrel5_on = 1'b1;
            jump_on = 1'b0;
        end
                
        else if (DrawX >= lives_X_start && DrawX < lives_X_end &&
            DrawY >= lives_Y_start && DrawY < lives_Y_end)
        begin
            lives_on = 1'b1;
        end
                
        else if (DrawX >= tens_X_start && DrawX < tens_X_end &&
            DrawY >= tens_Y_start && DrawY < tens_Y_end)
        begin
            tens_on = 1'b1;
        end
                
        else if (DrawX >= ones_X_start && DrawX < ones_X_end &&
            DrawY >= ones_Y_start && DrawY < ones_Y_end)
        begin
            ones_on = 1'b1;
        end
        
        else if (DrawX >= shape_x && DrawX < shape_x + shape_size_x &&
            DrawY >= shape_y && DrawY < shape_y + shape_size_y)
        begin
            girder_on = 1'b1;
            jump_on = 1'b0;
        end
        else if (DrawX >= shape2_x && DrawX < shape2_x + shape2_size_x &&
            DrawY >= shape2_y && DrawY < shape2_y + shape2_size_y)
        begin
            girder_on = 1'b1;
            ladder_on = 1'b0;
            jump_on = 1'b0;
        end
        else if (DrawX >= shape3_x && DrawX < shape3_x + shape3_size_x &&
            DrawY >= shape3_y && DrawY < shape3_y + shape3_size_y)
        begin
            girder_on = 1'b1;
            ladder_on = 1'b0;
            jump_on = 1'b0;
        end
        else if (DrawX >= shape4_x && DrawX < shape4_x + shape4_size_x &&
            DrawY >= shape4_y && DrawY < shape4_y + shape4_size_y)
        begin
            girder_on = 1'b1;
            ladder_on = 1'b0;
            jump_on = 1'b0;
        end
        
        else if (DrawX >= ladder1_X_start && DrawX < ladder1_X_end &&
            DrawY >= ladder1_Y_start && DrawY < ladder1_Y_end)
        begin
            ladder_on = 1'b1;
            girder_on = 1'b0;
            jump_on = 1'b0;
        end
        else if (DrawX >= ladder2_X_start && DrawX < ladder2_X_end &&
            DrawY >= ladder2_Y_start && DrawY < ladder2_Y_end)
        begin
            ladder_on = 1'b1;
            girder_on = 1'b0;
            jump_on = 1'b0;
        end
        else if (DrawX >= ladder3_X_start && DrawX < ladder3_X_end &&
            DrawY >= ladder3_Y_start && DrawY < ladder3_Y_end)
        begin
            ladder_on = 1'b1;
            girder_on = 1'b0;
            jump_on = 1'b0;
        end
        
        else if (DrawX >= dk_X_start && DrawX < dk_X_end &&
            DrawY >= dk_Y_start && DrawY < dk_Y_end)
        begin
            dk_on = 1'b1;
        end
        
        else if (DrawX >= princess_X_start && DrawX < princess_X_end &&
            DrawY >= princess_Y_start && DrawY < princess_Y_end)
        begin
            princess_on = 1'b1;
        end

        
        else
        begin
            jump_on = 1'b0;
            barrel_on = 1'b0;
            barrel2_on = 1'b0;
            barrel3_on = 1'b0;
            barrel4_on = 1'b0;
            barrel5_on = 1'b0;
            girder_on = 1'b0;
            ladder_on = 1'b0;
            dk_on = 1'b0;
            princess_on = 1'b0;
            lives_on = 1'b0;
            tens_on = 1'b0;
            ones_on = 1'b0;
        end
     end 
       
    always_comb
    begin:RGB_Display

        if (dk_on == 1'b1) begin
//            Red = 8'hff;
//            Green = 8'hff;
//            Blue = 8'hff;
            Red = dk_color[7:0];
            Green = dk_color[15:8];
            Blue = dk_color[23:16];
        end
        else if (princess_on == 1'b1) begin
//            Red = 8'hff;
//            Green = 8'hff;
//            Blue = 8'hff;
            Red = princess_color[7:0];
            Green = princess_color[15:8];
            Blue = princess_color[23:16];
        end
        else if ((jump_on == 1'b1) && (!Jumping) && (!Climbing) && (!Running) && (mario_idle_color != 24'b0)) begin 
            Red = mario_idle_color[7:0];
            Green = mario_idle_color[15:8];
            Blue = mario_idle_color[23:16];
        end 
        else if ((jump_on == 1'b1) && (Jumping) && (!Climbing) && (mario_jump_color != 24'b0)) begin 
            Red = mario_jump_color[7:0];
            Green = mario_jump_color[15:8];
            Blue = mario_jump_color[23:16];
        end 
        else if ((jump_on == 1'b1) && (Climbing)  && (mario_climb_color != 24'b0)) begin 
            Red = mario_climb_color[7:0];
            Green = mario_climb_color[15:8];
            Blue = mario_climb_color[23:16];
        end  
        else if ((jump_on == 1'b1) && (Running) && (!Climbing) && (!Jumping) && (mario_run1_color != 24'b0) && (Frame)) begin 
            Red = mario_run1_color[7:0];
            Green = mario_run1_color[15:8];
            Blue = mario_run1_color[23:16];
        end   
        else if ((jump_on == 1'b1) && (Running) && (!Climbing) && (!Jumping) && (mario_run2_color != 24'b0) && (!Frame)) begin 
            Red = mario_run2_color[7:0];
            Green = mario_run2_color[15:8];
            Blue = mario_run2_color[23:16];
        end 
        
        //barrel rotation
        else if ((barrel_on == 1'b1) && (BallOn == 0) && (barrel_0_color != 24'b0)) begin
            Red = barrel_0_color[7:0];
            Green = barrel_0_color[15:8];
            Blue = barrel_0_color[23:16];
        end 
        else if ((barrel_on == 1'b1) && (BallOn == 1) && (barrel_2_color != 24'b0)) begin
            Red = barrel_2_color[7:0];
            Green = barrel_2_color[15:8];
            Blue = barrel_2_color[23:16];
        end
        else if ((barrel2_on == 1'b1) && (Ball2On == 0) && (barrel2_0_color != 24'b0)) begin
            Red = barrel2_0_color[7:0];
            Green = barrel2_0_color[15:8];
            Blue = barrel2_0_color[23:16];
        end 
        else if ((barrel2_on == 1'b1) && (Ball2On == 1) && (barrel2_2_color != 24'b0)) begin
            Red = barrel2_2_color[7:0];
            Green = barrel2_2_color[15:8];
            Blue = barrel2_2_color[23:16];
        end
        
        else if ((barrel3_on == 1'b1) && (Ball3On == 0) && (barrel3_0_color != 24'b0)) begin
            Red = barrel3_0_color[7:0];
            Green = barrel3_0_color[15:8];
            Blue = barrel3_0_color[23:16];
        end 
        else if ((barrel3_on == 1'b1) && (Ball3On == 1) && (barrel3_2_color != 24'b0)) begin
            Red = barrel3_2_color[7:0];
            Green = barrel3_2_color[15:8];
            Blue = barrel3_2_color[23:16];
        end
        
        else if ((barrel4_on == 1'b1) && (Ball4On == 0) && (barrel4_0_color != 24'b0)) begin
            Red = barrel4_0_color[7:0];
            Green = barrel4_0_color[15:8];
            Blue = barrel4_0_color[23:16];
        end 
        else if ((barrel4_on == 1'b1) && (Ball4On == 1) && (barrel4_2_color != 24'b0)) begin
            Red = barrel4_2_color[7:0];
            Green = barrel4_2_color[15:8];
            Blue = barrel4_2_color[23:16];
        end
        
        else if ((barrel5_on == 1'b1) && (Ball5On == 0) && (barrel5_0_color != 24'b0)) begin
            Red = barrel5_0_color[7:0];
            Green = barrel5_0_color[15:8];
            Blue = barrel5_0_color[23:16];
        end 
        else if ((barrel5_on == 1'b1) && (Ball5On == 1) && (barrel5_2_color != 24'b0)) begin
            Red = barrel5_2_color[7:0];
            Green = barrel5_2_color[15:8];
            Blue = barrel5_2_color[23:16];
        end
        
        else if ((girder_on == 1'b1)) begin 
        
            if( (DrawY == shape_y) || (DrawY-1 == shape_y) || (DrawY + 2 == shape_y + shape_size_y) || (DrawY + 1 == shape_y + shape_size_y) ||
                (DrawY == shape2_y) || (DrawY-1 == shape2_y) || (DrawY + 2 == shape2_y + shape2_size_y) || (DrawY + 1 == shape2_y  + shape2_size_y) ||
                (DrawY == shape3_y) || (DrawY-1 == shape3_y) || (DrawY + 2 == shape3_y + shape3_size_y) || (DrawY + 1 == shape3_y  + shape3_size_y) ||
                (DrawY == shape4_y) || (DrawY-1 == shape4_y) || (DrawY + 2 == shape4_y + shape4_size_y) || (DrawY + 1 == shape4_y  + shape4_size_y))
            begin
                Red = 8'hff;
                Green = 8'h14;
                Blue = 8'h93;
            end
            else if (DrawY[3:0] == DrawX[3:0] || DrawY[3:0] == DrawX[3:0] - 1 || DrawY[3:0] == DrawX[3:0] - 2 || 
                     DrawY[3:0] == ~(DrawX[3:0]) || DrawY[3:0] == ~(DrawX[3:0]) - 1 || DrawY[3:0] == ~(DrawX[3:0]) - 2)
            begin
                Red = 8'hff;
                Green = 8'h14;
                Blue = 8'h93;
            end
            else
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
        end
        
        else if ((ladder_on == 1'b1)) begin
            if( (DrawX == ladder1_X_start) || (DrawX-1 == ladder1_X_start) || (DrawX + 2 == ladder1_X_end) || (DrawX + 1 == ladder1_X_end) ||
                (DrawX == ladder2_X_start) || (DrawX-1 == ladder2_X_start) || (DrawX + 2 == ladder2_X_end) || (DrawX + 1 == ladder2_X_end) ||
                (DrawX == ladder3_X_start) || (DrawX-1 == ladder3_X_start) || (DrawX + 2 == ladder3_X_end) || (DrawX + 1 == ladder3_X_end))
            begin
                Red = 8'h19;
                Green = 8'hf1;
                Blue = 8'hff;
            end
            else if( (DrawY[3:0] == 4'h8) || DrawY[3:0] == 4'h9 || DrawY[3:0] == 4'ha)
            begin
                Red = 8'h19;
                Green = 8'hf1;
                Blue = 8'hff;
            end
            else
            begin
                Red = 8'h00;
                Green = 8'h00;
                Blue = 8'h00;
            end
        end
        
        
          
        
        

        else if ((lives_on == 1'b1)) begin
//            Red = 8'hff; 
//            Green = 8'hff; 
//            Blue = 8'hff; 
            Red = lives_text_color[7:0];
            Green = lives_text_color[15:8];
            Blue = lives_text_color[23:16];
        end 
         
        else if ((tens_on == 1'b1)) begin
//            Red = 8'hff; 
//            Green = 8'hff; 
//            Blue = 8'hff; 
            Red = tens_text_color[7:0];
            Green = tens_text_color[15:8];
            Blue = tens_text_color[23:16];
        end  
        
        else if ((ones_on == 1'b1)) begin
//            Red = 8'hff; 
//            Green = 8'hff; 
//            Blue = 8'hff; 
            Red = ones_text_color[7:0];
            Green = ones_text_color[15:8];
            Blue = ones_text_color[23:16];
        end  
            
        else begin 
//        Red = 8'h00; 
//        Green = 8'h00;
//        Blue = 8'h00;
            if ((DrawY < 4) || (DrawY > 14)) 
            begin
                Red = 8'h00; 
                Green = 8'h00;
                Blue = 8'h00;
            end
            else
            begin
                if(game_state == 4'b0000)
                begin
                    Red = start_text_color[7:0];
                    Green = start_text_color[15:8];
                    Blue = start_text_color[23:16];
                end
                else if(game_state == 4'b0111)
                begin
                    Red = end_text_color[7:0];
                    Green = end_text_color[15:8];
                    Blue = end_text_color[23:16];
                end
                else if(game_state == 4'b1000)
                begin
                    Red = win_text_color[7:0];
                    Green = win_text_color[15:8];
                    Blue = win_text_color[23:16];
                end
                else
                begin
                    Red = game_text_color[7:0];
                    Green = game_text_color[15:8];
                    Blue = game_text_color[23:16];
                end
            end
        end      
    end 
    
    barrel_0_sprite upright_barrel (.read_address(barrel_address), .Clk(Clk), .data_Out(barrel_0_color));
    barrel_2_sprite upside_barrel (.read_address(barrel_address), .Clk(Clk), .data_Out(barrel_2_color));
    
    barrel_0_sprite upright_barrel2 (.read_address(barrel2_address), .Clk(Clk), .data_Out(barrel2_0_color));
    barrel_2_sprite upside_barrel2 (.read_address(barrel2_address), .Clk(Clk), .data_Out(barrel2_2_color));
    
    barrel_0_sprite upright_barrel3 (.read_address(barrel3_address), .Clk(Clk), .data_Out(barrel3_0_color));
    barrel_2_sprite upside_barrel3 (.read_address(barrel3_address), .Clk(Clk), .data_Out(barrel3_2_color));
    
    barrel_0_sprite upright_barrel4 (.read_address(barrel4_address), .Clk(Clk), .data_Out(barrel4_0_color));
    barrel_2_sprite upside_barrel4 (.read_address(barrel4_address), .Clk(Clk), .data_Out(barrel4_2_color));
    
    barrel_0_sprite upright_barrel5 (.read_address(barrel5_address), .Clk(Clk), .data_Out(barrel5_0_color));
    barrel_2_sprite upside_barrel5 (.read_address(barrel5_address), .Clk(Clk), .data_Out(barrel5_2_color));
    
    dk_sprite donkex_kong (.read_address(dk_address), .Clk(Clk), .data_Out(dk_color));
    princess_sprite princess_pauline (.read_address(princess_address), .Clk(Clk), .data_Out(princess_color));
    start_text_sprite start_text_info (.read_address(text_address), .Clk(Clk), .data_Out(start_text_color));
    game_text_sprite game_text_info (.read_address(text_address), .Clk(Clk), .data_Out(game_text_color));
    end_text_sprite end_text_info (.read_address(text_address), .Clk(Clk), .data_Out(end_text_color));
    win_text_sprite win_text_info (.read_address(text_address), .Clk(Clk), .data_Out(win_text_color));
    digit_text_sprite lives_text_info (.read_address(lives_address), .Clk(Clk), .data_Out(lives_text_color));
    digit_text_sprite tens_text_info (.read_address(tens_address), .Clk(Clk), .data_Out(tens_text_color));
    digit_text_sprite ones_text_info (.read_address(ones_address), .Clk(Clk), .data_Out(ones_text_color));
    
    mario_jump_sprite mario_jump_info (.read_address(mario_jump_address), .Clk(Clk), .data_Out(mario_jump_color));
    mario_idle_sprite mario_idle_info (.read_address(mario_idle_address), .Clk(Clk), .data_Out(mario_idle_color));
    mario_climb_sprite mario_climb_info (.read_address(mario_climb_address), .Clk(Clk), .data_Out(mario_climb_color));
    mario_run1_sprite mario_run1_info (.read_address(mario_run1_address), .Clk(Clk), .data_Out(mario_run1_color));
    mario_run2_sprite mario_run2_info (.read_address(mario_run2_address), .Clk(Clk), .data_Out(mario_run2_color));

    
endmodule
