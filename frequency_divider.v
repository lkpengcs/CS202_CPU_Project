`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////



module frequency_divider #(parameter period=100000000)
(
input clk,rst,
output reg clkout
    );

reg[31:0] cnt=0;
always @ (posedge clk or negedge rst)
begin
    if(rst == 0)
    begin
            cnt<=0;
            clkout<=0;
    end
    else
    begin
        if(cnt == (period >> 1) - 1)//when cnt==half of period, flip clkout
        begin
            clkout<=~clkout;
            cnt<=0;
        end
        else
            cnt<=cnt+1;
    end
end
endmodule
