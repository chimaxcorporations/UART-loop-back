`timescale 1ns/1ps

module baudrate_gentb;
reg clk;
reg rst;
reg en;
//input baud_value,
wire done;
baudrate_gen DUT (
.clk    (clk),
.rst    (rst),
.en     (en),
.done   (done));

task run(input rst, input en);
begin
    rst = rst;
    en = rst;
end 
endtask

initial
begin
    clk = 1'b0;
    forever
    #10 clk = ~clk;
end

initial
begin
    rst = 1'b1;
    en = 1'b0;
    #100;   
    rst = 1'b0;
    en = 1'b1;
    #100;
    
end

endmodule