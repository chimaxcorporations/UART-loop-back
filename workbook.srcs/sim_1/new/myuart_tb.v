module myuart_tb ();
reg clk;
reg rst;
//reg [7:0] tx_data;
//reg tx_start;
//input baud_tick,
wire tx;

myuart MYDUT (
.clk    (clk),
.rst    (rst),
//.tx_data    (tx_data),
//.tx_start (tx_start),
.tx (tx)
);

initial
begin
    clk  = 1'b1;
    forever
    #5 clk = ~clk;
end

initial
begin
    rst = 1'b1;
//    tx_start = 1'b0;
    #20
    rst = 1'b0;
//    tx_start = 1'b1;
//    tx_data = 8'b0011_0001;
end
endmodule