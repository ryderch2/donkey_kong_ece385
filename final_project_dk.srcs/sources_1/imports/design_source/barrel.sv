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
               output logic [9:0]  BarrelX, BarrelY, BarrelS );
    
    logic [9:0] Barrel_X_Motion, Barrel_Y_Motion;
	 
    parameter [9:0] Barrel_X_Center=50;  // Center position on the X axis
    parameter [9:0] Barrel_Y_Center=100;  // Center position on the Y axis
    parameter [9:0] Barrel_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Barrel_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Barrel_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Barrel_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Barrel_X_Step=2;      // Step size on the X axis
    parameter [9:0] Barrel_Y_Step=1;      // Step size on the Y axis

    assign BarrelS = 8;  // default Barrel size
   
    always_ff @ (posedge frame_clk or posedge Reset) //make sure the frame clock is instantiated correctly
    begin: Move_Barrel
        if (Reset)  // asynchronous Reset
        begin 
            Barrel_Y_Motion <= -10'd1; //Barrel_Y_Step;
			Barrel_X_Motion <= 10'd0; //Barrel_X_Step;
			BarrelY <= Barrel_Y_Center;
			BarrelX <= Barrel_X_Center;
        end
           
        else 
        begin 
                if ( (BarrelY + BarrelS) <= 200 && (BarrelY + BarrelS) >= 150  && (BarrelX + BarrelS) <= 488)
                begin
                    Barrel_Y_Motion <= 10'd0;
                    Barrel_X_Motion <= Barrel_X_Step;
                end
                
                else if ( (BarrelX + BarrelS) >= 488 && (BarrelY + BarrelS) <= 300)
                begin
                    Barrel_Y_Motion <= Barrel_Y_Step;
                    Barrel_X_Motion <= 1'b0;
                end
                
                else if ( (BarrelY + BarrelS) <= 350 && (BarrelY + BarrelS) >= 300 && (BarrelX + BarrelS) <= 152)
                begin
                    Barrel_Y_Motion <= 10'd0;
                    Barrel_X_Motion <= (~ (Barrel_X_Step) + 1'b1); 
                end
                
                else if ( (BarrelX + BarrelS) <= 152 && (BarrelY + BarrelS) <= Barrel_Y_Max)
                begin
                    Barrel_Y_Motion <= Barrel_Y_Step;
                    Barrel_X_Motion <= 1'b0;
                end     
                           
				else if ( (BarrelY + BarrelS) >= Barrel_Y_Max )  // Barrel is at the bottom edge, BOUNCE!
				begin
					  Barrel_Y_Motion <= 1'b0;  // 2's complement.
                      Barrel_X_Motion <= Barrel_X_Step;
				end	  
					  
					  
					  
				else if ( (BarrelY - BarrelS) <= Barrel_Y_Min )  // Barrel is at the top edge, BOUNCE!
					  Barrel_Y_Motion <= Barrel_Y_Step;
					  
				else if ( (BarrelX + BarrelS) >= Barrel_X_Max )  // Barrel is at the Right edge, BOUNCE!
					  Barrel_X_Motion <= (~ (Barrel_X_Step) + 1'b1);  // 2's complement.
					  
				else if ( (BarrelX - BarrelS) <= Barrel_X_Min )  // Barrel is at the Left edge, BOUNCE!
					  Barrel_X_Motion <= Barrel_X_Step;
					  
				 else 
				 begin
	 			      Barrel_Y_Motion <= Barrel_Y_Motion;  // Barrel is somewhere in the middle, don't bounce, just keep moving
	 			      Barrel_X_Motion <= Barrel_X_Motion;  // Barrel is somewhere in the middle, don't bounce, just keep moving
				 end	  
//				 //modify to control Barrel motion with the keycode
//				 if (keycode == 8'h1A)
//                     Barrel_Y_Motion <= -10'd1;
				 
				 BarrelY <= (BarrelY + Barrel_Y_Motion);  // Update Barrel position
				 BarrelX <= (BarrelX + Barrel_X_Motion);
			
		end  
    end
      
endmodule
