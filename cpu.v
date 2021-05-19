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
BUFG U1(.clk(fpga_clk), .nrst(fpga_rst), .key_in(start_pg), .key_out(spg_bufg)); // de-twitter 
// Generate UART Programmer reset signal 
reg upg_rst; 
always @ (posedge fpga_clk) 
begin 
    if (spg_bufg) 
        upg_rst = 0; 
    if (fpga_rst) 
        upg_rst = 1; 
end
<<<<<<< HEAD
wire rst = fpga_rst | !upg_rst;


//uart的wires
wire upg_clk_w; //链接dmemory32
wire upg_wen_w; //链接dmemory32
wire[14:0] upg_adr_w; //链接dmemory32
wire[31:0] upg_dat_w; //链接dmemory32
wire upg_done_w; //链接dmemory32
wire upg_tx=tx;
wire upg_rx=rx;

uart_bmpg_0 uart(.upg_clk_i(upg_clk),.upg_rst_i(upg_rst),.upg_rx_i(upg_rx),
.upg_clk_o(upg_clk_w),.upg_wen_o(upg_wen_w),.upg_adr_o(upg_adr_w),.upg_dat_o(upg_dat_w),
.upg_done_o(upg_done_w),.upg_tx_o(upg_tx));

//dmeory32的wires
wire cpu_clk;
wire ram_wen_w;//链接controller
wire[13:0] ram_adr_w;//链接ALU的alu_result
wire[31:0] ram_dat_i_w;//链接decoder的read_data_2
wire[31:0] ram_dat_o_w;//
dmemory32_0 mem(.ram_clk_i(cpu_clk),.ram_wen_i(ram_wen_w),.ram_adr_i(ram_adr_w),
.ram_dat_i(ram_dat_i_w),.ram_dat_o(ram_dat_o_w),.upg_rst_i(upg_rst),.upg_clk_i(upg_clk_w),
.upg_wen_i(upg_wen_w),.upg_adr_i(upg_adr_w),.upg_dat_i(upg_dat_w),.upg_done_i(upg_done_w));


//coltroler的wires
wire[5:0] Opcode_w; // instruction[31..26] 
wire[5:0] Function_opcode_w; // instructions[5..0] 
wire Jr_w; // 1 indicates the instruction is "jr", otherwise it's not "jr" 
wire Jmp_w; // 1 indicate the instruction is "j", otherwise it's not 
wire Jal_w; // 1 indicate the instruction is "jal", otherwise it's not 
wire Branch_w; // 1 indicate the instruction is "beq" , otherwise it's not 
wire nBranch_w; // 1 indicate the instruction is "bne", otherwise it's not 
wire RegDST_w; // 1 indicate destination register is "rd",otherwise it's "rt" 
wire MemtoReg_w; // 1 indicate read data from memory and write it into register 
wire RegWrite_w; // 1 indicate write register, otherwise it's not 
wire MemWrite_w; // 1 indicate write data memory, otherwise it's not 
wire ALUSrc_w; //executs
wire I_format_w; //executs
wire Sftmd_w; // 1 indicate the instruction is shift instruction 
wire[1:0] ALUOp_w;
control32 control(.Opcode(Opcode_w),.Function_opcode(Function_opcode_w),.Jr(Jr_w),.RegDST(RegDST_w),.ALUSrc(ALUSrc_w), 
.MemtoReg(MemtoReg_w), .RegWrite(RegWrite_w), .MemWrite(ram_wen_w),.Branch(Branch_w), .nBranch(nBranch_w), 
.Jmp(Jmp_w), .Jal(Jal_w), .I_format(I_format_w), .Sftmd(Sftmd_w), .ALUOp(ALUOp_w));

// from decoder 
wire[31:0] Read_data_1_w; //the source of Ainput 
wire[31:0] Imme_extend_w; //one of the sources of Binput // from ifetch 
wire[4:0] Shamt_w; // instruction[10:6], the amount of shift bits 
wire[31:0] PC_plus_4_w; // pc+4 // from controller 
wire Zero_w; // 1 means the ALU_result is zero, 0 otherwise 
wire [31:0] Addr_Result_w; // the calculated instruction address
Executs32 executs(.Read_data_1(Read_data_1_w), .Read_data_2(ram_dat_i_w), .Imme_extend(Imme_extend_w),
.Function_opcode(Function_opcode_w), .opcode(Opcode_w), .ALUOp(ALUOp_w),
.Shamt(Shamt_w), .ALUSrc(ALUSrc_w), .I_format(I_format_w), .Zero(Zero_w), .Sftmd(Sftmd_w),
.ALU_Result(ram_adr_w), .Addr_Result(Addr_Result_w), .PC_plus_4(PC_plus_4_w), .Jr(Jr_w));


wire [31:0] Instruction_w;
wire [31:0] read_data_w;
wire RegDst_w;
wire [31:0] opcplus4_w;
Idecode32 decode(
.Instruction(Instruction_w), .read_data(read_data_w), .ALU_result(ram_adr_w), .Jal(Jal_w),
.RegWrite(RegWrite_w), .MemtoReg(MemtoReg_w), .RegDst(RegDst_w), .clock(cpu_clk), .reset(rst), .opcplus4(opcplus4_w),
.read_data_1(Read_data_1_w), .read_data_2(ram_dat_i_w), .imme_extend(Imme_extend_w));


=======
assign rst = fpga_rst | !upg_rst;
wire clk_out1, clk_out2;
cpuclk clk(.clk_in1(fpga_clk), .clk_out1(clk_out1), .clk_out2(clk_out2));
>>>>>>> 5821014505e17bc07fe19cc10ce36a21cca4fe54

endmodule
