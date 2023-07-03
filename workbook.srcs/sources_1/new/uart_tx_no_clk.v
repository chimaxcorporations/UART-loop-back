module uart_tx_no_clk(
input clk,
input rst,
input tx_start,
//input s_tick,
//input [7:0] tx_din,
output tx_done,
output tx_led,
output tx
);

// baud gen
localparam BAUD_VALUE = 651; // CLK/(BAUD *16); 100000000/(9600*16)
reg [$clog2(BAUD_VALUE)-1:0] baud_cnt, baud_cnt_reg;
wire baud_done;
reg tx_reg;
wire tick;
reg [3:0] tick_cnt, tick_cnt_reg;
reg [7:0] data, d_in = 8'b0100_1000, data_reg;
reg [2:0] bit_cnt, bit_cnt_reg;
reg [1:0] IDLE = 2'b00,
         START = 2'b01, 
         DATA = 2'b10, 
         STOP = 2'b11, 
         PRESENT, 
         NEXT;
 
always @ (posedge clk)
begin
    if(rst)begin
    
         baud_cnt <= 0;
         baud_cnt_reg <= 0;
     end
     else 
        baud_cnt <= baud_cnt_reg;
     
end
always @ (posedge clk)
    baud_cnt_reg = (baud_done)?'b0:baud_cnt+1;
assign baud_done = (baud_cnt==BAUD_VALUE);

// tx section

// state transition clk
always @ (posedge clk)
begin
    if(rst)
        begin
            PRESENT <= IDLE;
            tick_cnt <= 0;
            bit_cnt <= 0;
            data <= 0;
        end
     else
        begin
            PRESENT <= NEXT;
            tick_cnt <= tick_cnt_reg;
            bit_cnt <= bit_cnt_reg;
            data <= data_reg;
        end
end
assign tx= tx_reg;
assign tick = baud_done;

// state machine (combinational circuits)
always @ (*)
begin
    tick_cnt_reg = tick_cnt;
    bit_cnt_reg = bit_cnt;
    data_reg = data;
    NEXT = PRESENT;
//    bit_cnt_reg = bit_cnt;
    case(PRESENT)
        IDLE:
            begin
//                data = 8'b0;
                tx_reg = 1'b1;
                if(tx_start)
                    begin
                        NEXT = START;
                        data_reg = d_in;
                    end                   
            end
        START:
            begin
                tx_reg = 1'b0; // make tx low to signify start
                 // load data
                if(tick)
                    if(tick_cnt==15)
                    begin
                        tick_cnt_reg = 0;
                        bit_cnt_reg = 'b0;
                        NEXT = DATA;
                    end
                    else
                        tick_cnt_reg = tick_cnt+1;
            end
        DATA:
            begin
                tx_reg = data[0];
                if(tick)
                    if(tick_cnt==15)
                    begin
                        tick_cnt_reg = 0;
                        data_reg = {1'b0,data[7:1]};
                        if(bit_cnt==7)
                                NEXT = STOP;
                          else
                            bit_cnt_reg = bit_cnt+1;
                    end
                  else
                    tick_cnt_reg = tick_cnt+1;
            end
        STOP:
            begin
                tx_reg = 1'b1;
                if(tick)
                    if(tick_cnt==15)
                        begin
                            tick_cnt_reg = 0;
                            NEXT = IDLE;
                         end
                    else
                        tick_cnt_reg = tick_cnt+1;
            end
        default:
            NEXT = IDLE;
    endcase
end
endmodule