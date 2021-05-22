`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/22 10:24:07
// Design Name: 
// Module Name: segment
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


module segment(
input clk,rst,//clock and reset  high-active
input [31:0] in,//input data
output reg [7:0] segment_led, //seven segment tube
output reg [7:0] seg_en//enable signal for seven segment tube
    );
    
    reg[7:0] seg [15:0]; //data for decode
    initial 
        begin
            seg[0] = 8'b11000000;   //  0
            seg[1] = 8'b11111001;   //  1
            seg[2] = 8'b10100100;   //  2
            seg[3] = 8'b10110000;   //  3
            seg[4] = 8'b10011001;   //  4
            seg[5] = 8'b10010010;   //  5
            seg[6] = 8'b10000010;   //  6
            seg[7] = 8'b11111000;   //  7
            seg[8] = 8'b10000000;   //  8
            seg[9] = 8'b10010000;   //  9
            seg[10]= 8'b10001000;   //  A
            seg[11]= 8'b10000011;   //  b
            seg[12]= 8'b11000110;   //  C
            seg[13]= 8'b10100001;   //  d
            seg[14]= 8'b10000110;   //  E
            seg[15]= 8'b10001110;   //  F
        end
        
     wire[3:0] div_data[7:0];
     assign div_data[0] = in[3:0];
     assign div_data[1] = in[7:4];
     assign div_data[2] = in[11:8];
     assign div_data[3] = in[15:12];
     assign div_data[4] = in[19:16];
     assign div_data[5] = in[23:20];
     assign div_data[6] = in[27:24];
     assign div_data[7] = in[31:28];
     
     reg[3:0] select_cnt = 0;
     always@(posedge clk)
     begin
         if(rst)
         begin
             select_cnt=1'b0;
         end
         else if(select_cnt==4'd9)
         begin
             select_cnt=1'b0;
         end
         else
         begin
             select_cnt=select_cnt+1'b1;
         end
     end
     
     always@(posedge clk)
     begin
        if(!rst)
            case(select_cnt)
                4'd1:
                begin
                    seg_en = 8'b01111111;
                    segment_led = seg[div_data[7]];
                end
                4'd2:
                begin
                    seg_en = 8'b10111111;
                    segment_led = seg[div_data[6]];
                end
                4'd3:
                begin
                    seg_en = 8'b11011111;
                    segment_led = seg[div_data[5]];
                end
                4'd4:
                begin
                    seg_en = 8'b11101111;
                    segment_led = seg[div_data[4]];
                end
                4'd5:
                begin
                    seg_en = 8'b11110111;
                    segment_led = seg[div_data[3]];
                end
                4'd6:
                begin
                    seg_en = 8'b11111011;
                    segment_led = seg[div_data[2]];
                end
                4'd7:
                begin
                    seg_en = 8'b11111101;
                    segment_led = seg[div_data[1]];
                end
                4'd8:
                begin
                    seg_en = 8'b11111110;
                    segment_led = seg[div_data[0]];
                end
                default:
                seg_en = 8'b1111_1111;
          endcase
     end
endmodule
