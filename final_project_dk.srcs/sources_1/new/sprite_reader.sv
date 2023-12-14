`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2023 12:33:20 PM
// Design Name: 
// Module Name: sprite_reader.sv
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

/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module  barrel_0_sprite
(
        input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [7:0] memr [0:479];
logic [7:0] memg [0:479];
logic [7:0] memb [0:479];

initial
begin
	 $readmemh("barrel_r.mem", memr);
	 $readmemh("barrel_g.mem", memg);
	 $readmemh("barrel_b.mem", memb);
end


always_ff @ (posedge Clk) begin
    if(read_address >= 19'd0 && read_address <= 19'd479)
    begin
	   data_Out[7:0] <= memr[read_address];
	   data_Out[15:8] <= memg[read_address];
	   data_Out[23:16] <= memb[read_address];
	end
	else
	   data_Out <= 24'b000;
end

endmodule



module  barrel_2_sprite
(
        input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [7:0] memr [0:479];
logic [7:0] memg [0:479];
logic [7:0] memb [0:479];

initial
begin
	 $readmemh("barrel2r.mem", memr);
	 $readmemh("barrel2g.mem", memg);
	 $readmemh("barrel2b.mem", memb);
end


always_ff @ (posedge Clk) begin
    if(read_address >= 19'd0 && read_address <= 19'd479)
    begin
	   data_Out[7:0] <= memr[read_address];
	   data_Out[15:8] <= memg[read_address];
	   data_Out[23:16] <= memb[read_address];
	end
	else
	   data_Out <= 24'b000;
end

endmodule


module  dk_sprite
(
        input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [7:0] memr [0:5119];
logic [7:0] memg [0:5119];
logic [7:0] memb [0:5119];

initial
begin
	 $readmemh("donkey_kongR.mem", memr);
	 $readmemh("donkey_kongG.mem", memg);
	 $readmemh("donkey_kongB.mem", memb);
end


always_ff @ (posedge Clk) begin
    if(read_address >= 19'd0 && read_address <= 19'd5119)
    begin
	   data_Out[7:0] <= memr[read_address];
	   data_Out[15:8] <= memg[read_address];
	   data_Out[23:16] <= memb[read_address];
	end
	else
	   data_Out <= 24'b000;
end

endmodule

module  start_text_sprite
(
        input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [7:0] memr [0:8959];
logic [7:0] memg [0:8959];
logic [7:0] memb [0:8959];

initial
begin
	 $readmemh("start_menuR.mem", memr);
	 $readmemh("start_menuG.mem", memg);
	 $readmemh("start_menuB.mem", memb);
end


always_ff @ (posedge Clk) begin
    if(read_address >= 19'd0 && read_address <= 19'd8959)
    begin
	   data_Out[7:0] <= memr[read_address];
	   data_Out[15:8] <= memg[read_address];
	   data_Out[23:16] <= memb[read_address];
	end
	else
	   data_Out <= 24'b000;
end

endmodule

module  game_text_sprite
(
        input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [7:0] memr [0:8959];
logic [7:0] memg [0:8959];
logic [7:0] memb [0:8959];

initial
begin
	 $readmemh("game_menuR.mem", memr);
	 $readmemh("game_menuG.mem", memg);
	 $readmemh("game_menuB.mem", memb);
end


always_ff @ (posedge Clk) begin
    if(read_address >= 19'd0 && read_address <= 19'd8959)
    begin
	   data_Out[7:0] <= memr[read_address];
	   data_Out[15:8] <= memg[read_address];
	   data_Out[23:16] <= memb[read_address];
	end
	else
	   data_Out <= 24'b000;
end

endmodule

module  end_text_sprite
(
        input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [7:0] memr [0:8959];
logic [7:0] memg [0:8959];
logic [7:0] memb [0:8959];

initial
begin
	 $readmemh("end_menuR.mem", memr);
	 $readmemh("end_menuG.mem", memg);
	 $readmemh("end_menuB.mem", memb);
end


always_ff @ (posedge Clk) begin
    if(read_address >= 19'd0 && read_address <= 19'd8959)
    begin
	   data_Out[7:0] <= memr[read_address];
	   data_Out[15:8] <= memg[read_address];
	   data_Out[23:16] <= memb[read_address];
	end
	else
	   data_Out <= 24'b000;
end

endmodule

module  win_text_sprite
(
        input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [7:0] memr [0:8959];
logic [7:0] memg [0:8959];
logic [7:0] memb [0:8959];

initial
begin
	 $readmemh("win_menuR.mem", memr);
	 $readmemh("win_menuG.mem", memg);
	 $readmemh("win_menuB.mem", memb);
end


always_ff @ (posedge Clk) begin
    if(read_address >= 19'd0 && read_address <= 19'd8959)
    begin
	   data_Out[7:0] <= memr[read_address];
	   data_Out[15:8] <= memg[read_address];
	   data_Out[23:16] <= memb[read_address];
	end
	else
	   data_Out <= 24'b000;
end

endmodule



module  princess_sprite
(
        input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [7:0] memr [0:1319];
logic [7:0] memg [0:1319];
logic [7:0] memb [0:1319];

initial
begin
	 $readmemh("princessR.mem", memr);
	 $readmemh("princessG.mem", memg);
	 $readmemh("princessB.mem", memb);
end


always_ff @ (posedge Clk) begin
    if(read_address >= 19'd0 && read_address <= 19'd1319)
    begin
	   data_Out[7:0] <= memr[read_address];
	   data_Out[15:8] <= memg[read_address];
	   data_Out[23:16] <= memb[read_address];
	end
	else
	   data_Out <= 24'b000;
end

endmodule


module  digit_text_sprite
(
        input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [7:0] memr [0:1087];
logic [7:0] memg [0:1087];
logic [7:0] memb [0:1087];

initial
begin
	 $readmemh("digitsR.mem", memr);
	 $readmemh("digitsG.mem", memg);
	 $readmemh("digitsB.mem", memb);
end


always_ff @ (posedge Clk) begin
    if(read_address >= 19'd0 && read_address <= 19'd1087)
    begin
	   data_Out[7:0] <= memr[read_address];
	   data_Out[15:8] <= memg[read_address];
	   data_Out[23:16] <= memb[read_address];
	end
	else
	   data_Out <= 24'b000;
end

endmodule


module  mario_jump_sprite
(
        input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [7:0] memr [0:959];
logic [7:0] memg [0:959];
logic [7:0] memb [0:959];

initial
begin
	 $readmemh("mariojumpR.mem", memr);
	 $readmemh("mariojumpG.mem", memg);
	 $readmemh("mariojumpB.mem", memb);
end


always_ff @ (posedge Clk) begin
    if(read_address >= 19'd0 && read_address <= 19'd959)
    begin
	   data_Out[7:0] <= memr[read_address];
	   data_Out[15:8] <= memg[read_address];
	   data_Out[23:16] <= memb[read_address];
	end
	else
	   data_Out <= 24'b000;
end

endmodule


module  mario_idle_sprite
(
        input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [7:0] memr [0:767];
logic [7:0] memg [0:767];
logic [7:0] memb [0:767];

initial
begin
	 $readmemh("marioidleR.mem", memr);
	 $readmemh("marioidleG.mem", memg);
	 $readmemh("marioidleB.mem", memb);
end


always_ff @ (posedge Clk) begin
    if(read_address >= 19'd0 && read_address <= 19'd767)
    begin
	   data_Out[7:0] <= memr[read_address];
	   data_Out[15:8] <= memg[read_address];
	   data_Out[23:16] <= memb[read_address];
	end
	else
	   data_Out <= 24'b000;
end

endmodule


module  mario_climb_sprite
(
        input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [7:0] memr [0:831];
logic [7:0] memg [0:831];
logic [7:0] memb [0:831];

initial
begin
	 $readmemh("marioclimbR.mem", memr);
	 $readmemh("marioclimbG.mem", memg);
	 $readmemh("marioclimbB.mem", memb);
end


always_ff @ (posedge Clk) begin
    if(read_address >= 19'd0 && read_address <= 19'd831)
    begin
	   data_Out[7:0] <= memr[read_address];
	   data_Out[15:8] <= memg[read_address];
	   data_Out[23:16] <= memb[read_address];
	end
	else
	   data_Out <= 24'b000;
end

endmodule


module  mario_run1_sprite
(
        input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [7:0] memr [0:959];
logic [7:0] memg [0:959];
logic [7:0] memb [0:959];

initial
begin
	 $readmemh("mariorun1R.mem", memr);
	 $readmemh("mariorun1G.mem", memg);
	 $readmemh("mariorun1B.mem", memb);
end


always_ff @ (posedge Clk) begin
    if(read_address >= 19'd0 && read_address <= 19'd959)
    begin
	   data_Out[7:0] <= memr[read_address];
	   data_Out[15:8] <= memg[read_address];
	   data_Out[23:16] <= memb[read_address];
	end
	else
	   data_Out <= 24'b000;
end

endmodule

module  mario_run2_sprite
(
        input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [7:0] memr [0:899];
logic [7:0] memg [0:899];
logic [7:0] memb [0:899];

initial
begin
	 $readmemh("mariorun2R.mem", memr);
	 $readmemh("mariorun2G.mem", memg);
	 $readmemh("mariorun2B.mem", memb);
end


always_ff @ (posedge Clk) begin
    if(read_address >= 19'd0 && read_address <= 19'd899)
    begin
	   data_Out[7:0] <= memr[read_address];
	   data_Out[15:8] <= memg[read_address];
	   data_Out[23:16] <= memb[read_address];
	end
	else
	   data_Out <= 24'b000;
end

endmodule