module uart_rxtb();
reg clk;
reg rst;
reg rx;
wire [7:0]rx_dout;
wire rx_done;
reg en;
integer period = 10;

uart_rx DUT (
.clk    (clk),
.en     (en),
.rst    (rst),
.rx     (rx),
.rx_dout    (rx_dout),
.rx_done    (rx_done));
initial
begin
    clk = 1'b0;
    forever
    #period clk = ~clk;
end

initial
begin
    rst = 1'b1;
    en = 1'b0;
    rx = 1'b1;
    #30
    rst = 1'b0;
    en = 1'b1;
    #50
    rx = 1'b0;
    #100;
    
end
endmodule

//module uart_rxtb();
//parameter DBIT = 8,SB_TICK = 16;
//reg rx;
//reg s_tick;
//reg clk;
//reg rst;
//wire rx_done;
//wire [DBIT-1:0] rx_dout;

//uart_rx DUT (
//.rx         (rx),
//.s_tick     (s_tick),
//.clk        (clk),
//.rst        (rst),
//.rx_done    (rx_done),
//.rx_dout    (rx_dout));

//task RESET ();
//begin
//    rst  = 1'b1;
//    #50
//    rst = 1'b0;
// end
//endtask

//task test_IDLE();
//begin
//    rx  = 1'b1;
//    #200
//    rx = 1'b0;
//end
//endtask

//task test_START();
//begin
//    s_tick = 1'b0;
//    #50
//    s_tick = 1'b1;
////    #150
////    s_tick = 1'b0;
//end
//endtask
//initial 
//begin
//    clk = 1'b0;
//    forever
//    #10 clk = ~clk;
//end

//initial
//begin
//    RESET();
//    #100;
//    test_IDLE();
//    #100;
//    test_START();
//    #50;
//end
//endmodule