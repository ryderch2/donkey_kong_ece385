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


module  color_mapper ( input  logic [9:0]  DrawX, DrawY, BallX, BallY, Ball_size,
                       output logic [3:0]  Red, Green, Blue );

	 
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
	      
    logic shape_on;
    logic shape2_on;

    logic [10:0] shape_x = 300;
    logic [10:0] shape_y = 300;
    logic [10:0] shape_size_x = 10;
    logic [10:0] shape_size_y = 10;
    
    logic [10:0] shape2_x = 400;
    logic [10:0] shape2_y = 100;
    logic [10:0] shape2_size_x = 10;
    logic [10:0] shape2_size_y = 10;
  
    always_comb
    begin:Ball_on_proc
        if (DrawX >= shape_x && DrawX < shape_x + shape_size_x &&
            DrawY >= shape_y && DrawY < shape_y + shape_size_y)
        begin
            shape_on = 1'b1;
            shape2_on = 1'b0;
        end
        else if (DrawX >= shape2_x && DrawX < shape2_x + shape2_size_x &&
                 DrawY >= shape2_y && DrawY < shape2_y + shape2_size_y)
        begin
            shape_on = 1'b0;
            shape2_on = 1'b1;
        end
        else
        begin
            shape_on = 1'b0;
            shape2_on = 1'b0;
        end
     end 
       
    always_comb
    begin:RGB_Display
        if ((shape_on == 1'b1)) begin 
            Red = 8'hff;
            Green = 8'h77;
            Blue = 8'h00;
        end
        else if ((shape2_on == 1'b1)) begin 
            Red = 8'haa;
            Green = 8'h00;
            Blue = 8'h99;
        end      
        else begin 
            Red = 8'hff; 
            Green = 8'h00;
            Blue = 4'h44;
        end      
    end 
    
endmodule
