//`include "memh.vh"

module proj_top(
input clk,
input rst,
output [7:0] LED
);
wire clk_1h_ce;
wire [3:0]cnt_mem;
wire [7:0] LED_WIRE;

assign LED = (clk_1h_ce)? 8'b0000_0000:LED_WIRE;

clk_1hz clk_div (
.clk(clk),
.rst (rst),
.clk_hz (clk_1h_ce));

addr_cntr addr_control(
.clk    (clk),
.rst    (rst),
.ce     (clk_1h_ce),
.addr_out (cnt_mem)
);

mem memory(
.clk    (clk),
.addr   (cnt_mem),
.LED    (LED_WIRE)
);
endmodule