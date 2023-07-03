module clk_1khztb;
    reg rst;
    reg clk;
    wire clk_1hz;
    
    clk_1hz DUT(
        .rst (rst),
        .clk (clk),
        .clk_1hz (clk_1hz)        
    );
initial
begin
    clk = 1'b0;
    forever
        #10 clk = ~clk;
end

always @ (posedge clk)
begin
    rst = 1'b1;
    #100
    rst = 1'b0;

end
endmodule