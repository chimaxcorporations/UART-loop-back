module uart_toptb();
reg clk;
reg rst;
reg tx_start;
wire tx;
reg fifo_en;


uart_top TOP_DUT(
.clk    (clk),
.rst    (rst),
.fifo_en (fifo_en),
.tx_start   (tx_start),
.tx (tx)
);

initial
begin
    clk = 1'b0;
    forever
    #5 clk = ~clk;
end


task RESET();
    begin
        rst = 1'b1;
        fifo_en = 1'b0;
        #10
        rst = 1'b0;
    end
endtask

initial
    begin
    RESET();
    #50;   
    tx_start = 1'b1;
    #200;
    fifo_en = 1'b1;
//    tx_start = 1'b0;
    end

endmodule