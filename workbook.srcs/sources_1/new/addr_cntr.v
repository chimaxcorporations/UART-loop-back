
module addr_cntr (
//`include "memh.vh"
input clk,
input rst,
input ce,
output reg [3:0] addr_out
);
always @ (posedge clk)
begin
    if(rst)
        addr_out <= 4'b0000;
    else if (ce)
        addr_out <= addr_out+1'b1;
    
end
endmodule