//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Fabric Netlist Summary
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Tue Apr 29 16:10:15 2025
//-------------------------------------------
//----- Time scale -----
`timescale 1ns / 1ps

// ------ Include defines: preproc flags -----
`include "./uart_receiver/SRC/fpga_defines.v"

// ------ Include user-defined netlists -----
`include "./SRC/verilog/dff.v"
`include "./SRC/verilog/gpio.v"
// ------ Include primitive module netlists -----
`include "./uart_receiver/SRC/sub_module/inv_buf_passgate.v"
`include "./uart_receiver/SRC/sub_module/arch_encoder.v"
`include "./uart_receiver/SRC/sub_module/local_encoder.v"
`include "./uart_receiver/SRC/sub_module/mux_primitives.v"
`include "./uart_receiver/SRC/sub_module/muxes.v"
`include "./uart_receiver/SRC/sub_module/luts.v"
`include "./uart_receiver/SRC/sub_module/wires.v"
`include "./uart_receiver/SRC/sub_module/memories.v"
`include "./uart_receiver/SRC/sub_module/shift_register_banks.v"

// ------ Include logic block netlists -----
`include "./uart_receiver/SRC/lb/logical_tile_io_mode_physical__iopad.v"
`include "./uart_receiver/SRC/lb/logical_tile_io_mode_io_.v"
`include "./uart_receiver/SRC/lb/logical_tile_clb_mode_default__fle_mode_n1_lut6__ble6_mode_default__lut6.v"
`include "./uart_receiver/SRC/lb/logical_tile_clb_mode_default__fle_mode_n1_lut6__ble6_mode_default__ff.v"
`include "./uart_receiver/SRC/lb/logical_tile_clb_mode_default__fle_mode_n1_lut6__ble6.v"
`include "./uart_receiver/SRC/lb/logical_tile_clb_mode_default__fle.v"
`include "./uart_receiver/SRC/lb/logical_tile_clb_mode_clb_.v"
`include "./uart_receiver/SRC/lb/grid_io_top.v"
`include "./uart_receiver/SRC/lb/grid_io_right.v"
`include "./uart_receiver/SRC/lb/grid_io_bottom.v"
`include "./uart_receiver/SRC/lb/grid_io_left.v"
`include "./uart_receiver/SRC/lb/grid_clb.v"

// ------ Include routing module netlists -----
`include "./uart_receiver/SRC/routing/sb_0__0_.v"
`include "./uart_receiver/SRC/routing/sb_0__1_.v"
`include "./uart_receiver/SRC/routing/sb_0__2_.v"
`include "./uart_receiver/SRC/routing/sb_0__3_.v"
`include "./uart_receiver/SRC/routing/sb_1__0_.v"
`include "./uart_receiver/SRC/routing/sb_1__1_.v"
`include "./uart_receiver/SRC/routing/sb_1__2_.v"
`include "./uart_receiver/SRC/routing/sb_1__3_.v"
`include "./uart_receiver/SRC/routing/sb_2__0_.v"
`include "./uart_receiver/SRC/routing/sb_2__2_.v"
`include "./uart_receiver/SRC/routing/sb_2__3_.v"
`include "./uart_receiver/SRC/routing/sb_3__0_.v"
`include "./uart_receiver/SRC/routing/sb_3__1_.v"
`include "./uart_receiver/SRC/routing/sb_3__2_.v"
`include "./uart_receiver/SRC/routing/sb_3__3_.v"
`include "./uart_receiver/SRC/routing/cbx_1__0_.v"
`include "./uart_receiver/SRC/routing/cbx_1__1_.v"
`include "./uart_receiver/SRC/routing/cbx_1__2_.v"
`include "./uart_receiver/SRC/routing/cbx_1__3_.v"
`include "./uart_receiver/SRC/routing/cbx_2__0_.v"
`include "./uart_receiver/SRC/routing/cbx_2__2_.v"
`include "./uart_receiver/SRC/routing/cbx_2__3_.v"
`include "./uart_receiver/SRC/routing/cbx_3__0_.v"
`include "./uart_receiver/SRC/routing/cbx_3__2_.v"
`include "./uart_receiver/SRC/routing/cbx_3__3_.v"
`include "./uart_receiver/SRC/routing/cby_0__1_.v"
`include "./uart_receiver/SRC/routing/cby_0__2_.v"
`include "./uart_receiver/SRC/routing/cby_0__3_.v"
`include "./uart_receiver/SRC/routing/cby_1__1_.v"
`include "./uart_receiver/SRC/routing/cby_1__2_.v"
`include "./uart_receiver/SRC/routing/cby_1__3_.v"
`include "./uart_receiver/SRC/routing/cby_2__3_.v"
`include "./uart_receiver/SRC/routing/cby_3__1_.v"
`include "./uart_receiver/SRC/routing/cby_3__2_.v"
`include "./uart_receiver/SRC/routing/cby_3__3_.v"

// ------ Include fabric top-level netlists -----
`include "./uart_receiver/SRC/fpga_top.v"

