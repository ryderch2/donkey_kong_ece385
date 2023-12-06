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

module  barrel_sprite
(
        input [18:0] read_address,
		input Clk,

		output logic [23:0] data_Out
);

logic [7:0] memr [0:119];
logic [7:0] memg [0:119];
logic [7:0] memb [0:119];

initial
begin
	 $readmemh("barrel_r.mem", memr);
	 $readmemh("barrel_g.mem", memg);
	 $readmemh("barrel_b.mem", memb);
end


always_ff @ (posedge Clk) begin
    if(read_address >= 19'd0 && read_address <= 19'd119)
    begin
	   data_Out[7:0] <= memr[read_address];
	   data_Out[15:8] <= memg[read_address];
	   data_Out[23:16] <= memb[read_address];
	end
	else
	   data_Out <= 24'b000;
end

endmodule