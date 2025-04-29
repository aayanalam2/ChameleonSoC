//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Fabric Netlist Summary
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Tue Apr 29 16:04:43 2025
//-------------------------------------------
//----- Time scale -----
`timescale 1ns / 1ps

// ------ Include defines: preproc flags -----
`include "./SRC/fpga_defines.v"

// ------ Include user-defined netlists -----
`include "/home/fizza/OpenFPGA/openfpga_flow/openfpga_cell_library/verilog/dff.v"
`include "/home/fizza/OpenFPGA/openfpga_flow/openfpga_cell_library/verilog/gpio.v"
// ------ Include primitive module netlists -----
`include "./SRC/sub_module/inv_buf_passgate.v"
`include "./SRC/sub_module/arch_encoder.v"
`include "./SRC/sub_module/local_encoder.v"
`include "./SRC/sub_module/mux_primitives.v"
`include "./SRC/sub_module/muxes.v"
`include "./SRC/sub_module/luts.v"
`include "./SRC/sub_module/wires.v"
`include "./SRC/sub_module/memories.v"
`include "./SRC/sub_module/shift_register_banks.v"

// ------ Include logic block netlists -----
`include "./SRC/lb/logical_tile_io_mode_physical__iopad.v"
`include "./SRC/lb/logical_tile_io_mode_io_.v"
`include "./SRC/lb/logical_tile_clb_mode_default__fle_mode_n1_lut6__ble6_mode_default__lut6.v"
`include "./SRC/lb/logical_tile_clb_mode_default__fle_mode_n1_lut6__ble6_mode_default__ff.v"
`include "./SRC/lb/logical_tile_clb_mode_default__fle_mode_n1_lut6__ble6.v"
`include "./SRC/lb/logical_tile_clb_mode_default__fle.v"
`include "./SRC/lb/logical_tile_clb_mode_clb_.v"
`include "./SRC/lb/grid_io_top.v"
`include "./SRC/lb/grid_io_right.v"
`include "./SRC/lb/grid_io_bottom.v"
`include "./SRC/lb/grid_io_left.v"
`include "./SRC/lb/grid_clb.v"

// ------ Include routing module netlists -----
`include "./SRC/routing/sb_0__0_.v"
`include "./SRC/routing/sb_0__1_.v"
`include "./SRC/routing/sb_0__2_.v"
`include "./SRC/routing/sb_0__3_.v"
`include "./SRC/routing/sb_0__4_.v"
`include "./SRC/routing/sb_0__6_.v"
`include "./SRC/routing/sb_1__0_.v"
`include "./SRC/routing/sb_1__1_.v"
`include "./SRC/routing/sb_1__2_.v"
`include "./SRC/routing/sb_1__3_.v"
`include "./SRC/routing/sb_1__4_.v"
`include "./SRC/routing/sb_1__6_.v"
`include "./SRC/routing/sb_2__0_.v"
`include "./SRC/routing/sb_2__6_.v"
`include "./SRC/routing/sb_3__0_.v"
`include "./SRC/routing/sb_3__6_.v"
`include "./SRC/routing/sb_4__0_.v"
`include "./SRC/routing/sb_4__6_.v"
`include "./SRC/routing/sb_6__0_.v"
`include "./SRC/routing/sb_6__1_.v"
`include "./SRC/routing/sb_6__2_.v"
`include "./SRC/routing/sb_6__3_.v"
`include "./SRC/routing/sb_6__4_.v"
`include "./SRC/routing/sb_6__6_.v"
`include "./SRC/routing/cbx_1__0_.v"
`include "./SRC/routing/cbx_1__1_.v"
`include "./SRC/routing/cbx_1__2_.v"
`include "./SRC/routing/cbx_1__3_.v"
`include "./SRC/routing/cbx_1__4_.v"
`include "./SRC/routing/cbx_1__6_.v"
`include "./SRC/routing/cbx_2__0_.v"
`include "./SRC/routing/cbx_2__6_.v"
`include "./SRC/routing/cbx_3__0_.v"
`include "./SRC/routing/cbx_3__6_.v"
`include "./SRC/routing/cbx_4__0_.v"
`include "./SRC/routing/cbx_4__6_.v"
`include "./SRC/routing/cby_0__1_.v"
`include "./SRC/routing/cby_0__2_.v"
`include "./SRC/routing/cby_0__3_.v"
`include "./SRC/routing/cby_0__4_.v"
`include "./SRC/routing/cby_1__1_.v"
`include "./SRC/routing/cby_1__2_.v"
`include "./SRC/routing/cby_1__3_.v"
`include "./SRC/routing/cby_1__4_.v"
`include "./SRC/routing/cby_6__1_.v"
`include "./SRC/routing/cby_6__2_.v"
`include "./SRC/routing/cby_6__3_.v"
`include "./SRC/routing/cby_6__4_.v"

// ------ Include fabric top-level netlists -----
`include "./SRC/fpga_top.v"

