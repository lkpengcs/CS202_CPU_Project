`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/13 23:23:50
// Design Name: 
// Module Name: debounce
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


module BUFG(
    input wire clk, nrst,
    input wire key_in,
    output reg key_out
    );

    localparam TIME_20MS = 1_000_000;

    reg [20:0] cnt;
    reg key_cnt;
    
    // debounce time passed, refresh key state
    always @(posedge clk or negedge nrst) begin
        if(nrst == 0)
            key_out <= 0;
        else if(cnt == TIME_20MS - 1)
            key_out <= key_in;
    end

    // while in debounce state, count, otherwise 0
    always @(posedge clk or negedge nrst) begin
        if(nrst == 0)
            cnt <= 0;
        else if(key_cnt)
            cnt <= cnt + 1'b1;
        else
            cnt <= 0; 
    end
     
     //delay 20ms 
     always @(posedge clk or negedge nrst) begin
            if(nrst == 0)
                key_cnt <= 0;
            else if(key_cnt == 0 && key_in != key_out)
                key_cnt <= 1;
            else if(cnt == TIME_20MS - 1)
                key_cnt <= 0;
     end
endmodule