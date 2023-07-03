module mybaudgen_tb();
reg clk;
reg rst;
wire b_clk;

mybaudgen DUT (
.clk    (clk),
.rst    (rst),
.b_clk  (b_clk)
);

initial begin
   clk = 1'b0;
   forever
   #5 clk = ~clk;
end

initial begin
rst = 1'b1;
#10
rst = 1'b0;

end
endmodule