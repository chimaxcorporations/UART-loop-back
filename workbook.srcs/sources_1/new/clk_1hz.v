//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2023 01:06:31 PM
// Design Name: 
// Module Name: clk_1hz
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
module clk_1hz(
    input rst,
    input clk,
    output reg clk_hz
//    output reg led0
    );
    reg [26:0] clktemp;
    reg clk_1hz_out;
always @(posedge clk)
begin
    if (rst == 1'b1)
        begin
            clktemp <= 0;
            clk_1hz_out <= 0;
         end
    else if (clktemp==27'd50_000_000)
        begin
         clktemp <= 0;
         clk_1hz_out <= ~clk_1hz_out;
        end
    else
        clktemp<= clktemp+1;
end

//assign clk_hz = clk_1hz_out;
always @(posedge clk)
begin
    if(clk_1hz_out)
    begin
//        led0<= 1'b1;
        clk_hz <= 1'b0;
    end
    else
    begin
//        led0 <= 1'b0;
        clk_hz <= 1'b1;
    end
end
endmodule
