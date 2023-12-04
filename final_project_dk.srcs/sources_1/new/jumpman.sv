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
			   input logic [7:0] keycode0, keycode1,
               output logic [9:0]  JumpX, JumpY,
               output logic [7:0] jumping);
    
    logic [9:0] Jump_X_Motion, Jump_Y_Motion;
	 
    parameter [9:0] Jump_X_Center=50;  // Center position on the X axis
    parameter [9:0] Jump_Y_Center=340;  // Center position on the Y axis
    parameter [9:0] Jump_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Jump_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Jump_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Jump_Y_Max=473;     // Bottommost point on the Y axis
    parameter [9:0] Jump_X_Step=1;      // Step size on the X axis
    parameter [9:0] Jump_Y_Step=1;      // Step size on the Y axis
    parameter [9:0] Jump_Y_Jump=2;
    parameter [9:0] Box_1_X_Start = 0;
    parameter [9:0] Box_1_X_End = 480;
    parameter [9:0] Box_1_Y = 152;
    parameter [9:0] Box_2_X_Start = 160;
    parameter [9:0] Box_2_X_End = 640;
    parameter [9:0] Box_2_Y = 252;
    parameter [9:0] Box_3_X_Start = 20;
    parameter [9:0] Box_3_X_End = 560;
    parameter [9:0] Box_3_Y = 352;
    
    parameter [9:0] Ladder_1_X_Start = 440;
    parameter [9:0] Ladder_1_X_End = 460;
    parameter [9:0] Ladder_1_Y_Start = 158;
    parameter [9:0] Ladder_1_Y_End = 250;
    parameter [9:0] Ladder_2_X_Start = 200;
    parameter [9:0] Ladder_2_X_End = 220;
    parameter [9:0] Ladder_2_Y_Start = 258;
    parameter [9:0] Ladder_2_Y_End = 350;
    parameter [9:0] Ladder_3_X_Start = 500;
    parameter [9:0] Ladder_3_X_End = 520;
    parameter [9:0] Ladder_3_Y_Start = 358;
    parameter [9:0] Ladder_3_Y_End = 472;
    
    parameter [9:0] JumpSX = 16;  // default Jump size
    parameter [9:0] JumpSY = 32;  // default Jump size'
    
    logic climbing;
    
   
    always_ff @ (posedge frame_clk or posedge Reset) //make sure the frame clock is instantiated correctly
    begin: Move_Jump
        if (Reset)  // asynchronous Reset
        begin 
            jumping <= 8'h00;
            climbing <= 1'b0;
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
			               
//				if ( (JumpY + JumpSY) >= Jump_Y_Max )  // Jump is at the bottom edge, BOUNCE!
//					  Jump_Y_Motion <= 1'b0;  // 2's complement.
					  
//				else if ( (JumpY) <= Jump_Y_Min )  // Jump is at the top edge, BOUNCE!
//					  Jump_Y_Motion <= 1'b0;
					  
//				else if ( (JumpX + JumpSY) >= Jump_X_Max )  // Jump is at the Right edge, BOUNCE!
//					  Jump_X_Motion <= 1'b0;  // 2's complement.
					  
