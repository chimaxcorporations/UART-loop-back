module data_gen(clk,rst,data_out,en);
input clk;
input rst;
input en;
output [7:0] data_out;
//output reg wr;

integer i;
parameter MEMSIZE = 13;
reg [4:0] cnt, cnt_reg;
reg [7:0] mem [0:MEMSIZE-1];
wire last_bit;
//always @ (posedge clk)
//begin
//    if(rst)
//        begin
//            cnt <= 4'b0000;
////            wr <= 0;
//            last_bit <= 1'b0;
//        end
//    else if(cnt<MEMSIZE)
//        begin
//            cnt <= cnt+1;
////            wr <= 1;
//        end
//    else if(cnt==MEMSIZE)
//        begin
//            cnt <= 0;
////            wr <= 0;
//            last_bit <=1;
//        end
//end

always @ (posedge clk)
begin
    if(rst)
        cnt_reg <= 0;
    else if(en)
        cnt_reg <= cnt;
     else
        cnt_reg <= cnt_reg;
end

always @ (posedge clk)
    cnt = (last_bit)?'b0:cnt_reg+1;

always @ (posedge clk)
begin
    if((!rst)&&(!last_bit))
//        mem[0]<= 8'h00;
//        mem[1]<= 8'h20;
        mem[0]<= 8'h48;
        mem[1]<= 8'h45;
        mem[2]<= 8'h4c;
        mem[3]<= 8'h4c;
        mem[4]<= 8'h4f;
        mem[5]<= 8'h20;
        mem[6]<= 8'h57;
        mem[7]<= 8'h4f;
        mem[8]<= 8'h52;
        mem[9]<= 8'h4c;
        mem[10]<= 8'h44;
        mem[11]<= 8'h0a;
        mem[12]<= 8'h0d;
//        mem[13]<= 8'h0d;
end
assign last_bit = (cnt_reg==MEMSIZE);
assign data_out=mem[cnt];

endmodule