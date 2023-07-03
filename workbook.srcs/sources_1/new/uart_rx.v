module uart_rx (
input clk,
input rst,
input rx,
output reg rx_done,
output [7:0]rx_data
);
localparam BAUD_VALUE = 10416; // CLK/(BAUD *16); 100000000/(9600)= 10416
reg [$clog2(BAUD_VALUE)-1:0] baud_cnt, baud_cnt_reg;
wire en = 1;
wire baud_done;
reg [3:0] tick_cnt_reg, tick_cnt;
wire tick;
reg [7:0] rx_data_reg, rx_data_out, rx_data_hold;
reg [2:0] bit_cnt, bit_cnt_reg;
reg [1:0] IDLE = 2'b00, 
          START = 2'b01,
          DATA = 2'b10,
          STOP = 2'b11,
          PRESENT,
          NEXT;
          
assign tick = baud_done;
assign rx_data = (rx_done)?rx_data_out:8'b0;
//always @ (posedge clk)
//begin
//    if(rst)
//         baud_cnt <= 0;
//     else if(en)
//        baud_cnt_reg<= baud_cnt+1;
//     else 
//        baud_cnt <= baud_cnt;
//end
//always @ (posedge clk)
//    baud_cnt_reg = (baud_done)?'b0:baud_cnt+1;
//assign baud_done = (baud_cnt==BAUD_VALUE);

always @ (posedge clk)
begin
    if(rst)
        begin
        PRESENT <= IDLE;
//        rx_data_hold <= 0;
        end
    else
        begin
        PRESENT <= NEXT;
//        rx_data_hold <= rx_data_out;
        end
end

always @(posedge clk)
begin
    NEXT <= PRESENT;
//    rx_data_out <= rx_data_hold;
    case (PRESENT)
    IDLE:
        begin
          bit_cnt <= 0;
          baud_cnt <= 0;
          rx_done <= 1'b0;
//          rx_data_out <= 0;
            if(!rx)
                begin
                    NEXT <= START;
                    
                end
        end
    START:
        begin
            if(baud_cnt == (BAUD_VALUE-1)/2)
              if(!rx)
                begin
                    baud_cnt <= 0;
                    rx_done <= 1'b0;
                    NEXT <= DATA;
                end
              else
                NEXT <= IDLE;
            else
                baud_cnt <= baud_cnt+1;             
                    
        end
    DATA:
        begin
            if(baud_cnt < (BAUD_VALUE-1))
                baud_cnt <= baud_cnt+1;
            else
                begin
                    baud_cnt <= 0;
                    rx_data_out[bit_cnt] <= rx;
                    if(bit_cnt<7)
                        bit_cnt <= bit_cnt+1;
                     else
                        begin
                            bit_cnt <= 0;
                            NEXT <= STOP;
                        end
                end    
        end
        
    STOP:
        begin
        if(baud_cnt < (BAUD_VALUE-1))
            baud_cnt <= baud_cnt+1;
        else
            begin
            baud_cnt <= 0;
            rx_done <= 1'b1;
//            rx_data_hold <= rx_data_out;
            NEXT <= IDLE;
            end
        end
    default:
        NEXT <= IDLE;
    endcase
end
endmodule