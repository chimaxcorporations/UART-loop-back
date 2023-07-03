module myuart (
input clk,
input rst,
//input [7:0] tx_data,
//input tx_start,
//input baud_tick,
output tx
);

// state machine
reg [1:0] IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;
reg [1:0] PRESENT, NEXT;
reg [4:0]tick_cnt, tick_cnt_reg;
reg [7:0]data_reg,data_hold_reg,data_shift_reg;
reg tx_reg,tx_next;
reg en = 1'b1;
reg tx_start;
wire tx_start_w;
reg [1:0] baud_edge;
reg [3:0] nbits, nbits_reg;
reg [7:0] tx_data;
//wire[7:0] tx_data_w;
reg check_tick;
wire baud_w;
wire baud_tick;
wire [7:0] tx_in_w;
wire clk_done_w;
reg [7:0]data_hold;
reg tx_done_reg;
assign clk_done_w = tx_start;
assign baud_tick = baud_w;
assign tx_in_w = tx_data;
 baudrate_gen BAUD (
 .clk (clk),
 .rst (rst),
 .en (en),
.done(baud_w));

data_gen DATA_GEN(
 .clk (clk),
 .rst(rst),
 .en(clk_done_w),
 .data_out(tx_data_w)
 );
 
 baudrate_gen #(25000000) TIMER (
 .clk (clk),
 .rst (rst),
 .en (en),
  .done(clk_done_w));




// one clock baud tick
//always @ (posedge clk)
//begin
//    if(baud_tick)
//       baud_edge <= 2'b10;
//     else
//        baud_edge <= 2'b01;
//     if(!baud_edge[1]&&baud_edge[0]&&baud_tick)
//        check_tick <= 1;
//        else
//         check_tick <= 0;
//end
// initiate transit clock
always @ (posedge clk)
begin
    if(rst)
        begin
            PRESENT <= IDLE;
            data_hold <= 0;
            tx_reg <= 1'b1;
            nbits <= 0;
            tick_cnt <=0;
        end
     else
       begin
            PRESENT <= NEXT;
            data_hold <= data_reg;
            tx_reg<= tx_next;
            tick_cnt <= tick_cnt_reg;
            nbits <= nbits_reg;

       end
end
// state_machine
always @ (*)
begin
    NEXT= PRESENT;
    nbits_reg = nbits;
    tx_next = tx_reg;
    tx_done_reg = 1'b0;
    tick_cnt_reg = tick_cnt;
    case(PRESENT)
    IDLE:
      begin
        tx_next = 1'b1;
        if(tx_start)
           begin
            data_reg = tx_data;
            tick_cnt_reg = 0;
            NEXT= START;
           end
      end    
    START:
        begin
            tx_next=1'b0; 
          if(baud_tick)
            if(tick_cnt ==15)
            begin     
                 tick_cnt_reg = 0;
                 nbits_reg = 0;
                 NEXT = DATA;
             end
             else
                tick_cnt_reg = tick_cnt+1; 
                
         end
       
    DATA:
        begin
            tx_next=data_hold[0];
            if(baud_tick)
                    if(tick_cnt==15)
                        begin
                            tick_cnt_reg = 0;
                            data_reg = {1'b0,data_hold[7:1]};
                            if(nbits == 7)
                                   NEXT=STOP;
                             else
                                  nbits_reg = nbits+1;
                        end
                    else
                        tick_cnt_reg = tick_cnt+1;
                    end
          
    STOP:
        begin
            tx_next = 1'b1;
            if(baud_tick)
                if(tick_cnt==15)
                begin
                tx_done_reg = 1'b1;
//                    tick_cnt_reg = 0;
                    NEXT= IDLE;
                end
                else
                    tick_cnt_reg = tick_cnt+1;
            end
       
    default:
        NEXT = IDLE;
    endcase
end
assign tx = tx_reg;
endmodule