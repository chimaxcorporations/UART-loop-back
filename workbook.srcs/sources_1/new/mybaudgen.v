module mybaudgen(
input clk,
input rst,
output b_clk

);
parameter CLK_MAX = (100000000/(2*9600)); //clkmax = 100,000,000/(2*9600)
reg [$clog2(CLK_MAX)-1:0] clk_cnt;
reg clk_out;
always @(posedge clk)
begin
    if(rst)
        begin
        clk_cnt <= 0;
        clk_out <= 0;
        end
    else if(clk_cnt==CLK_MAX)
        begin
            clk_cnt <= 0;
            clk_out <= ~clk_out;
        end
    else
            clk_cnt <= clk_cnt+1;
end

assign b_clk = clk_out;
endmodule