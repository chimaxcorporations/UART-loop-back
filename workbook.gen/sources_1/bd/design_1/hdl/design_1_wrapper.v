//Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
//Date        : Tue Jul  4 16:53:05 2023
//Host        : ZEL678 running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (clk,
    rst,
    rx,
    tx,
    tx_done);
  input clk;
  input rst;
  input rx;
  output tx;
  output tx_done;

  wire clk;
  wire rst;
  wire rx;
  wire tx;
  wire tx_done;

  design_1 design_1_i
       (.clk(clk),
        .rst(rst),
        .rx(rx),
        .tx(tx),
        .tx_done(tx_done));
endmodule
