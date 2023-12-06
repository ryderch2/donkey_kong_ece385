`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2023 12:33:20 PM
// Design Name: 
// Module Name: barrelg
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

module  barrelg
(
        input [18:0] read_address,
		input Clk,

		output logic [7:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [7:0] mem [0:239];

initial
begin
	 $readmemh("sprites/barrel.mem", mem);
end


always_ff @ (posedge Clk) begin
    if(read_address >= 19'd0 && read_address <= 19'd239)
	   data_Out<= mem[read_address];
	else
	   data_Out <= 8'b0;
end

endmodule