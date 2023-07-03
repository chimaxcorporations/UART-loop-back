module uart_rx_test 
    #(parameter DBIT = 8,
       SB_TICK = 16)(
       input clk, rst,
       input rx,
//       output reg rx_done_tick,
       output [DBIT-1:0]rx_data
       );
localparam IDLE = 0, START = 1, DATA = 2, STOP = 3;
reg [1:0] state_reg, state_next;
reg [3:0] s_reg, s_next;
reg [$clog2(DBIT)-1:0] n_reg, n_next;
reg [DBIT-1:0] b_reg, b_next;
localparam baud_value = 650;
reg [$clog2(baud_value)-1:0] q_reg, q_next;
reg rx_done_tick;
wire s_tick;
wire en = 1;
assign s_tick = done;
always @ (posedge clk)
begin
    if(rst)
        q_reg <= 0;
     else if(en)
            q_reg <= q_next; 
     else
          q_reg <= q_reg;      
end
always @ (posedge clk)
    q_next = (done)?'b0:q_reg+1;
   
assign done = (q_reg==baud_value);
always @ (posedge clk)
begin
    if(rst)
        begin
            state_reg <= IDLE;
            s_reg <= 0;
            n_reg <= 0;
            b_reg <= 0;
        end
      else
        begin
            state_reg <= state_next;
            s_reg <= s_next;
            n_reg <= n_next;
            b_reg <= b_next;
        end
end

always @(*)
begin
    state_next = state_reg;
    s_next = s_reg;
    b_next = b_reg;
    rx_done_tick = 1'b0;
    case(state_reg)
        IDLE:
            if(~rx)
            begin
                s_next = 0;
                state_next = START;
            end
        START:
                if(s_tick)
                    if(s_reg == 7)
                    begin
                        s_next = 0;
                        n_next = 0;
                        state_next = DATA;
                    end
                 else
                    s_next = s_reg+1;
          DATA:
                if(s_tick)
                    if(s_reg == 15)
                    begin
                        s_next = 0;
//                        b_next = {rx,b_reg[DBIT-1:1]};
                        b_next[n_reg]=rx;
                        if(n_reg == (DBIT -1))
                            state_next = STOP;
                        else
                            n_next = n_reg+1;
                     end
                         else
                            s_next = s_reg + 1;
         STOP:
            if(s_tick)
                if(s_reg == (SB_TICK-1))
                begin
                    rx_done_tick = 1'b0;
                    state_next = IDLE;
                 end
                else
                    s_next = s_reg+1;
          default:
            state_next = IDLE;
    endcase
end
assign rx_data = b_reg;
endmodule