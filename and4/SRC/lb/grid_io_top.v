//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for physical tile: io]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat May  3 23:32:30 2025
//-------------------------------------------
//----- Time scale -----
`timescale 1ns / 1ps

// ----- BEGIN Grid Verilog module: grid_io_top -----
//----- Default net type -----
`default_nettype none

// ----- Verilog module for grid_io_top -----
module grid_io_top(pReset,
                   prog_clk,
                   gfpga_pad_GPIO_PAD,
                   bottom_width_0_height_0_subtile_0__pin_outpad_0_,
                   bottom_width_0_height_0_subtile_1__pin_outpad_0_,
                   ccff_head,
                   bottom_width_0_height_0_subtile_0__pin_inpad_0_,
                   bottom_width_0_height_0_subtile_1__pin_inpad_0_,
                   ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- GPIO PORTS -----
inout [0:1] gfpga_pad_GPIO_PAD;
//----- INPUT PORTS -----
input [0:0] bottom_width_0_height_0_subtile_0__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_width_0_height_0_subtile_1__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] bottom_width_0_height_0_subtile_0__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] bottom_width_0_height_0_subtile_1__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] logical_tile_io_mode_io__0_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	logical_tile_io_mode_io_ logical_tile_io_mode_io__0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[0]),
		.io_outpad(bottom_width_0_height_0_subtile_0__pin_outpad_0_),
		.ccff_head(ccff_head),
		.io_inpad(bottom_width_0_height_0_subtile_0__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__0_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[1]),
		.io_outpad(bottom_width_0_height_0_subtile_1__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__0_ccff_tail),
		.io_inpad(bottom_width_0_height_0_subtile_1__pin_inpad_0_),
		.ccff_tail(ccff_tail));

endmodule
// ----- END Verilog module for grid_io_top -----

//----- Default net type -----
`default_nettype none



// ----- END Grid Verilog module: grid_io_top -----

