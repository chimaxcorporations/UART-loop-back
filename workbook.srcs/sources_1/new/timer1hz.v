module timer1hz (
input clk,
input rst,
input en,
output time_out);

reg [$clog2(50000000)-1:0]clk_temp;

assign time_out =(clk_temp==4999999)?1'b1:1'b0;

always @ (posedge clk)
begin
    if(rst)
        clk_temp <= 0;
    else if (en)
        clk_temp <= clk_temp+1;
    else if(clk_temp==4999999)
        clk_temp<=0;
    
end
endmodule