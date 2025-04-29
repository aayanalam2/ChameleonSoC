//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for Unique Switch Blocks[2][0]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Tue Apr 29 15:56:25 2025
//-------------------------------------------
//----- Time scale -----
`timescale 1ns / 1ps

//----- Default net type -----
`default_nettype none

// ----- Verilog module for sb_2__0_ -----
module sb_2__0_(pReset,
                prog_clk,
                chany_top_in,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_5_,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_9_,
                top_right_grid_left_width_0_height_0_subtile_0__pin_O_3_,
                top_right_grid_left_width_0_height_0_subtile_0__pin_O_7_,
                chanx_right_in,
                right_top_grid_bottom_width_0_height_0_subtile_0__pin_O_2_,
                right_top_grid_bottom_width_0_height_0_subtile_0__pin_O_6_,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_,
                chanx_left_in,
                left_top_grid_bottom_width_0_height_0_subtile_0__pin_O_2_,
                left_top_grid_bottom_width_0_height_0_subtile_0__pin_O_6_,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_,
                ccff_head,
                chany_top_out,
                chanx_right_out,
                chanx_left_out,
                ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:14] chany_top_in;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_5_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_9_;
//----- INPUT PORTS -----
input [0:0] top_right_grid_left_width_0_height_0_subtile_0__pin_O_3_;
//----- INPUT PORTS -----
input [0:0] top_right_grid_left_width_0_height_0_subtile_0__pin_O_7_;
//----- INPUT PORTS -----
input [0:14] chanx_right_in;
//----- INPUT PORTS -----
input [0:0] right_top_grid_bottom_width_0_height_0_subtile_0__pin_O_2_;
//----- INPUT PORTS -----
input [0:0] right_top_grid_bottom_width_0_height_0_subtile_0__pin_O_6_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:14] chanx_left_in;
//----- INPUT PORTS -----
input [0:0] left_top_grid_bottom_width_0_height_0_subtile_0__pin_O_2_;
//----- INPUT PORTS -----
input [0:0] left_top_grid_bottom_width_0_height_0_subtile_0__pin_O_6_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:14] chany_top_out;
//----- OUTPUT PORTS -----
output [0:14] chanx_right_out;
//----- OUTPUT PORTS -----
output [0:14] chanx_left_out;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:7] mux_2level_tapbuf_size10_0_sram;
wire [0:7] mux_2level_tapbuf_size10_0_sram_inv;
wire [0:7] mux_2level_tapbuf_size10_1_sram;
wire [0:7] mux_2level_tapbuf_size10_1_sram_inv;
wire [0:7] mux_2level_tapbuf_size10_2_sram;
wire [0:7] mux_2level_tapbuf_size10_2_sram_inv;
wire [0:7] mux_2level_tapbuf_size10_3_sram;
wire [0:7] mux_2level_tapbuf_size10_3_sram_inv;
wire [0:0] mux_2level_tapbuf_size10_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size10_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size10_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size10_mem_3_ccff_tail;
wire [0:1] mux_2level_tapbuf_size2_0_sram;
wire [0:1] mux_2level_tapbuf_size2_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_1_sram;
wire [0:1] mux_2level_tapbuf_size2_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_2_sram;
wire [0:1] mux_2level_tapbuf_size2_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_3_sram;
wire [0:1] mux_2level_tapbuf_size2_3_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_4_sram;
wire [0:1] mux_2level_tapbuf_size2_4_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_5_sram;
wire [0:1] mux_2level_tapbuf_size2_5_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_6_sram;
wire [0:1] mux_2level_tapbuf_size2_6_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_7_sram;
wire [0:1] mux_2level_tapbuf_size2_7_sram_inv;
wire [0:0] mux_2level_tapbuf_size2_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_4_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_5_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_6_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_7_ccff_tail;
wire [0:1] mux_2level_tapbuf_size3_0_sram;
wire [0:1] mux_2level_tapbuf_size3_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size3_1_sram;
wire [0:1] mux_2level_tapbuf_size3_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size3_2_sram;
wire [0:1] mux_2level_tapbuf_size3_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size3_3_sram;
wire [0:1] mux_2level_tapbuf_size3_3_sram_inv;
wire [0:1] mux_2level_tapbuf_size3_4_sram;
wire [0:1] mux_2level_tapbuf_size3_4_sram_inv;
wire [0:1] mux_2level_tapbuf_size3_5_sram;
wire [0:1] mux_2level_tapbuf_size3_5_sram_inv;
wire [0:1] mux_2level_tapbuf_size3_6_sram;
wire [0:1] mux_2level_tapbuf_size3_6_sram_inv;
wire [0:0] mux_2level_tapbuf_size3_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size3_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size3_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size3_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size3_mem_4_ccff_tail;
wire [0:0] mux_2level_tapbuf_size3_mem_5_ccff_tail;
wire [0:0] mux_2level_tapbuf_size3_mem_6_ccff_tail;
wire [0:7] mux_2level_tapbuf_size9_0_sram;
wire [0:7] mux_2level_tapbuf_size9_0_sram_inv;
wire [0:7] mux_2level_tapbuf_size9_1_sram;
wire [0:7] mux_2level_tapbuf_size9_1_sram_inv;
wire [0:7] mux_2level_tapbuf_size9_2_sram;
wire [0:7] mux_2level_tapbuf_size9_2_sram_inv;
wire [0:7] mux_2level_tapbuf_size9_3_sram;
wire [0:7] mux_2level_tapbuf_size9_3_sram_inv;
wire [0:0] mux_2level_tapbuf_size9_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size9_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size9_mem_2_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- Local connection due to Wire 20 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[0] = chanx_right_in[0];
// ----- Local connection due to Wire 21 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[1] = chanx_right_in[1];
// ----- Local connection due to Wire 23 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[3] = chanx_right_in[3];
// ----- Local connection due to Wire 24 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[4] = chanx_right_in[4];
// ----- Local connection due to Wire 25 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[5] = chanx_right_in[5];
// ----- Local connection due to Wire 27 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[7] = chanx_right_in[7];
// ----- Local connection due to Wire 28 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[8] = chanx_right_in[8];
// ----- Local connection due to Wire 29 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[9] = chanx_right_in[9];
// ----- Local connection due to Wire 31 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[11] = chanx_right_in[11];
// ----- Local connection due to Wire 32 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[12] = chanx_right_in[12];
// ----- Local connection due to Wire 33 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[13] = chanx_right_in[13];
// ----- Local connection due to Wire 45 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[0] = chanx_left_in[0];
// ----- Local connection due to Wire 46 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[1] = chanx_left_in[1];
// ----- Local connection due to Wire 48 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[3] = chanx_left_in[3];
// ----- Local connection due to Wire 49 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[4] = chanx_left_in[4];
// ----- Local connection due to Wire 50 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[5] = chanx_left_in[5];
// ----- Local connection due to Wire 52 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[7] = chanx_left_in[7];
// ----- Local connection due to Wire 53 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[8] = chanx_left_in[8];
// ----- Local connection due to Wire 54 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[9] = chanx_left_in[9];
// ----- Local connection due to Wire 56 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[11] = chanx_left_in[11];
// ----- Local connection due to Wire 57 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[12] = chanx_left_in[12];
// ----- Local connection due to Wire 58 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[13] = chanx_left_in[13];
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	mux_2level_tapbuf_size3 mux_top_track_0 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_, chanx_right_in[6], chanx_left_in[2]}),
		.sram(mux_2level_tapbuf_size3_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_0_sram_inv[0:1]),
		.out(chany_top_out[0]));

	mux_2level_tapbuf_size3 mux_top_track_2 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_, chanx_right_in[10], chanx_left_in[13]}),
		.sram(mux_2level_tapbuf_size3_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_1_sram_inv[0:1]),
		.out(chany_top_out[1]));

	mux_2level_tapbuf_size3 mux_top_track_4 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_5_, chanx_right_in[14], chanx_left_in[12]}),
		.sram(mux_2level_tapbuf_size3_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_2_sram_inv[0:1]),
		.out(chany_top_out[2]));

	mux_2level_tapbuf_size3 mux_top_track_6 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_9_, chanx_right_in[0], chanx_left_in[11]}),
		.sram(mux_2level_tapbuf_size3_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_3_sram_inv[0:1]),
		.out(chany_top_out[3]));

	mux_2level_tapbuf_size3 mux_top_track_8 (
		.in({top_right_grid_left_width_0_height_0_subtile_0__pin_O_3_, chanx_right_in[1], chanx_left_in[9]}),
		.sram(mux_2level_tapbuf_size3_4_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_4_sram_inv[0:1]),
		.out(chany_top_out[4]));

	mux_2level_tapbuf_size3 mux_top_track_10 (
		.in({top_right_grid_left_width_0_height_0_subtile_0__pin_O_3_, chanx_right_in[3], chanx_left_in[8]}),
		.sram(mux_2level_tapbuf_size3_5_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_5_sram_inv[0:1]),
		.out(chany_top_out[5]));

	mux_2level_tapbuf_size3 mux_top_track_12 (
		.in({top_right_grid_left_width_0_height_0_subtile_0__pin_O_7_, chanx_right_in[4], chanx_left_in[7]}),
		.sram(mux_2level_tapbuf_size3_6_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_6_sram_inv[0:1]),
		.out(chany_top_out[6]));

	mux_2level_tapbuf_size3_mem mem_top_track_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(mux_2level_tapbuf_size3_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_0_sram_inv[0:1]));

	mux_2level_tapbuf_size3_mem mem_top_track_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_1_sram_inv[0:1]));

	mux_2level_tapbuf_size3_mem mem_top_track_4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_2_sram_inv[0:1]));

	mux_2level_tapbuf_size3_mem mem_top_track_6 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_3_sram_inv[0:1]));

	mux_2level_tapbuf_size3_mem mem_top_track_8 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_4_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_4_sram_inv[0:1]));

	mux_2level_tapbuf_size3_mem mem_top_track_10 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_4_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_5_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_5_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_5_sram_inv[0:1]));

	mux_2level_tapbuf_size3_mem mem_top_track_12 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_5_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_6_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_6_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_6_sram_inv[0:1]));

	mux_2level_tapbuf_size2 mux_top_track_14 (
		.in({chanx_right_in[5], chanx_left_in[5]}),
		.sram(mux_2level_tapbuf_size2_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_0_sram_inv[0:1]),
		.out(chany_top_out[7]));

	mux_2level_tapbuf_size2 mux_top_track_16 (
		.in({chanx_right_in[7], chanx_left_in[4]}),
		.sram(mux_2level_tapbuf_size2_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_1_sram_inv[0:1]),
		.out(chany_top_out[8]));

	mux_2level_tapbuf_size2 mux_top_track_18 (
		.in({chanx_right_in[8], chanx_left_in[3]}),
		.sram(mux_2level_tapbuf_size2_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_2_sram_inv[0:1]),
		.out(chany_top_out[9]));

	mux_2level_tapbuf_size2 mux_top_track_20 (
		.in({chanx_right_in[9], chanx_left_in[1]}),
		.sram(mux_2level_tapbuf_size2_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_3_sram_inv[0:1]),
		.out(chany_top_out[10]));

	mux_2level_tapbuf_size2 mux_top_track_22 (
		.in({chanx_right_in[11], chanx_left_in[0]}),
		.sram(mux_2level_tapbuf_size2_4_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_4_sram_inv[0:1]),
		.out(chany_top_out[11]));

	mux_2level_tapbuf_size2 mux_top_track_24 (
		.in({chanx_right_in[12], chanx_left_in[14]}),
		.sram(mux_2level_tapbuf_size2_5_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_5_sram_inv[0:1]),
		.out(chany_top_out[12]));

	mux_2level_tapbuf_size2 mux_top_track_26 (
		.in({chanx_right_in[13], chanx_left_in[10]}),
		.sram(mux_2level_tapbuf_size2_6_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_6_sram_inv[0:1]),
		.out(chany_top_out[13]));

	mux_2level_tapbuf_size2 mux_top_track_28 (
		.in({chanx_right_in[2], chanx_left_in[6]}),
		.sram(mux_2level_tapbuf_size2_7_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_7_sram_inv[0:1]),
		.out(chany_top_out[14]));

	mux_2level_tapbuf_size2_mem mem_top_track_14 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_6_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_0_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_16 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_1_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_18 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_2_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_20 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_3_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_22 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_4_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_4_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_24 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_5_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_5_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_26 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_6_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_6_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_28 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_7_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_7_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_7_sram_inv[0:1]));

	mux_2level_tapbuf_size9 mux_right_track_4 (
		.in({chany_top_in[3], chany_top_in[7], chany_top_in[11], right_top_grid_bottom_width_0_height_0_subtile_0__pin_O_2_, right_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_, chanx_left_in[2]}),
		.sram(mux_2level_tapbuf_size9_0_sram[0:7]),
		.sram_inv(mux_2level_tapbuf_size9_0_sram_inv[0:7]),
		.out(chanx_right_out[2]));

	mux_2level_tapbuf_size9 mux_right_track_28 (
		.in({chany_top_in[2], chany_top_in[6], chany_top_in[10], chany_top_in[14], right_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_, chanx_left_in[14]}),
		.sram(mux_2level_tapbuf_size9_1_sram[0:7]),
		.sram_inv(mux_2level_tapbuf_size9_1_sram_inv[0:7]),
		.out(chanx_right_out[14]));

	mux_2level_tapbuf_size9 mux_left_track_13 (
		.in({chany_top_in[3], chany_top_in[7], chany_top_in[11], chanx_right_in[6], left_top_grid_bottom_width_0_height_0_subtile_0__pin_O_2_, left_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size9_2_sram[0:7]),
		.sram_inv(mux_2level_tapbuf_size9_2_sram_inv[0:7]),
		.out(chanx_left_out[6]));

	mux_2level_tapbuf_size9 mux_left_track_29 (
		.in({chany_top_in[1], chany_top_in[5], chany_top_in[9], chany_top_in[13], chanx_right_in[14], left_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size9_3_sram[0:7]),
		.sram_inv(mux_2level_tapbuf_size9_3_sram_inv[0:7]),
		.out(chanx_left_out[14]));

	mux_2level_tapbuf_size9_mem mem_right_track_4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_7_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size9_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size9_0_sram[0:7]),
		.mem_outb(mux_2level_tapbuf_size9_0_sram_inv[0:7]));

	mux_2level_tapbuf_size9_mem mem_right_track_28 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size10_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size9_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size9_1_sram[0:7]),
		.mem_outb(mux_2level_tapbuf_size9_1_sram_inv[0:7]));

	mux_2level_tapbuf_size9_mem mem_left_track_13 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size10_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size9_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size9_2_sram[0:7]),
		.mem_outb(mux_2level_tapbuf_size9_2_sram_inv[0:7]));

	mux_2level_tapbuf_size9_mem mem_left_track_29 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size10_mem_3_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_2level_tapbuf_size9_3_sram[0:7]),
		.mem_outb(mux_2level_tapbuf_size9_3_sram_inv[0:7]));

	mux_2level_tapbuf_size10 mux_right_track_12 (
		.in({chany_top_in[0], chany_top_in[4], chany_top_in[8], chany_top_in[12], right_top_grid_bottom_width_0_height_0_subtile_0__pin_O_2_, right_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_, chanx_left_in[6]}),
		.sram(mux_2level_tapbuf_size10_0_sram[0:7]),
		.sram_inv(mux_2level_tapbuf_size10_0_sram_inv[0:7]),
		.out(chanx_right_out[6]));

	mux_2level_tapbuf_size10 mux_right_track_20 (
		.in({chany_top_in[1], chany_top_in[5], chany_top_in[9], chany_top_in[13], right_top_grid_bottom_width_0_height_0_subtile_0__pin_O_6_, right_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_, chanx_left_in[10]}),
		.sram(mux_2level_tapbuf_size10_1_sram[0:7]),
		.sram_inv(mux_2level_tapbuf_size10_1_sram_inv[0:7]),
		.out(chanx_right_out[10]));

	mux_2level_tapbuf_size10 mux_left_track_5 (
		.in({chany_top_in[0], chany_top_in[4], chany_top_in[8], chany_top_in[12], chanx_right_in[2], left_top_grid_bottom_width_0_height_0_subtile_0__pin_O_2_, left_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size10_2_sram[0:7]),
		.sram_inv(mux_2level_tapbuf_size10_2_sram_inv[0:7]),
		.out(chanx_left_out[2]));

	mux_2level_tapbuf_size10 mux_left_track_21 (
		.in({chany_top_in[2], chany_top_in[6], chany_top_in[10], chany_top_in[14], chanx_right_in[10], left_top_grid_bottom_width_0_height_0_subtile_0__pin_O_6_, left_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size10_3_sram[0:7]),
		.sram_inv(mux_2level_tapbuf_size10_3_sram_inv[0:7]),
		.out(chanx_left_out[10]));

	mux_2level_tapbuf_size10_mem mem_right_track_12 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size9_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size10_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size10_0_sram[0:7]),
		.mem_outb(mux_2level_tapbuf_size10_0_sram_inv[0:7]));

	mux_2level_tapbuf_size10_mem mem_right_track_20 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size10_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size10_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size10_1_sram[0:7]),
		.mem_outb(mux_2level_tapbuf_size10_1_sram_inv[0:7]));

	mux_2level_tapbuf_size10_mem mem_left_track_5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size9_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size10_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size10_2_sram[0:7]),
		.mem_outb(mux_2level_tapbuf_size10_2_sram_inv[0:7]));

	mux_2level_tapbuf_size10_mem mem_left_track_21 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size9_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size10_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size10_3_sram[0:7]),
		.mem_outb(mux_2level_tapbuf_size10_3_sram_inv[0:7]));

endmodule
// ----- END Verilog module for sb_2__0_ -----

//----- Default net type -----
`default_nettype none



