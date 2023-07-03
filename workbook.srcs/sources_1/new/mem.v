//`include "memh.vh"
module mem (
input clk,
input [7:0] addr,
output reg [7:0] LED
);

reg [7:0]rom[2**4-1:0];

always @ (posedge clk)
begin
    rom ['b0000] <= 'b0000_0001;
    rom ['b0001] <= 'b0000_0010;
    rom ['b0010] <= 'b0000_0100;
    rom ['b0011] <= 'b0000_1000;
    rom ['b0100] <= 'b0001_0000;
    rom ['b0101] <= 'b0010_0000;                              
    rom ['b0110] <= 'b0100_0000;
    rom ['b0111] <= 'b1000_0000;
    rom ['b1000] <= 'b0100_0000;
    rom ['b1001] <= 'b0010_0000;
    rom ['b1010] <= 'b0001_0000;
    rom ['b1011] <= 'b0000_1000;
    rom ['b1100] <= 'b0000_0100;
    rom ['b1101] <= 'b0000_0010;
    rom ['b1110] <= 'b0000_0001;
    rom ['b1111] <= 'b1111_1111;
end
always@ (posedge clk)
    LED <= rom[addr];
endmodule