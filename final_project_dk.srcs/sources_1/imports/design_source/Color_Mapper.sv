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
                       input logic BallOn, Jumping, clk,
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
	      
    logic barrel_on;
    logic girder_on;
    logic jump_on;
    logic ladder_on;

    logic [10:0] shape_x = 0;
    logic [10:0] shape_y = 150;
    logic [10:0] shape_size_x = 480;
    logic [10:0] shape_size_y = 8;
    
    logic [10:0] shape2_x = 160;
    logic [10:0] shape2_y = 250;
    logic [10:0] shape2_size_x = 480;
    logic [10:0] shape2_size_y = 8;
    
    logic [10:0] shape3_x = 20;
    logic [10:0] shape3_y = 350;
    logic [10:0] shape3_size_x = 540;
    logic [10:0] shape3_size_y = 8; 
    
    logic [10:0] shape4_x = 0;
    logic [10:0] shape4_y = 472;
    logic [10:0] shape4_size_x = 640;
    logic [10:0] shape4_size_y = 8;
    
    logic [9:0] ladder1_X_start = 440;
    logic [9:0] ladder1_X_end = 460;
    logic [9:0] ladder1_Y_start = 158;
    logic [9:0] ladder1_Y_end = 250;
    
    logic [9:0] ladder2_X_start = 200;
    logic [9:0] ladder2_X_end = 220;
    logic [9:0] ladder2_Y_start = 258;
    logic [9:0] ladder2_Y_end = 350;
    
    logic [9:0] ladder3_X_start = 500;
    logic [9:0] ladder3_X_end = 520;
    logic [9:0] ladder3_Y_start = 358;
    logic [9:0] ladder3_Y_end = 472;
    
    logic [10:0] jump_size_x = 16;
    logic [10:0] jump_size_y = 32;
    
    logic [7:0] barrelgreen;
    
    int DistX, DistY, Size;
    assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = Ball_size;
    
    always_comb
    begin:Ball_on_proc
        if (DrawX >= JumpX && DrawX < JumpX + jump_size_x &&
            DrawY >= JumpY && DrawY < JumpY + jump_size_y)
        begin
            jump_on = 1'b1;
            girder_on = 1'b0;
            barrel_on = 1'b0;
            ladder_on = 1'b0;
        end  
        else if ( (DistX*DistX + DistY*DistY) <= (Size * Size) )
        begin
            jump_on = 1'b0;
            girder_on = 1'b0;
            barrel_on = 1'b1;
            ladder_on = 1'b0;
        end
        
        else if (DrawX >= shape_x && DrawX < shape_x + shape_size_x &&
            DrawY >= shape_y && DrawY < shape_y + shape_size_y)
        begin
            jump_on = 1'b0;
            girder_on = 1'b1;
            barrel_on = 1'b0;
            ladder_on = 1'b0;
        end
        else if (DrawX >= shape2_x && DrawX < shape2_x + shape2_size_x &&
            DrawY >= shape2_y && DrawY < shape2_y + shape2_size_y)
        begin
            jump_on = 1'b0;
            girder_on = 1'b1;
            barrel_on = 1'b0;
            ladder_on = 1'b0;
        end
        else if (DrawX >= shape3_x && DrawX < shape3_x + shape3_size_x &&
            DrawY >= shape3_y && DrawY < shape3_y + shape3_size_y)
        begin
            jump_on = 1'b0;
            girder_on = 1'b1;
            barrel_on = 1'b0;
            ladder_on = 1'b0;
        end
        else if (DrawX >= shape4_x && DrawX < shape4_x + shape4_size_x &&
            DrawY >= shape4_y && DrawY < shape4_y + shape4_size_y)
        begin
            jump_on = 1'b0;
            girder_on = 1'b1;
            barrel_on = 1'b0;
            ladder_on = 1'b0;
        end
        
        else if (DrawX >= ladder1_X_start && DrawX < ladder1_X_end &&
            DrawY >= ladder1_Y_start && DrawY < ladder1_Y_end)
        begin
            jump_on = 1'b0;
            girder_on = 1'b0;
            barrel_on = 1'b0;
            ladder_on = 1'b1;
        end
        else if (DrawX >= ladder2_X_start && DrawX < ladder2_X_end &&
            DrawY >= ladder2_Y_start && DrawY < ladder2_Y_end)
        begin
            jump_on = 1'b0;
            girder_on = 1'b0;
            barrel_on = 1'b0;
            ladder_on = 1'b1;
        end
        else if (DrawX >= ladder3_X_start && DrawX < ladder3_X_end &&
            DrawY >= ladder3_Y_start && DrawY < ladder3_Y_end)
        begin
            jump_on = 1'b0;
            girder_on = 1'b0;
            barrel_on = 1'b0;
            ladder_on = 1'b1;
        end
        
        else
        begin
            jump_on = 1'b0;
            barrel_on = 1'b0;
            girder_on = 1'b0;
            ladder_on = 1'b0;
        end
     end 
       
    always_comb
    begin:RGB_Display
        if ((girder_on == 1'b1)) begin 
            Red = 8'hff;
            Green = 8'h14;
            Blue = 8'h93;
        end
        else if ((jump_on == 1'b1) && (!Jumping)) begin 
            Red = 8'hff;
            Green = 8'h00;
            Blue = 8'h00;
        end 
        else if ((jump_on == 1'b1) && (!Jumping)) begin 
            Red = 8'hff;
            Green = 8'h00;
            Blue = 8'h11;
        end 
        else if ((barrel_on == 1'b1) && (BallOn)) begin 
            Red = 8'h10;
//            Green = 8'ha5;
            barrelg mygreenbarrel (.read_address(6), .Clk(clk), .data_Out(barrelgreen));
            Green = barrelgreen;
            Blue = 8'h10;
        end
        else if ((barrel_on == 1'b1) && (!BallOn)) begin 
            Red = 8'hff;
            Green = 8'h00;
            Blue = 8'ha5;
        end  
        else if ((ladder_on == 1'b1)) begin 
            Red = 8'h77;
            Green = 8'ha5;
            Blue = 8'h30;
        end      
        else begin 
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 4'h00;
        end      
    end 
    
endmodule
