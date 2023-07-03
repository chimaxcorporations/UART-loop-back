module uart_tx_no_clk_tb ();
reg clk;
reg rst;
reg tx_start;
wire tx_done;
wire tx_led;
wire tx;

uart_tx_no_clk UART_NO_CLK_DUT(
.clk    (clk),
.rst    (rst),
.tx_start   (tx_start),
.tx_led (tx_led),
.tx (tx)
);

initial 
begin
    clk = 1'b0;
    forever
    #5 clk = ~clk;
end

initial 
begin
    rst = 1'b1;
    tx_start = 1'b0;
    #10;
    rst = 1'b0;
    tx_start = 1'b1;
end
endmodule 