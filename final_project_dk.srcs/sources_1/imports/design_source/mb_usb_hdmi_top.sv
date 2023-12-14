`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Zuofu Cheng
// 
// Create Date: 12/11/2022 10:48:49 AM
// Design Name: 
// Module Name: mb_usb_hdmi_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Top level for mb_lwusb test project, copy mb wrapper here from Verilog and modify
// to SV
// Dependencies: microblaze block design
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mb_usb_hdmi_top(
    input logic Clk,
    input logic reset_rtl_0,
    
    //USB signals
    input logic [0:0] gpio_usb_int_tri_i,
    output logic gpio_usb_rst_tri_o,
    input logic usb_spi_miso,
    output logic usb_spi_mosi,
    output logic usb_spi_sclk,
    output logic usb_spi_ss,
    
    //UART
    input logic uart_rtl_0_rxd,
    output logic uart_rtl_0_txd,
    
    //HDMI
    output logic hdmi_tmds_clk_n,
    output logic hdmi_tmds_clk_p,
    output logic [2:0]hdmi_tmds_data_n,
    output logic [2:0]hdmi_tmds_data_p,
        
    //HEX displays
    output logic [7:0] hex_segA,
    output logic [3:0] hex_gridA,
    output logic [7:0] hex_segB,
    output logic [3:0] hex_gridB
    );
    
    logic [31:0] keycode0_gpio, keycode1_gpio;
    logic clk_25MHz, clk_125MHz, clk, clk_100MHz;
    logic locked;
    logic [9:0] drawX, drawY, ballxsig, ballysig, ballsizesig, jumpxsig, jumpysig;
    logic [9:0] ball2xsig, ball2ysig;
    logic [9:0] ball3xsig, ball3ysig;
    logic [9:0] ball4xsig, ball4ysig;
    logic [9:0] ball5xsig, ball5ysig;
    logic [1:0] barrelOn, barrel2On, barrel3On, barrel4On, barrel5On;

    logic hsync, vsync, vde;
    logic [7:0] red, green, blue;
    logic reset_ah;
    logic coll0, coll2;
    
    logic jumping, direction, climbing, frame, running;
    
    logic [3:0] game_state;
    logic [1:0] lives;
    logic [7:0] Delay;
    logic reset_game, princess_grab;
    
    int timer10, timer1;
    
    assign reset_ah = reset_rtl_0;
    
    
    //Keycode HEX drivers
    HexDriver HexA (
        .clk(Clk),
        .reset(reset_ah),
        .in({game_state, {coll2, coll0, coll2, coll0}, Delay[7:4], Delay[3:0]}),
        .hex_seg(hex_segA),
        .hex_grid(hex_gridA)
    );
    
    HexDriver HexB (
        .clk(Clk),
        .reset(reset_ah),
        .in({keycode0_gpio[15:12], keycode0_gpio[11:8], keycode0_gpio[7:4], keycode0_gpio[3:0]}),
        .hex_seg(hex_segB),
        .hex_grid(hex_gridB)
    );
    
    mb_block mb_block_i(
        .clk_100MHz(Clk),
        .gpio_usb_int_tri_i(gpio_usb_int_tri_i),
        .gpio_usb_keycode_0_tri_o(keycode0_gpio),
        .gpio_usb_keycode_1_tri_o(keycode1_gpio),
        .gpio_usb_rst_tri_o(gpio_usb_rst_tri_o),
        .reset_rtl_0(~reset_ah), //Block designs expect active low reset, all other modules are active high
        .uart_rtl_0_rxd(uart_rtl_0_rxd),
        .uart_rtl_0_txd(uart_rtl_0_txd),
        .usb_spi_miso(usb_spi_miso),
        .usb_spi_mosi(usb_spi_mosi),
        .usb_spi_sclk(usb_spi_sclk),
        .usb_spi_ss(usb_spi_ss)
    );
        
    //clock wizard configured with a 1x and 5x clock for HDMI
    clk_wiz_0 clk_wiz (
        .clk_out1(clk_25MHz),
        .clk_out2(clk_125MHz),
        .reset(reset_ah),
        .locked(locked),
        .clk_in1(Clk)
    );
    
    //VGA Sync signal generator
    vga_controller vga (
        .pixel_clk(clk_25MHz),
        .reset(reset_ah),
        .hs(hsync),
        .vs(vsync),
        .active_nblank(vde),
        .drawX(drawX),
        .drawY(drawY)
    );    

    //Real Digital VGA to HDMI converter
    hdmi_tx_0 vga_to_hdmi (
        //Clocking and Reset
        .pix_clk(clk_25MHz),
        .pix_clkx5(clk_125MHz),
        .pix_clk_locked(locked),
        //Reset is active LOW
        .rst(reset_ah),
        //Color and Sync Signals
        .red(red),
        .green(green),
        .blue(blue),
        .hsync(hsync),
        .vsync(vsync),
        .vde(vde),
        
        //aux Data (unused)
        .aux0_din(4'b0),
        .aux1_din(4'b0),
        .aux2_din(4'b0),
        .ade(1'b0),
        
        //Differential outputs
        .TMDS_CLK_P(hdmi_tmds_clk_p),          
        .TMDS_CLK_N(hdmi_tmds_clk_n),          
        .TMDS_DATA_P(hdmi_tmds_data_p),         
        .TMDS_DATA_N(hdmi_tmds_data_n)          
    );

    dk_game game_instance(
        .Clk(vsync),
        .Reset(reset_ah),
        .collisions(coll0 | coll2 | coll3 | coll4 | coll5),
        .keycode(keycode0_gpio[7:0]),
        .game_state(game_state),
        .timer10(timer10),
        .timer1(timer1),
        .lives(lives),
        .reset_game(reset_game),
        .save_princess(princess_grab)
    );
    
    //Ball Module
    barrel barrel_instance(
        .Reset(reset_ah | reset_game),
        .frame_clk(vsync),                    //Figure out what this should be so that the ball will move
        .keycode(keycode0_gpio[7:0]),    //Notice: only one keycode connected to ball by default
        .BarrelX(ballxsig),
        .BarrelY(ballysig),
        .BarrelS(ballsizesig),
        .BarrelState(barrelOn)
    );
    
    barrel #(
        .Delay(30))
    barrel2_instance(
        .Reset(reset_ah | reset_game),
        .frame_clk(vsync),                    //Figure out what this should be so that the ball will move
        .keycode(keycode0_gpio[7:0]),    //Notice: only one keycode connected to ball by default
        .BarrelX(ball2xsig),
        .BarrelY(ball2ysig),
        .BarrelS(ballsizesig),
        .BarrelState(barrel2On)
    );
    
    barrel #(
        .Delay(100))
    barrel3_instance(
        .Reset(reset_ah | reset_game),
        .frame_clk(vsync),                    //Figure out what this should be so that the ball will move
        .keycode(keycode0_gpio[7:0]),    //Notice: only one keycode connected to ball by default
        .BarrelX(ball3xsig),
        .BarrelY(ball3ysig),
        .BarrelS(ballsizesig),
        .BarrelState(barrel3On)
    );
    
    barrel #(
        .Delay(200))
    barrel4_instance(
        .Reset(reset_ah | reset_game),
        .frame_clk(vsync),                    //Figure out what this should be so that the ball will move
        .keycode(keycode0_gpio[7:0]),    //Notice: only one keycode connected to ball by default
        .BarrelX(ball4xsig),
        .BarrelY(ball4ysig),
        .BarrelS(ballsizesig),
        .BarrelState(barrel4On)
    );
    
    barrel #(
        .Delay(500))
    barrel5_instance(
        .Reset(reset_ah | reset_game),
        .frame_clk(vsync),                    //Figure out what this should be so that the ball will move
        .keycode(keycode0_gpio[7:0]),    //Notice: only one keycode connected to ball by default
        .BarrelX(ball5xsig),
        .BarrelY(ball5ysig),
        .BarrelS(ballsizesig),
        .BarrelState(barrel5On)
    );
    
    //Ball Module
    jumpman jumpman_instance(
        .Reset(reset_ah | reset_game),
        .frame_clk(vsync),                    //Figure out what this should be so that the ball will move
        .keycode0(keycode0_gpio[7:0]),
        .keycode1(keycode0_gpio[15:8]),    //Notice: only two keycode connected to ball by default
        .JumpX(jumpxsig),
        .JumpY(jumpysig),
        .Jumping(jumping),
        .Direction(direction),
        .Climbing(climbing),
        .Running(running),
        .Frame(frame),
        .SavePrincess(princess_grab)
    );
    
    //Color Mapper Module   
    color_mapper color_instance(
        .BallX(ballxsig),
        .BallY(ballysig),
        .DrawX(drawX),
        .DrawY(drawY),
        .Ball_size(ballsizesig),
        .JumpX(jumpxsig),
        .JumpY(jumpysig),
        
        .Ball2X(ball2xsig),
        .Ball2Y(ball2ysig),
        .Ball2On(barrel2On),
        .Ball3X(ball3xsig),
        .Ball3Y(ball3ysig),
        .Ball3On(barrel3On),
        .Ball4X(ball4xsig),
        .Ball4Y(ball4ysig),
        .Ball4On(barrel4On),
        .Ball5X(ball5xsig),
        .Ball5Y(ball5ysig),
        .Ball5On(barrel5On),
        
        .game_state(game_state),
        .lives(lives),
        .BallOn(barrelOn),
        .Jumping(jumping),
        .Direction(direction),
        .Climbing(climbing),
        .Frame(frame),
        .Running(running),
        .Clk(clk_25MHz),
        .timer10(timer10),
        .timer1(timer1),
        .Red(red),
        .Green(green),
        .Blue(blue)
    );    
        
    //Collision Module
    collision collider_0(
        .frame_clk(vsync),
        .BallX(ballxsig),
        .BallY(ballysig),
        .JumpX(jumpxsig),
        .JumpY(jumpysig),
        .Collision(coll0)
    );
    
    collision collider_2(
        .frame_clk(vsync),
        .BallX(ball2xsig),
        .BallY(ball2ysig),
        .JumpX(jumpxsig),
        .JumpY(jumpysig),
        .Collision(coll2)
    );
    
    collision collider_3(
        .frame_clk(vsync),
        .BallX(ball3xsig),
        .BallY(ball3ysig),
        .JumpX(jumpxsig),
        .JumpY(jumpysig),
        .Collision(coll3)
    );
    
    collision collider_4(
        .frame_clk(vsync),
        .BallX(ball4xsig),
        .BallY(ball4ysig),
        .JumpX(jumpxsig),
        .JumpY(jumpysig),
        .Collision(coll4)
    );
    
    collision collider_5(
        .frame_clk(vsync),
        .BallX(ball5xsig),
        .BallY(ball5ysig),
        .JumpX(jumpxsig),
        .JumpY(jumpysig),
        .Collision(coll5)
    );
    
endmodule