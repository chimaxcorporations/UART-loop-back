module uart_tx_test(
input clk,
input rst,
//input tx_start,
//input s_tick,
//input [7:0] tx_din,
output tx_done,
output tx_led,
output tx
);

localparam IDLE = 0,
START = 1,
DATA = 2,
STOP = 3;
reg tx_done_tick;
reg [7:0] tx_din ;//= 8'b01001000;
reg s_tick;
reg tx_start;
wire s_tick_w;
wire clk_done_w;
wire [7:0] tx_in_w;
reg en = 1'b1;
reg [1:0] state_reg, state_next;
reg [3:0] s_reg, s_next;    //baud rate ticks
reg [3:0] n_reg, n_next; //data bits
reg [7:0] b_reg, b_next; // shift transmitted bits
reg tx_reg, tx_next; // track transmitted bits
baudrate_gen BAUD_GEN(
.clk (clk),
.rst (rst),
.done (s_tick_w),
.en (en)
);
data_gen DATA_GEN(
 .clk (clk),
 .rst(rst),
 .en(clk_done_w),
 .data_out(tx_in_w)
 );

baudrate_gen #(25000000) CLK_GEN (
.clk (clk),
.rst (rst),
.done (clk_done_w),
.en (en)
);
assign tx_led = tx_reg;
assign tx_done = tx_done_tick;
assign clk_done_w = tx_start;
assign s_tick_w = s_tick;
assign tx_in_w = tx_din;
always @(posedge clk)
begin
    if(rst)
        begin
            state_reg <= IDLE;
            s_reg <= 0;
            n_reg <= 0;
            b_reg <= 0;
            tx_reg <= 1'b1;
        end
     else
        begin
            state_reg <= state_next;
            s_reg <= s_next;
            n_reg <= n_next;
            b_reg <= b_next;
            tx_reg <= tx_next;
        end
end

always @ (*)
begin
    state_next = state_reg;
    s_next = s_reg;
    n_next = n_reg;
    b_next = b_reg;
    tx_done_tick = 1'b0;
    case (state_reg)
        IDLE:
        begin
            tx_next = 1'b1;
            if(tx_start)
            begin
                s_next = 0;
                b_next = tx_din;
                state_next = START;
            end
        end
       START:
        begin
            tx_next = 1'b0;
            if(s_tick)
                if(s_reg ==15)
                    begin
                        s_next = 0;
                        n_next = 0;
                        state_next = DATA;
                    end
                    else
                        s_next = s_reg+1;
        end
        DATA:
            begin
                tx_next = b_reg[0];
                if(s_tick)
                    if(s_reg == 15)
                        begin
                           s_next = 0;
                           b_next = {1'b0,b_reg[7:1]};
                           if(n_reg==7)
                            state_next = STOP;
                            else
                            n_next = n_reg+1;
                        end
                     else
                        s_next = s_reg+1;
            end
            STOP:
                begin
                    tx_next = 1'b1;
                    if(s_tick)
                        if(s_reg==15)
                           begin
                            tx_done_tick = 1'b1;
                            state_next = IDLE;
                           end
                        else
                            s_next = s_reg+1;
                end
              default:
                state_next= IDLE;
      endcase
end
assign tx = tx_reg;
endmodule