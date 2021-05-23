`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/27 11:52:32
// Design Name: 
// Module Name: Executs32
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


module Executs32 (
//input fpga_clk,
// from decoder 
input[31:0] Read_data_1,
//the source of Ainput 
input[31:0] Read_data_2,
//one of the sources of Binput 
input[31:0] Imme_extend,
//one of the sources of Binput 
// from ifetch 
input[5:0] Function_opcode,
//instructions[5:0] 
input[5:0] opcode,
//instruction[31:26] 
input[4:0] Shamt,
// instruction[10:6], the amount of shift bits 
input[31:0] PC_plus_4,
// pc+4 
// from controller 
input[1:0] ALUOp,
//{ (R_format || I_format) , (Branch || nBranch) } 
input ALUSrc,
// 1 means the 2nd operand is an immedite (except beq£¬bne£© 
input I_format,
// 1 means I-Type instruction except beq, bne, LW, SW 
input Sftmd,
// 1 means this is a shift instruction 
input Jr,
// 1 means this is a jr instruction
output Zero,
// 1 means the ALU_result is zero, 0 otherwise 
output reg [31:0] ALU_Result,
// the ALU calculation result
output [31:0] Addr_Result
// the calculated instruction address
); 
wire[31:0] Ainput,Binput;
// two operands for calculation 
wire[5:0] Exe_code; 
// use to generate ALU_ctrl. (I_format==0) ? Function_opcode : { 3'b000 , Opcode[2:0] }; 
wire[2:0] ALU_ctl; 
// the control signals which affact operation in ALU directely 
wire[5:0] Sftm; 
// identify the types of shift instruction, equals to Function_opcode[2:0] 
reg[31:0] ALU_output_mux; 
// the result of arithmetic or logic calculation 
reg[31:0] Shift_Result; 
// the result of shift operation 
wire[32:0] Branch_Addr; 
// the calculated address of the instruction, Addr_Result is Branch_Addr[31:0]

reg [31:0] lo;
reg [31:0] hi;
/*
reg [31:0] product_A;
reg [31:0] product_B;
wire [63:0] result;
mult_ip mul(.CLK(fpga_clk),.A(product_A),.B(product_B),.P(result));
reg from_mul;
reg [31:0] div_A;
reg [31:0] div_B;
reg [31:0] A;
reg [31:0] B;
wire [63:0] div_result;
reg from_div;
reg s_axis_dividend_tvalid;
reg s_axis_divisor_tvalid;
div_ip div(.aclk(fpga_clk),.s_axis_divisor_tvalid(s_axis_divisor_tvalid),
.s_axis_divisor_tdata (A),.s_axis_dividend_tvalid(s_axis_dividend_tvalid),
.s_axis_dividend_tdata (B),.m_axis_dout_tdata (div_result));

always @(posedge fpga_clk)
begin
if(from_div && s_axis_dividend_tvalid==0)begin 
    A=div_A;
    s_axis_dividend_tvalid=1;
end
else s_axis_dividend_tvalid=0;
if(from_div && s_axis_divisor_tvalid==0)begin
    B=div_B;
    s_axis_divisor_tvalid=1;
end
else s_axis_divisor_tvalid=0;
end//*/

assign Ainput = Read_data_1; 
assign Binput = (ALUSrc == 0) ? Read_data_2 : Imme_extend[31:0];
assign Exe_code = (I_format==0) ? Function_opcode : { 3'b000 , opcode[2:0] };
assign ALU_ctl[0] = (Exe_code[0] | Exe_code[3]) & ALUOp[1]; 
assign ALU_ctl[1] = ((!Exe_code[2]) | (!ALUOp[1])); 
assign ALU_ctl[2] = (Exe_code[1] & ALUOp[1]) | ALUOp[0];
assign Sftm = Function_opcode[5:0];

always @ (ALU_ctl or Ainput or Binput)
begin case (ALU_ctl)
    3'b000:ALU_output_mux = Ainput & Binput;
    3'b001:ALU_output_mux = Ainput | Binput;
    3'b010:ALU_output_mux = Ainput + Binput;
    3'b011:ALU_output_mux = Ainput + Binput;
    3'b100:ALU_output_mux = Ainput ^ Binput;
    3'b101:ALU_output_mux = ~(Ainput | Binput);
    3'b110:ALU_output_mux = Ainput - Binput;
    3'b111:ALU_output_mux = Ainput - Binput;
    default:ALU_output_mux = 32'h00000000; 
endcase 
end
always @(*/*Sftm or Sftmd or ALU_ctl or ALU_output_mux or I_format or Exe_code*/) begin 
    if(Sftmd) 
    begin
        case(Sftm[5:0]) 
            6'b0000:Shift_Result = Binput << Shamt; //Sll rd,rt,shamt 00000 
            6'b0010:Shift_Result = Binput >> Shamt; //Srl rd,rt,shamt 00010 
            6'b0100:Shift_Result = Binput << Ainput; //Sllv rd,rt,rs 000100 
            6'b0110:Shift_Result = Binput >> Ainput; //Srlv rd,rt,rs 000110 
            6'b0011:Shift_Result = $signed(Binput) >>> Shamt; //Sra rd,rt,shamt 00011 
            6'b0111:Shift_Result = $signed(Binput) >>> Ainput; //Srav rd,rt,rs 00111 
            6'b11010:begin//div rs rt
                 //div_A=Ainput;
                 //div_B=Binput;
                 hi = Ainput % Binput;
                 lo = Ainput / Binput;
                 //from_div=1;
                 //from_mul=0;
            end
            6'b11000:begin//mult rs rt
            {hi,lo} = Ainput* Binput;
                 //product_A=Ainput;
                 //product_B=Binput;
                 //from_mul=1;
                 //from_div=0;
            end
            6'b10000:begin//mfhi rd
            //if(from_mul){hi,lo}=result;
            //if(from_div){hi,lo}=div_result;
            Shift_Result = hi;
            end
            6'b10010:begin//mflo rd
            //if(from_mul){hi,lo}=result;
            //if(from_div){hi,lo}=div_result;
            Shift_Result = lo;
            end
            6'b10001:begin//mthi  rs
            hi = Ainput;
            //from_mul=0;
            //from_div=0;
            end
            6'b10011:begin//mtlo  rs
            lo = Ainput;
            //from_mul=0;
            //from_div=0;
            end

            default:Shift_Result = Binput; 
        endcase end
    else Shift_Result = Binput; 
if(((ALU_ctl==3'b111) && (Exe_code[3]==1))||((ALU_ctl[2:1]==2'b11) && (I_format==1))) ALU_Result = ALU_output_mux[31]==1 ? 1:0; 
//lui operation 
else if((ALU_ctl==3'b101) && (I_format==1)) ALU_Result[31:0]={Binput[15:0],{16{1'b0}}}; 
//shift operation 
else if(Sftmd==1) ALU_Result = Shift_Result ; 
//other types of operation in ALU (arithmatic or logic calculation) 
else ALU_Result = ALU_output_mux[31:0]; 
end

assign Zero = (ALU_output_mux == 32'b0) ? 1'b1 : 1'b0;
assign Branch_Addr = PC_plus_4[31:2] + Imme_extend;
assign Addr_Result = Branch_Addr[31:0];
endmodule