//				else 
	 			   Jump_Y_Motion <= Jump_Y_Step;  // Jump is somewhere in the middle, don't bounce, just keep moving
					  
				 //modify to control Jump motion with the keycode
				if ((keycode0 == 8'h04 || keycode1 == 8'h04) && climbing == 0)//A
                    Jump_X_Motion <= -Jump_X_Step;
                if ((keycode0 == 8'h07 || keycode1 == 8'h07) && climbing == 0)//D
                    Jump_X_Motion <= Jump_X_Step;
                    
                if (keycode0 == 8'h16 || keycode1 == 8'h16)//S
                begin
                    if(JumpX + JumpSX > Ladder_1_X_Start && JumpX < Ladder_1_X_End && JumpY + JumpSY > Ladder_1_Y_Start - 4 && JumpY < Ladder_1_Y_End)
                    begin
                        climbing = 1'b1;
                        Jump_Y_Motion <= Jump_Y_Step;
                        Jump_X_Motion <= 0;
                    end
                    if(JumpX + JumpSX > Ladder_2_X_Start && JumpX < Ladder_2_X_End && JumpY + JumpSY > Ladder_2_Y_Start - 4 && JumpY < Ladder_2_Y_End)
                    begin
                        climbing = 1'b1;
                        Jump_Y_Motion <= Jump_Y_Step;
                        Jump_X_Motion <= 0;
                    end
                    if(JumpX + JumpSX > Ladder_3_X_Start && JumpX < Ladder_3_X_End && JumpY + JumpSY > Ladder_3_Y_Start - 4 && JumpY < Ladder_3_Y_End)
                    begin
                        climbing = 1'b1;
                        Jump_Y_Motion <= Jump_Y_Step;
                        Jump_X_Motion <= 0;
                    end
                end
                if (keycode0 == 8'h1A || keycode1 == 8'h1A)//W
                begin
                    if(JumpX + JumpSX > Ladder_1_X_Start && JumpX < Ladder_1_X_End && JumpY + JumpSY > Ladder_1_Y_Start - 4 && JumpY < Ladder_1_Y_End)
                    begin
                        climbing = 1'b1;
                        Jump_Y_Motion <= -Jump_Y_Step;
                        Jump_X_Motion <= 0;
                    end
                    if(JumpX + JumpSX > Ladder_2_X_Start && JumpX < Ladder_2_X_End && JumpY + JumpSY > Ladder_2_Y_Start - 4 && JumpY < Ladder_2_Y_End)
                    begin
                        climbing = 1'b1;
                        Jump_Y_Motion <= -Jump_Y_Step;
                        Jump_X_Motion <= 0;
                    end
                    if(JumpX + JumpSX > Ladder_3_X_Start && JumpX < Ladder_3_X_End && JumpY + JumpSY > Ladder_3_Y_Start - 4 && JumpY < Ladder_3_Y_End)
                    begin
                        climbing = 1'b1;
                        Jump_Y_Motion <= -Jump_Y_Step;
                        Jump_X_Motion <= 0;
                    end
                end
                if ((keycode0 == 8'h2C || keycode1 == 8'h2C) && jumping <= 8'h10)//spc
                begin
                    jumping <= jumping + 1;
                    Jump_Y_Motion <= -Jump_Y_Jump;
                end
                
                if (keycode0 != 8'h04 && keycode0 != 8'h07 && keycode0 != 8'h16 && keycode0 != 8'h1A && keycode0 != 8'h2C &&
                    keycode1 != 8'h04 && keycode1 != 8'h07 && keycode1 != 8'h16 && keycode1 != 8'h1A && keycode1 != 8'h2C)
                begin
				    Jump_Y_Motion <= Jump_Y_Jump;
				    Jump_X_Motion <= 0;
				end  
			
			    if (jumping != 0 && keycode0 != 8'h2C && keycode1 != 8'h2C)
			        jumping = 8'h00;
			    if (climbing != 0 && keycode0 != 8'h1A && keycode1 != 8'h1A && keycode0 != 8'h16 && keycode1 != 8'h16)
			        climbing = 8'h00;
                
//				case (keycode)
//					8'h04 :  //A
//					begin
//					   if (JumpX >= Jump_X_Min)
//					       Jump_X_Motion <= -Jump_X_Step;//A
//					end        
//					8'h07 :  //D
//					begin
//					   if ( (JumpX + JumpSX) <= Jump_X_Max)
//					       Jump_X_Motion <= Jump_X_Step;//D
//					end
							  
//					8'h16 :  //S
//					begin
//					   Jump_Y_Motion <= Jump_Y_Step;
//					end		  
					
//					8'h1A :  //W
//					begin
//					   Jump_Y_Motion <= -Jump_Y_Step;
//					end
					   
//				    8'h2C :  //spc
//				    begin
//					   Jump_Y_Motion <= -Jump_Y_Step;
//                    end
                    
							 	  
//					default: 
//					begin
//					   Jump_Y_Motion <= Jump_Y_Step;
//					   Jump_X_Motion <= 0;
//					end
//			   endcase
               if ((JumpY + Jump_Y_Motion + JumpSY > Jump_Y_Max))
		          JumpY <= JumpY;  // Update Jump position
		        
		       //make sure not on a platform
		       else if ( (JumpY + Jump_Y_Motion + JumpSY >= Box_3_Y) && (JumpY + Jump_Y_Motion + JumpSY < Box_3_Y + 8) && (JumpX <= Box_3_X_End))
		          JumpY <= JumpY;
		       else if ( (JumpY + Jump_Y_Motion + JumpSY >= Box_2_Y) && (JumpY + Jump_Y_Motion + JumpSY < Box_2_Y + 8) && (JumpX + JumpSX >= Box_2_X_Start))
		          JumpY <= JumpY;
		       else if ( (JumpY + Jump_Y_Motion + JumpSY >= Box_1_Y) && (JumpY + Jump_Y_Motion + JumpSY < Box_1_Y + 8) && (JumpX <= Box_1_X_End))
		          JumpY <= JumpY;
		       else
		          JumpY <= (JumpY + Jump_Y_Motion);
		          
               if ((JumpX + Jump_X_Motion + JumpSX < Jump_X_Max) && (JumpX + Jump_X_Motion > Jump_X_Min))
		          JumpX <= (JumpX + Jump_X_Motion);  // Update Jump position
			   else
		          JumpX <= JumpX;
		end  
    end
      
endmodule