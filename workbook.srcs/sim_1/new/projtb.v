//`include "memh.vh"
module projtb;
reg clk;
reg rst;
wire [7:0] LED;

proj_top DUT (
.clk (clk),
.rst (rst),
.LED (LED)
);

initial 
begin
    clk = 1'b0;
    forever
    #10 clk = ~clk;
end


endmodule