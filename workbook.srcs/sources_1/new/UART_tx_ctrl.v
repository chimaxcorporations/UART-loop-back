//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2023 12:38:52 PM
// Design Name: 
// Module Name: UART_tx_ctrl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module UART_tx_ctrl(
    input [0:0] tx_data_in,
    input tx_start,
    input tx_baud_rate_enable,
    input clock,
    input reset,
    output reg tx_serial_out
    );
 reg [7:0] count_value = 0;
 reg count_reset = 0;
 reg start_transmitting = 0;
 reg reset_oneShot = 0;
 reg [7:0] registered_data;
 localparam [1:0] IDLE = 2'd0,
                  START = 2'd1,
                  DATA = 2'd2,
                  STOP = 2'd3;
 reg [1:0] curr_state, next_state;
 always @ (posedge clock)
 begin
    if (reset)
        begin
            curr_state <= IDLE;
            tx_serial_out <= 1'b1;
            reset_oneShot <= 1'b1;
            count_reset <= 1'b1;
         end
     else
        curr_state <= next_state;
 end 
  always @(posedge clock)
  begin
      if (reset||count_reset)
         count_value <= 1'b0;
      else if (tx_baud_rate_enable)
        count_value <= count_value+1'b1;
  end
  
always @ (posedge clock)
begin
if(reset||reset_oneShot)
    start_transmitting <= 1'b0;
else if (tx_start)
    begin
        start_transmitting <= 1'b1;
        registered_data <= tx_data_in;
    end
end		
			
always @ (posedge clock)
begin
    curr_state <= IDLE;
    case(curr_state)
    IDLE:
        begin 
            tx_serial_out <= 1'b1;
            reset_oneShot <= 1'b0;
            count_reset <= 1'b1;
            if(start_transmitting)
                curr_state <= START;
            else if (tx_baud_rate_enable)
                   curr_state <= IDLE;
        end
     START:
        begin
            tx_serial_out <= 1'b0;
            count_reset <= 1'b0;
            curr_state<= DATA;
        end
     DATA:
        begin
            tx_serial_out <= registered_data[count_value];
            if(count_value ==7)
            begin
                count_reset <= 1'b1;
                curr_state<= STOP;
             end   
             else
                curr_state <= DATA;
        end
      STOP:
        begin
                tx_serial_out <= 1'b1;
                reset_oneShot <= 1'b1;
                curr_state<= IDLE;
        end
     endcase
end
						
endmodule
