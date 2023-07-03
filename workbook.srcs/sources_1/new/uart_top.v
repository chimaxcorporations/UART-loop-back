module uart_top(
input clk,
input rst,
input tx_start,
input fifo_en,
output [7:0] fifo_out,
output tx_led,
output baud_led,
output tx,
output blinkLED
);
wire baud_tick;
//assign tx = blinkLED;
baudrate_gen BAUD_GEN(
.clk (clk),
.rst (rst),
.done (baud_tick));
wire [7:0]fifo_in;
wire fifo_wr;

//clk_1hz LED1HZ (
//     .rst(rst),
//     .clk(clk),
//    .clk_hz(blinkLED)
////    output reg led0
//);

data_gen D_GEN(
.clk(clk),
.rst(rst),
.data_out(fifo_in),
.wr(fifo_wr)
);

fifo_generator_1 TX_FIFO (
  .clk(clk),      // input wire clk
  .srst(srst),    // input wire srst
  .din(fifo_in),      // input wire [7 : 0] din
  .wr_en(fifo_wr),  // input wire wr_en
  .rd_en(fifo_en),  // input wire rd_en
  .dout(fifo_out),    // output wire [7 : 0] dout
  .full(full),    // output wire full
  .empty(empty)  // output wire empty
);

//uart_tx TX(
//.tx_tick (baud_tick),
//.clk (clk),
//.rst(rst),
//.tx_start(tx_start),
//.tx_led (tx_led),
//.baud_led (baud_led),
//.tx(tx)
//);
endmodule