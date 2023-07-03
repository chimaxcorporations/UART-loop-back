module uart_rx_no_clk_tb();
reg clk;
reg rst;
reg rx;
wire [7:0]rx_data;

uart_rx_no_clk RX_DUT (
.clk (clk), 
.rst(rst),
.rx(rx),
.rx_data(rx_data));

initial 
begin
    clk = 1'b0;
    forever
    #5 clk = ~clk;
end

initial
begin
    rst = 1'b1;
    #50
    rst = 1'b0;
    rx = 1'b0;
    #500
    rx = 1'b1;
end
endmodule