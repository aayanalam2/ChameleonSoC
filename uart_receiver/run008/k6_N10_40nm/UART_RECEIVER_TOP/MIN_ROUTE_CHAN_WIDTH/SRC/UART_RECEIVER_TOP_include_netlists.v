//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Netlist Summary
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Tue Apr 29 16:05:51 2025
//-------------------------------------------
//----- Time scale -----
`timescale 1ns / 1ps

// ------ Include fabric top-level netlists -----
`include "./SRC/fabric_netlists.v"

`include "UART_RECEIVER_TOP_output_verilog.v"

`include "./SRC/UART_RECEIVER_TOP_autocheck_top_tb.v"
