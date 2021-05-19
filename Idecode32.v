`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/04 17:44:00
// Design Name: 
// Module Name: Idecode32
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


module Idecode32(
Instruction, read_data, ALU_result, Jal, RegWrite, MemtoReg, RegDst, clock, reset, opcplus4,
read_data_1, read_data_2, imme_extend
    );
input [31:0] Instruction;
input [31:0] read_data;
input [31:0] ALU_result;
input Jal; 
input RegWrite;
input MemtoReg;
input RegDst;
input clock,reset;
input [31:0] opcplus4;      // from ifetch link_address
// output
output reg[31:0] read_data_1;
output reg[31:0] read_data_2;
output reg[31:0] imme_extend;

reg[31:0] register[0:31];
reg[4:0] write_reg;
reg[4:0] pos;
integer i;

always @ *
begin
        read_data_1 = register[Instruction[25:21]];
        read_data_2 = register[Instruction[20:16]];
        if (Instruction[15] == 1'b0)
        begin
            imme_extend = {16'b0000_0000_0000_0000, Instruction[15:0]};
        end
        else
        begin
            imme_extend = {16'b1111_1111_1111_1111, Instruction[15:0]};
        end
        if (RegDst == 1)
        begin
            pos = Instruction[15:11];
        end
        else
        begin
            pos = Instruction[20:16];
        end
end

always @ (reset, posedge clock)
begin
    if (reset)
    begin
        for (i=0; i<=31; i=i+1)
        begin
            register[i] = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
        end
    end
    else
    begin
        if (RegWrite == 1)
        begin
            if (Jal == 1)
            begin
                register[31] = opcplus4;
            end
            else
            begin
                if (MemtoReg == 1)
                begin
                    register[pos] = read_data;
                end
                else
                begin
                    register[pos] = ALU_result;
                end
            end
        end
    end
end
endmodule
