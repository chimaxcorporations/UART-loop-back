module design_wrapper_tb();
  reg clk;
  wire clk_hz;
  wire full;
  reg rst;
  wire tx;

design_1_wrapper DUT (clk,
    clk_hz,
    full,
    rst,
    tx);
    
initial 
begin
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