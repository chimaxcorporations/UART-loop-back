module uart_tx(
input clk,
input rst,
input tx_start,
output tx,
input [7:0]tx_data,
output reg tx_done
);

localparam [1:0]    IDLE = 2'b00,
                    START = 2'b01,
                    DATA = 2'b10,
                    STOP = 2'b11;
reg [1:0] PRESENT, NEXT;
localparam BAUD_VALUE = 10416; // 100000000/9600
reg [$clog2(BAUD_VALUE)-1:0] baud_cnt;
reg [2:0] bit_cnt;
//reg [7:0] tx_data = 8'b0011_0001;
reg tx_w;

assign tx = tx_w;
// state flip flop
always @ (posedge clk)
begin
    if(rst)
    begin
        PRESENT <= IDLE;
    end
        PRESENT <= NEXT;
end

// state machine
always @ (posedge clk)
begin
    NEXT <= PRESENT;
    case(PRESENT)
    IDLE:
        begin
            tx_w <= 1'b1;
            if(tx_start) // wait for start enable
                begin
                    NEXT<= START;
                end    
        end
    START:
        begin
            tx_w <= 1'b0;
            tx_done <= 1'b0;
            if(baud_cnt < (BAUD_VALUE-1))
                baud_cnt <= baud_cnt +1;
            else
                begin
                    NEXT <= DATA;
                    baud_cnt <= 0;
                    bit_cnt <= 0;
                end
            
        end
    DATA:
        begin
            tx_w <= tx_data[bit_cnt];
            if(baud_cnt < (BAUD_VALUE-1))
                baud_cnt <= baud_cnt+1;
             else
                begin
                    baud_cnt <= 0;     
                    if(bit_cnt < 7)
                        bit_cnt <= bit_cnt + 1'b1;
                    else
                        begin
                        NEXT <= STOP;
                        bit_cnt <= 0;
                        end
                end
          end
    STOP:
        begin
            tx_w <= 1'b1;
            if(baud_cnt < (BAUD_VALUE-1))
                baud_cnt <= baud_cnt+1;
            else
                begin
                 baud_cnt <= 0;
                 tx_done <= 1'b1;
                 NEXT <= IDLE;
                end
        end
    default:
        PRESENT <= IDLE;
    endcase
end

endmodule