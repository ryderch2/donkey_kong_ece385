//-------------------------------------------------------------------------
//    Barrel.sv                                                            --
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


module  barrel ( input logic Reset, frame_clk,
			   input logic [7:0] keycode,
               output logic [9:0]  BarrelX, BarrelY, BarrelS,
               output logic BarrelOn );
    
    logic [9:0] Barrel_X_Motion, Barrel_Y_Motion;
	 
    parameter [9:0] Barrel_X_Center=50;  // Center position on the X axis
    parameter [9:0] Barrel_Y_Center=50;  // Center position on the Y axis
    parameter [9:0] Barrel_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Barrel_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Barrel_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Barrel_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Barrel_X_Step=2;      // Step size on the X axis
    parameter [9:0] Barrel_Y_Step=1;      // Step size on the Y axis
    parameter [9:0] Box_1_X_Start = 0;
    parameter [9:0] Box_1_X_End = 480;
    parameter [9:0] Box_1_Y = 100;
    parameter [9:0] Box_2_X_Start = 160;
    parameter [9:0] Box_2_X_End = 640;
    parameter [9:0] Box_2_Y = 200;
    parameter [9:0] Box_3_X_Start = 160;
    parameter [9:0] Box_3_X_End = 480;
    parameter [9:0] Box_3_Y = 300;
    

    assign BarrelS = 8;  // default Barrel size
    
    assign direction = 1;
   
    always_ff @ (posedge frame_clk or posedge Reset) //make sure the frame clock is instantiated correctly
    begin: Move_Barrel
        if (Reset)  // asynchronous Reset
        begin 
            BarrelOn <= 1'b1;
            Barrel_Y_Motion <= -10'd1; //Barrel_Y_Step;
			Barrel_X_Motion <= 10'd0; //Barrel_X_Step;
			BarrelY <= Barrel_Y_Center;
			BarrelX <= Barrel_X_Center;
        end
           
        else 
        begin 
//                if ( (BarrelY + BarrelS) <= 200 && (BarrelY + BarrelS) >= 150  && (BarrelX + BarrelS) <= 488)
//                begin
//                    Barrel_Y_Motion <= 10'd0;
//                    Barrel_X_Motion <= Barrel_X_Step;
//                end
                
//                else if ( (BarrelX + BarrelS) >= 488 && (BarrelY + BarrelS) <= 300)
//                begin
//                    Barrel_Y_Motion <= Barrel_Y_Step;
//                    Barrel_X_Motion <= 1'b0;
//                end
                
//                else if ( (BarrelY + BarrelS) <= 350 && (BarrelY + BarrelS) >= 300 && (BarrelX + BarrelS) <= 152)
//                begin
//                    Barrel_Y_Motion <= 10'd0;
//                    Barrel_X_Motion <= (~ (Barrel_X_Step) + 1'b1); 
//                end
                
//                else if ( (BarrelX + BarrelS) <= 152 && (BarrelY + BarrelS) <= Barrel_Y_Max)
//                begin
//                    Barrel_Y_Motion <= Barrel_Y_Step;
//                    Barrel_X_Motion <= 1'b0;
//                end 
                if ( (BarrelY + BarrelS) >= Box_1_Y && (BarrelY + BarrelS) <= (Box_1_Y + 20) && (BarrelX - BarrelS) <= Box_1_X_End)
                begin
                    Barrel_Y_Motion <= 1'b0;
                    Barrel_X_Motion <= Barrel_X_Step;
                end
                  
                else if ( (BarrelY + BarrelS) >= Box_2_Y && (BarrelY + BarrelS) <= (Box_2_Y + 20) && (BarrelX + BarrelS) >= Box_2_X_Start)
                begin
                    Barrel_Y_Motion <= 1'b0;
                    Barrel_X_Motion <= (~ (Barrel_X_Step) + 1'b1);
                end 
                 
                else if ( (BarrelY + BarrelS) >= Box_3_Y && (BarrelY + BarrelS) <= (Box_3_Y + 20) && (BarrelX - BarrelS) <= Box_3_X_End)
                begin
                    Barrel_Y_Motion <= 1'b0;
                    Barrel_X_Motion <= Barrel_X_Step;
                end 
                
                else if ( (BarrelX - BarrelS) <= Barrel_X_Min )  // Barrel is at the Left edge, BOUNCE!
				begin
					  Barrel_X_Motion <= Barrel_X_Step;
					  BarrelOn <= 0;
			    end
			               
				else if ( (BarrelY + BarrelS) >= Barrel_Y_Max )  // Barrel is at the bottom edge, BOUNCE!
				begin
					  Barrel_Y_Motion <= 1'b0;  // 2's complement.
                      Barrel_X_Motion <= (~ (Barrel_X_Step) + 1'b1);
				end
					  
				else if ( (BarrelY - BarrelS) <= Barrel_Y_Min )  // Barrel is at the top edge, BOUNCE!
					  Barrel_Y_Motion <= Barrel_Y_Step;
					  
				else if ( (BarrelX + BarrelS) >= Barrel_X_Max )  // Barrel is at the Right edge, BOUNCE!
					  Barrel_X_Motion <= (~ (Barrel_X_Step) + 1'b1);  // 2's complement.
					  
				
					  
				else 
				begin
	 			     Barrel_Y_Motion <= Barrel_Y_Step;  // Barrel is somewhere in the middle, don't bounce, just keep moving
	 			     Barrel_X_Motion <= 1'b0;  // Barrel is somewhere in the middle, don't bounce, just keep moving
				end	  
//				 //modify to control Barrel motion with the keycode
//				 if (keycode == 8'h1A)
//                     Barrel_Y_Motion <= -10'd1;
				 
				 BarrelY <= (BarrelY + Barrel_Y_Motion);  // Update Barrel position
				 BarrelX <= (BarrelX + Barrel_X_Motion);
			
		end  
    end
      
endmodule
