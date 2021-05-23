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
output reg [31:0] pco;
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

reg[31:0] next_PC;
assign branch_base_addr = pco + 4;


always @(Jal or Jmp or clock) begin
    if(Jmp == 1 || Jal == 1)begin
        link_addr <= (pco + 4) >> 2;
    end
end

always @(negedge clock) begin
    if(reset)begin
        pco <= 32'h0000_0000;
    end
    else begin
        if((Branch == 1 && Zero == 1)||(nBranch == 1 && Zero == 0))begin
            pco <= Addr_result<< 2;// the calculated new value for PC
        end
        else if(Jr)begin
            pco <= Read_data_1<< 2;// the value of $31 register
        end
        else if ((Jmp == 1) || (Jal == 1))begin
            pco <= {pco[31:28], Instruction[25:0], 2'b00};
        end
        else begin
            pco <= pco+4;// PC+4
        end
    end
end

assign Instruction_out = Instruction;
endmodule