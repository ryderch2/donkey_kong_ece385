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
               output logic Jumping, Direction, Climbing, Frame, Running, SavePrincess);
    
    logic [9:0] Jump_X_Motion, Jump_Y_Motion;
	 
    parameter [9:0] Jump_X_Center=50;  // Center position on the X axis
    parameter [9:0] Jump_Y_Center=442;  // Center position on the Y axis
    parameter [9:0] Jump_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Jump_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Jump_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Jump_Y_Max=474;     // Bottommost point on the Y axis
    parameter [9:0] Jump_X_Step=1;      // Step size on the X axis
    parameter [9:0] Jump_Y_Step=1;      // Step size on the Y axis
    parameter [9:0] Jump_Y_Jump=2;
    parameter [9:0] Box_1_X_Start = 0;
    parameter [9:0] Box_1_X_End = 480;
    parameter [9:0] Box_1_Y = 151;
    parameter [9:0] Box_2_X_Start = 160;
    parameter [9:0] Box_2_X_End = 640;
    parameter [9:0] Box_2_Y = 251;
    parameter [9:0] Box_3_X_Start = 20;
    parameter [9:0] Box_3_X_End = 560;
    parameter [9:0] Box_3_Y = 351;
    
    parameter [9:0] Ladder_1_X_Start = 440;
    parameter [9:0] Ladder_1_X_End = 460;
    parameter [9:0] Ladder_1_Y_Start = 147;
    parameter [9:0] Ladder_1_Y_End = 250;
    parameter [9:0] Ladder_2_X_Start = 200;
    parameter [9:0] Ladder_2_X_End = 220;
    parameter [9:0] Ladder_2_Y_Start = 247;
    parameter [9:0] Ladder_2_Y_End = 350;
    parameter [9:0] Ladder_3_X_Start = 500;
    parameter [9:0] Ladder_3_X_End = 520;
    parameter [9:0] Ladder_3_Y_Start = 347;
    parameter [9:0] Ladder_3_Y_End = 472;
    
    parameter [9:0] princess_X_start = 90;
    parameter [9:0] princess_X_end = 120;
    parameter [9:0] princess_Y_start = 106;
    parameter [9:0] princess_Y_end = 150;
    
    parameter [9:0] JumpSX = 16;  // default Jump size
    parameter [9:0] JumpSY = 32;  // default Jump size'
    
    logic [7:0] jumping;
    logic [3:0] counter;
    logic in_air;
    
   
    always_ff @ (posedge frame_clk or posedge Reset) //make sure the frame clock is instantiated correctly
    begin: Move_Jump
        if (Reset)  // asynchronous Reset
        begin 
            in_air <= 1'b0;
            SavePrincess <= 1'b0;
            jumping <= 8'h00;
            Climbing <= 1'b0;
            Running <= 1'b0;
            Direction <= 1'b1;
            Frame <= 1'b0;
            Jump_Y_Motion <= 10'd0; //Jump_Y_Step;
			Jump_X_Motion <= 10'd0; //Jump_X_Step;
			JumpY <= Jump_Y_Center;
			JumpX <= Jump_X_Center;
        end
           
        else 
        begin 
        
                if(JumpX + JumpSX > princess_X_start && JumpX < princess_X_end && JumpY + JumpSY > princess_Y_start - 4 && JumpY < princess_Y_end)
                begin
                    SavePrincess <= 1'b1;
                end
	 			Jump_Y_Motion <= Jump_Y_Step;  // Jump is somewhere in the middle, don't bounce, just keep moving\
	 			if (counter == 4'h4)
	 			begin
	 			   Frame <= ~(Frame);
	 			   counter <= 0;
	 			end
	 			counter <= counter + 1;
					  
				 //modify to control Jump motion with the keycode
				if ((keycode0 == 8'h04 || keycode1 == 8'h04) && Climbing == 0)//A
				begin
				    Direction <= 0;
                    Jump_X_Motion <= -Jump_X_Step;
                end
                if ((keycode0 == 8'h07 || keycode1 == 8'h07) && Climbing == 0)//D
                begin
                	Direction <= 1;
                    Jump_X_Motion <= Jump_X_Step;
                end
                    
                if (keycode0 == 8'h16 || keycode1 == 8'h16)//S
                begin
                    if(JumpX + JumpSX > Ladder_1_X_Start && JumpX < Ladder_1_X_End && JumpY + JumpSY > Ladder_1_Y_Start - 4 && JumpY < Ladder_1_Y_End)
                    begin
                        Climbing = 1'b1;
                        Jump_Y_Motion <= Jump_Y_Step;
                        Jump_X_Motion <= 0;
                    end
                    if(JumpX + JumpSX > Ladder_2_X_Start && JumpX < Ladder_2_X_End && JumpY + JumpSY > Ladder_2_Y_Start - 4 && JumpY < Ladder_2_Y_End)
                    begin
                        Climbing = 1'b1;
                        Jump_Y_Motion <= Jump_Y_Step;
                        Jump_X_Motion <= 0;
                    end
                    if(JumpX + JumpSX > Ladder_3_X_Start && JumpX < Ladder_3_X_End && JumpY + JumpSY > Ladder_3_Y_Start - 4 && JumpY < Ladder_3_Y_End)
                    begin
                        Climbing = 1'b1;
                        Jump_Y_Motion <= Jump_Y_Step;
                        Jump_X_Motion <= 0;
                    end
                end
                if (keycode0 == 8'h1A || keycode1 == 8'h1A)//W
                begin
                    if(JumpX + JumpSX > Ladder_1_X_Start && JumpX < Ladder_1_X_End && JumpY + JumpSY > Ladder_1_Y_Start - 4 && JumpY < Ladder_1_Y_End)
                    begin
                        Climbing = 1'b1;
                        Jump_Y_Motion <= -Jump_Y_Step;
                        Jump_X_Motion <= 0;
                    end
                    if(JumpX + JumpSX > Ladder_2_X_Start && JumpX < Ladder_2_X_End && JumpY + JumpSY > Ladder_2_Y_Start - 4 && JumpY < Ladder_2_Y_End)
                    begin
                        Climbing = 1'b1;
                        Jump_Y_Motion <= -Jump_Y_Step;
                        Jump_X_Motion <= 0;
                    end
                    if(JumpX + JumpSX > Ladder_3_X_Start && JumpX < Ladder_3_X_End && JumpY + JumpSY > Ladder_3_Y_Start - 4 && JumpY < Ladder_3_Y_End)
                    begin
                        Climbing = 1'b1;
                        Jump_Y_Motion <= -Jump_Y_Step;
                        Jump_X_Motion <= 0;
                    end
                end
                if ((keycode0 == 8'h2C || keycode1 == 8'h2C) && jumping <= 8'h10 && in_air == 1'b0)//spc
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
			    begin
			        jumping <= jumping - 1;
			    end
			    if (Climbing != 0 && keycode0 != 8'h1A && keycode1 != 8'h1A && keycode0 != 8'h16 && keycode1 != 8'h16)
			        Climbing <= 8'h00;
			       
                

               if ((JumpY + Jump_Y_Motion + JumpSY > Jump_Y_Max))
               begin
                  in_air <= 1'b0;
                  Jumping <= 0;
		          JumpY <= JumpY;  // Update Jump position
		          jumping <= 0;
		       end
		        
		       //make sure not on a platform
		       else if ( (JumpY + Jump_Y_Motion + JumpSY >= Box_3_Y) && (JumpY + Jump_Y_Motion + JumpSY < Box_3_Y + 8) && (JumpX <= Box_3_X_End))
		       begin
                  in_air <= 1'b0;
		       	  Jumping <= 0;
		          JumpY <= JumpY;
		          jumping <= 0;
               end
		       else if ( (JumpY + Jump_Y_Motion + JumpSY >= Box_2_Y) && (JumpY + Jump_Y_Motion + JumpSY < Box_2_Y + 8) && (JumpX + JumpSX >= Box_2_X_Start))
		       begin
                  in_air <= 1'b0;
		       	  Jumping <= 0;
		          JumpY <= JumpY;
		          jumping <= 0;
               end
		       else if ( (JumpY + Jump_Y_Motion + JumpSY >= Box_1_Y) && (JumpY + Jump_Y_Motion + JumpSY < Box_1_Y + 8) && (JumpX <= Box_1_X_End))
		       begin
                  in_air <= 1'b0;
		       	  Jumping <= 0;
		          JumpY <= JumpY;
		          jumping <= 0;
               end
		       else
		       begin
		          if((keycode0 != 8'h2C && keycode1 != 8'h2C))
                    in_air <= 1'b1;
		          Jumping <= 1;
		          JumpY <= (JumpY + Jump_Y_Motion);
		       end
		          
               if ((JumpX + Jump_X_Motion + JumpSX < Jump_X_Max) && (JumpX + Jump_X_Motion > Jump_X_Min))
		          JumpX <= (JumpX + Jump_X_Motion);  // Update Jump position
			   else
		          JumpX <= JumpX;
		         
		       if (Jump_X_Motion)
		          Running <= 1'b1;
		       else
		          Running <= 1'b0;
		end  
    end
      
endmodule