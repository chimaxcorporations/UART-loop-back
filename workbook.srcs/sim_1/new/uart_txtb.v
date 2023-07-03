module uart_txtb();
reg tx_tick;
reg clk;
reg rst;
reg [7:0] data_in;
reg tx_start;
wire tx_done;
wire tx;
integer period = 10;
uart_tx TX_DUT(tx_tick,clk,rst,data_in,tx_start,tx_done,tx);

initial
begin
clk = 1'b0;
forever
    #period clk = ~clk;
end
initial
begin
    rst = 1'b1;
    #30
    rst = 1'b0;
    #30
    tx_tick = 1;
    #100
    tx_start = 1;
    data_in<= 8'b0100_1000;
end
endmodule