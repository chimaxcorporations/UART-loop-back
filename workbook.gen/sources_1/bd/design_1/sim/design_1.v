//Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
//Date        : Mon Jul  3 16:28:38 2023
//Host        : ZEL678 running 64-bit major release  (build 9200)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=4,numReposBlks=4,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=2,numPkgbdBlks=0,bdsource=USER,da_clkrst_cnt=6,synth_mode=Global}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (clk,
    rst,
    rx,
    tx,
    tx_done);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK, ASSOCIATED_RESET rst, CLK_DOMAIN design_1_clk_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RST RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RST, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input rst;
  input rx;
  output tx;
  output tx_done;

  wire clk_0_1;
  wire [7:0]fifo_generator_0_dout;
  wire fifo_generator_0_empty;
  wire rst_0_1;
  wire rx_0_1;
  wire [7:0]uart_rx_0_rx_data;
  wire uart_rx_0_rx_done;
  wire uart_tx_0_tx;
  wire uart_tx_0_tx_done;
  wire [7:0]util_vector_logic_0_Res;

  assign clk_0_1 = clk;
  assign rst_0_1 = rst;
  assign rx_0_1 = rx;
  assign tx = uart_tx_0_tx;
  assign tx_done = uart_tx_0_tx_done;
  design_1_fifo_generator_0_0 fifo_generator_0
       (.clk(clk_0_1),
        .din(uart_rx_0_rx_data),
        .dout(fifo_generator_0_dout),
        .empty(fifo_generator_0_empty),
        .rd_en(uart_tx_0_tx_done),
        .srst(rst_0_1),
        .wr_en(uart_rx_0_rx_done));
  design_1_uart_rx_0_0 uart_rx_0
       (.clk(clk_0_1),
        .rst(rst_0_1),
        .rx(rx_0_1),
        .rx_data(uart_rx_0_rx_data),
        .rx_done(uart_rx_0_rx_done));
  design_1_uart_tx_0_0 uart_tx_0
       (.clk(clk_0_1),
        .rst(rst_0_1),
        .tx(uart_tx_0_tx),
        .tx_data(fifo_generator_0_dout),
        .tx_done(uart_tx_0_tx_done),
        .tx_start(util_vector_logic_0_Res[0]));
  design_1_util_vector_logic_0_0 util_vector_logic_0
       (.Op1({fifo_generator_0_empty,fifo_generator_0_empty,fifo_generator_0_empty,fifo_generator_0_empty,fifo_generator_0_empty,fifo_generator_0_empty,fifo_generator_0_empty,fifo_generator_0_empty}),
        .Res(util_vector_logic_0_Res));
endmodule
