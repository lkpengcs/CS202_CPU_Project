`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/27 11:22:28
// Design Name: 
// Module Name: IFetc32
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


module Ifetc32(Instruction_out,branch_base_addr,Addr_result,
            Read_data_1,Branch,nBranch,Jmp,Jal,Jr,Zero,
            clock,reset,link_addr,pco, Instruction); 
output[31:0] Instruction_out; // the instruction fetched from this module 
output[31:0] branch_base_addr; // (pc+4) to ALU which is used by branch type instruction 
output reg [31:0] link_addr; // (pc+4) to decoder which is used by jal instruction 
output[31:0] pco;
input clock,reset; // Clock and reset 
// from ALU 
input[31:0] Addr_result; // the calculated address from ALU 
input Zero; // while Zero is 1, it means the ALUresult is zero 
// from Decoder 
input[31:0] Read_data_1; // the address of instruction used by jr instruction 
// from controller 
input Branch; // while Branch is 1,it means current instruction is beq 
input nBranch; // while nBranch is 1,it means current instruction is bnq 
input Jmp; // while Jmp 1,it means current instruction is jump 
input Jal; // while Jal is 1,it means current instruction is jal 
input Jr; // while Jr is 1,it means current instruction is jr
input [31:0] Instruction;
reg[31:0] PC, Next_PC; 
always @* begin 
    if(((Branch == 1) && (Zero == 1 )) || ((nBranch == 1) && (Zero == 0))) // beq, bne 
        Next_PC = Addr_result << 2; // the calculated new value for PC 
    else if(Jr == 1) Next_PC = Read_data_1 << 2; // the value of $31 register 
    else if ((Jmp == 1) || (Jal == 1)) Next_PC = {PC[31:28], Instruction[25:0], 2'b00};
    else Next_PC = PC + 4; // PC+4 
end 
always @(reset, negedge clock) begin 
    if(reset == 1) PC <= 32'h0000_0000; 
    else PC <= Next_PC; 
end
always @(Jal, Jmp, negedge clock)
begin
    if ((Jmp == 1) || (Jal == 1)) 
        link_addr <= (PC + 4) >> 2;
    else
        link_addr <= link_addr;
end
assign branch_base_addr = PC + 4;
assign pco = PC;
assign Instruction_out = Instruction;
endmodule