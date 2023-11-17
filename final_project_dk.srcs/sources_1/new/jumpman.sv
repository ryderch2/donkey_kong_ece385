//-------------------------------------------------------------------------
//    Jumpman.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Zuofu Cheng   08-19-2023                               --
//    Fall 2023 Distribution                                             --
//                                                                       --
//    For use with ECE 385 USB + HDMI Lab                                --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  jumpman ( input logic Reset, frame_clk,
			   input logic [7:0] keycode,
               output logic [9:0]  JumpX, JumpY);
    
    logic [9:0] Jump_X_Motion, Jump_Y_Motion;
	 
    parameter [9:0] Jump_X_Center=320;  // Center position on the X axis
    parameter [9:0] Jump_Y_Center=340;  // Center position on the Y axis
    parameter [9:0] Jump_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Jump_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Jump_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Jump_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Jump_X_Step=1;      // Step size on the X axis
    parameter [9:0] Jump_Y_Step=4;      // Step size on the Y axis
    parameter [9:0] Box_1_X_Start = 0;
    parameter [9:0] Box_1_X_End = 480;
    parameter [9:0] Box_1_Y = 100;
    parameter [9:0] Box_2_X_Start = 160;
    parameter [9:0] Box_2_X_End = 640;
    parameter [9:0] Box_2_Y = 200;
    parameter [9:0] Box_3_X_Start = 160;
    parameter [9:0] Box_3_X_End = 480;
    parameter [9:0] Box_3_Y = 300;
    parameter [9:0] JumpSX = 16;  // default Jump size
    parameter [9:0] JumpSY = 32;  // default Jump size
    
    assign direction = 1;
   
    always_ff @ (posedge frame_clk or posedge Reset) //make sure the frame clock is instantiated correctly
    begin: Move_Jump
        if (Reset)  // asynchronous Reset
        begin 
            Jump_Y_Motion <= 10'd0; //Jump_Y_Step;
			Jump_X_Motion <= 10'd0; //Jump_X_Step;
			JumpY <= Jump_Y_Center;
			JumpX <= Jump_X_Center;
        end
           
        else 
        begin 
//                if ( (JumpY + JumpSY) >= Box_1_Y && (JumpY + JumpSY) <= (Box_1_Y + 20) && (JumpX - JumpSX) <= Box_1_X_End)
//                begin
//                    Jump_Y_Motion <= 1'b0;
//                    Jump_X_Motion <= Jump_X_Step;
//                end
                  
//                else if ( (JumpY + JumpSY) >= Box_2_Y && (JumpY + JumpSY) <= (Box_2_Y + 20) && (JumpX + JumpSX) >= Box_2_X_Start)
//                begin
//                    Jump_Y_Motion <= 1'b0;
//                    Jump_X_Motion <= (~ (Jump_X_Step) + 1'b1);
//                end 
                 
//                else if ( (JumpY + JumpSY) >= Box_3_Y && (JumpY + JumpSY) <= (Box_3_Y + 20) && (JumpX - JumpSX) <= Box_3_X_End)
//                begin
//                    Jump_Y_Motion <= 1'b0;
//                    Jump_X_Motion <= Jump_X_Step;
//                end 
                
//                if ( (JumpX) <= Jump_X_Min )  // Jump is at the Left edge, BOUNCE!
//				begin
//					  Jump_X_Motion <= 1'b0;
//			    end
			               
				if ( (JumpY + JumpSY) >= Jump_Y_Max )  // Jump is at the bottom edge, BOUNCE!
					  Jump_Y_Motion <= 1'b0;  // 2's complement.
					  
				else if ( (JumpY) <= Jump_Y_Min )  // Jump is at the top edge, BOUNCE!
					  Jump_Y_Motion <= 1'b0;
					  
//				else if ( (JumpX + JumpSY) >= Jump_X_Max )  // Jump is at the Right edge, BOUNCE!
//					  Jump_X_Motion <= 1'b0;  // 2's complement.
					  
				else 
	 			   Jump_Y_Motion <= Jump_Y_Step;  // Jump is somewhere in the middle, don't bounce, just keep moving
					  
				 //modify to control Jump motion with the keycode
				case (keycode)
					8'h04 :  //A
					begin
					   if (JumpX >= Jump_X_Min)
					       Jump_X_Motion <= -1;//A
					end        
					8'h07 :  //D
					begin
					   if ( (JumpX + JumpSX) <= Jump_X_Max)
					       Jump_X_Motion <= 1;//D
					end
							  
//					8'h16 :  //S
//					   Jump_X_Motion <= 0;
							  
//					8'h1A :  //W
//					   Jump_X_Motion <= 1;
							 	  
					default: 
					   Jump_X_Motion <= 0;
			   endcase
                
		       JumpY <= (JumpY + Jump_Y_Motion);  // Update Jump position
			   JumpX <= (JumpX + Jump_X_Motion);
			
		end  
    end
      
endmodule
