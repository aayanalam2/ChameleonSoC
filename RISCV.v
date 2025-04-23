`include "ALU.v"
`include "BranchComparator.v"
`include "BussMux2x1.v"
`include "BussMux3x1.v"
`include "dMem.v"
`include "FCB.v"
`include "immediateGenerator.v"
`include "InstructionDecoder.v"
`include "MasterMemoryController.v"
`include "Program_memory.v"
`include "RegisterFile.v"
`include "fabric_netlists.v"
`include "PC.v"
`include "PCplus4.v"

module RISCV( clk, Test_variable, reset,gfpga_pad_GPIO_PAD, set, head, programming_clock);
input reset;
input clk;
input set;
output reg [31:0] Test_variable;
output head;
output programming_clock;
wire fpga_tail;
wire  fpga_head;
wire  prog_clk;
wire op_clk;
wire programming_reset;
wire greset;
inout [0:7] gfpga_pad_GPIO_PAD;
//Setting intermodule connection wires
wire [31:0] PC_added_4;
wire [31:0] ALU_result;
wire [31:0] PC_input;
wire [31:0] PC_out;
wire [31:0] Instruction_code;
wire PC_sel;
wire wb_ack;
//reg reset;
wire [4:0] RA,RB,RD;
wire [19:0] imm_gen_in;
wire [3:0] alu_selection;
wire reg_write_en;
wire mem_write_en;
wire [3:0] igensel;
wire A_SEL, B_SEL;
wire BrLT, BrEq, BrUn;
wire [2:0] load_type;
wire [1:0] store_type, WB_sel;
wire [31:0] sr1_data, sr2_data;
wire [31:0] write_back;
wire [31:0] Reg_4;
wire [31:0] imm_gen_out;
wire [31:0] alu_input1;
wire [31:0] alu_input2;
wire [31:0] data_mem_out;

wire [2:0] wb_address;   
wire [31:0] wb_data_out; 
wire wb_we;              
wire wb_bus_cycle;
wire [3:0] wb_select;
wire wb_stb;
wire [31:0] wb_data_in;
wire wb_hs;

wire [31:0] mem_addr;
wire mem_write;
wire [31:0] mem_data_in;
wire [0:2]mem_control;
wire [31:0] wbdata;
wire [31:0] writeback_data;
assign head = fpga_head;
assign programming_clock = prog_clk;
BussMux2x1 mux_pc_input( PC_added_4, ALU_result, PC_sel, PC_input);

PC PC1( PC_out, PC_input, clk, reset);

PCplus4 PCadd1( PC_out, PC_added_4);

Program_memory PM1( PC_out, Instruction_code);

InstructionDecoder cu1(Instruction_code,alu_selection, load_type ,A_SEL, B_SEL, PC_sel, mem_write_en, reg_write_en, reset, BrUn, BrEq, BrLT,igensel,WB_sel,RA,RB,RD);

RegisterFile RF1(sr1_data, sr2_data, RA, RB, reg_write_en, clk, reset, RD, write_back, Reg_4);

immediateGenerator IVG1(Instruction_code, igensel, reset, imm_gen_out);

BussMux2x1 alu_data1_sel( sr1_data, PC_out, A_SEL, alu_input1);

BussMux2x1 alu_data2_sel( sr2_data, imm_gen_out, B_SEL, alu_input2);

ALU alu1(ALU_result, alu_selection, alu_input1, alu_input2);

BranchComparator BC1( sr1_data, sr2_data, BrUn, BrLT, BrEq, reset);

MasterMemoryController MemC ( clk, reset, wb_address, wbdata, wb_we, wb_bus_cycle, wb_select, wb_stb, wb_data_out, mem_addr, mem_write,
mem_data_in, data_mem_out,  mem_control, mem_write_en, load_type, ALU_result, sr2_data, writeback_data);

dMem DM1(data_mem_out, clk, mem_write, mem_control, mem_addr, mem_data_in, reset);

FCB FabricB (clk, 
reset, wb_address, wb_data_out, wb_select, wb_stb, wb_we, wb_bus_cycle, wbdata,  fpga_tail, prog_clk, fpga_head, greset, op_clk, programming_reset);

//shiftreg SR (fpga_head, prog_clk, reset, fpga_tail);
fpga_top fabric(programming_reset,prog_clk,set,greset,op_clk,gfpga_pad_GPIO_PAD,fpga_head,fpga_tail);
BussMux3x1 write_back_mux( writeback_data, ALU_result, PC_added_4, WB_sel, write_back);

// For Fibonacci sequence

always@(*)
begin
	Test_variable = Reg_4;
end

endmodule
