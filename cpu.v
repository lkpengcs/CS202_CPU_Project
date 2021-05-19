`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/18 10:51:32
// Design Name: 
// Module Name: cpu
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


module CPU_TOP(
input fpga_rst,
input fpga_clk,
input [23:0]switch2N4,
output [23:0]led2N4,
input start_pg,
input rx,
output tx
    );
// UART Programmer Pinouts 
wire upg_clk, upg_clk_o; 
wire upg_wen_o; //Uart write out enable 
wire upg_done_o; //Uart rx data have done 
//data to which memory unit of program_rom/dmemory32 
wire [14:0] upg_adr_o; //data to program_rom or dmemory32 
wire [31:0] upg_dat_o;
wire spg_bufg; 
BUFG U1(.key_in(start_pg), .key_out(spg_bufg)); // de-twitter 
// Generate UART Programmer reset signal 
reg upg_rst; 
always @ (posedge fpga_clk) 
begin 
    if (spg_bufg) 
        upg_rst = 0; 
    if (fpga_rst) 
        upg_rst = 1; 
end
assign rst = fpga_rst | !upg_rst;
endmodule
