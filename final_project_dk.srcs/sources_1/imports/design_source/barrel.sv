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


module  barrel #(parameter Delay = 0)
                    
             ( input logic Reset, frame_clk,
			   input logic [7:0] keycode,
               output logic [9:0]  BarrelX, BarrelY, BarrelS,
               output logic BarrelState );
    
    logic [9:0] Barrel_X_Motion, Barrel_Y_Motion;
	 
    localparam [9:0] Barrel_X_Center=60;  // Center position on the X axis
    localparam [9:0] Barrel_Y_Center=100;  // Center position on the Y axis
    localparam [9:0] Barrel_X_Min=0;       // Leftmost point on the X axis
    localparam [9:0] Barrel_X_Max=639;     // Rightmost point on the X axis
    localparam [9:0] Barrel_Y_Min=0;       // Topmost point on the Y axis
    localparam [9:0] Barrel_Y_Max=471;     // Bottommost point on the Y axis
    localparam [9:0] Barrel_X_Step=3;      // Step size on the X axis
    localparam [9:0] Barrel_Y_Step=3;      // Step size on the Y axis
    localparam [9:0] Box_1_X_Start = 0;
    localparam [9:0] Box_1_X_End = 480;
    localparam [9:0] Box_1_Y = 146;
    localparam [9:0] Box_2_X_Start = 160;
    localparam [9:0] Box_2_X_End = 640;
    localparam [9:0] Box_2_Y = 246;
    localparam [9:0] Box_3_X_Start = 20;
    localparam [9:0] Box_3_X_End = 560;
    localparam [9:0] Box_3_Y = 346;
    localparam [9:0] Ladder_1_X_Start = 440;
    localparam [9:0] Ladder_1_X_End = 460;
    localparam [9:0] Ladder_1_Y_Start = 158;
    localparam [9:0] Ladder_1_Y_End = 250;
    localparam [9:0] Ladder_2_X_Start = 200;
    localparam [9:0] Ladder_2_X_End = 220;
    localparam [9:0] Ladder_2_Y_Start = 258;
    localparam [9:0] Ladder_2_Y_End = 350;
    localparam [9:0] Ladder_3_X_Start = 440;
    localparam [9:0] Ladder_3_X_End = 460;
    localparam [9:0] Ladder_3_Y_Start = 358;
    localparam [9:0] Ladder_3_Y_End = 472;
    

    assign BarrelS = 12;  // default Barrel size
    
    assign direction = 1;
    logic [3:0] counter;
    int barrel_delay;
   
    always_ff @ (posedge frame_clk or posedge Reset) //make sure the frame clock is instantiated correctly
    begin: Move_Barrel
        if (Reset)  // asynchronous Reset
        begin 
            barrel_delay <= Delay;
            BarrelState <= 1'b0;
            counter <= 4'h0;
            Barrel_Y_Motion <= -10'd1; //Barrel_Y_Step;
			Barrel_X_Motion <= 10'd0; //Barrel_X_Step;
			BarrelY <= Barrel_Y_Center;
			BarrelX <= Barrel_X_Center;
        end
        
        else if (barrel_delay > 0)
            barrel_delay <= barrel_delay - 1;
        
           
        else 
        begin 
            if(counter >= 4'h8)
            begin
                BarrelState <= ~(BarrelState);
                counter <= 4'h0;
            end
            else
                counter <= counter + 1;
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
					  //Barrel_X_Motion <= Barrel_X_Step;
					  //BarrelOn <= 0;
                      //Barrel_Y_Motion <= -10'd1; //Barrel_Y_Step;
                      //Barrel_X_Motion <= 10'd0; //Barrel_X_Step;
                      //BarrelY <= Barrel_Y_Center;
                      //BarrelX <= Barrel_X_Center;
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
				 if((BarrelX - BarrelS) >= Barrel_X_Min && (BarrelX + BarrelS) < Barrel_X_Max)
				 begin
				    BarrelY <= (BarrelY + Barrel_Y_Motion);  // Update Barrel position
				    BarrelX <= (BarrelX + Barrel_X_Motion);
				 end
				 else
				 begin
				    Barrel_Y_Motion <= -10'd1; //Barrel_Y_Step;
                    Barrel_X_Motion <= 10'd0; //Barrel_X_Step;
                    BarrelY <= Barrel_Y_Center;
                    BarrelX <= Barrel_X_Center;
                 end
			
		end  
    end
      
endmodule
