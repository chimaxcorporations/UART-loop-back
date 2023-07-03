module data_gentb();
reg clk;
reg rst;
wire [7:0] data_out;
wire  wr;

data_gen DUT (
.clk    (clk),
.rst    (rst),
.data_out   (data_out),
.wr     (wr));

initial
begin
    clk = 1'b0;
    forever
    #5 clk = ~clk;
end

initial
begin
    rst = 1'b1;

    #20
    rst = 1'b0;
end

endmodule