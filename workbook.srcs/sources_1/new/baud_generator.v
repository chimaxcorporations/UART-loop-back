module baudrate_gen#(parameter baud_value = 650)(
input clk,
input rst,
input en,
//input [BITS-1:0] FINAL_VALUE,
output done);
// Generates a control pulse according to the required baudrate
// default value set at 650 for 9600 baudrate

reg [$clog2(baud_value)-1:0] q_reg, q_next;
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


endmodule
