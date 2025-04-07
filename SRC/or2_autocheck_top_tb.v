//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: FPGA Verilog full testbench for top-level netlist of design: or2
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Tue Feb 11 03:08:50 2025
//-------------------------------------------
//----- Time scale -----
`timescale 1ns / 1ps

//----- Default net type -----
`default_nettype none

module or2_autocheck_top_tb;
// ----- Local wires for global ports of FPGA fabric -----
wire [0:0] pReset;
wire [0:0] prog_clk;
wire [0:0] set;
wire [0:0] reset;
wire [0:0] clk;

// ----- Local wires for I/Os of FPGA fabric -----
wire [0:7] gfpga_pad_GPIO_PAD;



reg [0:0] __config_done__;
wire [0:0] __prog_clock__;
reg [0:0] __prog_clock___reg__;
wire [0:0] __op_clock__;
reg [0:0] __op_clock___reg__;
reg [0:0] __prog_reset__;
reg [0:0] __prog_set_;
reg [0:0] __greset__;
reg [0:0] __gset__;
// ---- Configuration-chain head -----
reg [0:0] ccff_head;
// ---- Configuration-chain tail -----
wire [0:0] ccff_tail;
// ----- Shared inputs -------
	reg [0:0] A_shared_input;
	reg [0:0] B_shared_input;

// ----- FPGA fabric outputs -------
	wire [0:0] Y_fpga;

// ----- Benchmark outputs -------
	wire [0:0] Y_benchmark;

// ----- Output vectors checking flags -------
	reg [0:0] Y_flag;

// ----- Error counter: Deposit an error for config_done signal is not raised at the beginning -----
	integer nb_error= 1;
// ----- Number of clock cycles in configuration phase: 2035 -----
// ----- Begin configuration done signal generation -----
initial
	begin
		__config_done__[0] = 1'b0;
	end

// ----- End configuration done signal generation -----

// ----- Begin raw programming clock signal generation -----
initial
	begin
		__prog_clock___reg__[0] = 1'b0;
	end
always
	begin
		#1.666666746	__prog_clock___reg__[0] = ~__prog_clock___reg__[0];
	end

// ----- End raw programming clock signal generation -----

// ----- Actual programming clock is triggered only when __config_done__ and __prog_reset__ are disabled -----
	assign __prog_clock__[0] = __prog_clock___reg__[0] & (~__config_done__[0]) & (~__prog_reset__[0]);

// ----- Begin raw operating clock signal generation -----
initial
	begin
		__op_clock___reg__[0] = 1'b0;
	end
always wait(~__greset__)
	begin
		#1	__op_clock___reg__[0] = ~__op_clock___reg__[0];
	end

// ----- End raw operating clock signal generation -----
// ----- Actual operating clock is triggered only when __config_done__ is enabled -----
	assign __op_clock__[0] = __op_clock___reg__[0] & __config_done__[0];

// ----- Begin programming reset signal generation -----
initial
	begin
		__prog_reset__[0] = 1'b1;
	#3.333333492	__prog_reset__[0] = 1'b0;
	end

// ----- End programming reset signal generation -----

// ----- Begin programming set signal generation -----
initial
	begin
		__prog_set_[0] = 1'b1;
	#3.333333492	__prog_set_[0] = 1'b0;
	end

// ----- End programming set signal generation -----

// ----- Begin operating reset signal generation -----
// ----- Reset signal is enabled until the first clock cycle in operation phase -----
initial
	begin
		__greset__[0] = 1'b1;
	wait(__config_done__)
	#2	__greset__[0] = 1'b1;
	#4	__greset__[0] = 1'b0;
	end

// ----- End operating reset signal generation -----
// ----- Begin operating set signal generation: always disabled -----
initial
	begin
		__gset__[0] = 1'b0;
	end

// ----- End operating set signal generation: always disabled -----

// ----- Begin connecting global ports of FPGA fabric to stimuli -----
	assign clk[0] = __op_clock__[0];
	assign prog_clk[0] = __prog_clock__[0];
	assign reset[0] = __greset__[0];
	assign pReset[0] = __prog_reset__[0];
	assign set[0] = __gset__[0];
// ----- End connecting global ports of FPGA fabric to stimuli -----
// ----- FPGA top-level module to be capsulated -----
	fpga_top FPGA_DUT (
		pReset[0],
		prog_clk[0],
		set[0],
		reset[0],
		clk[0],
		gfpga_pad_GPIO_PAD[0:7],
		ccff_head[0],
		ccff_tail[0]);

// ----- Link BLIF Benchmark I/Os to FPGA I/Os -----
// ----- Blif Benchmark input A is mapped to FPGA IOPAD gfpga_pad_GPIO_PAD[7] -----
	assign gfpga_pad_GPIO_PAD[7] = A_shared_input[0];

// ----- Blif Benchmark input B is mapped to FPGA IOPAD gfpga_pad_GPIO_PAD[6] -----
	assign gfpga_pad_GPIO_PAD[6] = B_shared_input[0];

// ----- Blif Benchmark output Y is mapped to FPGA IOPAD gfpga_pad_GPIO_PAD[3] -----
	assign Y_fpga[0] = gfpga_pad_GPIO_PAD[3];

// ----- Wire unused FPGA I/Os to constants -----
	assign gfpga_pad_GPIO_PAD[0] = 1'b0;
	assign gfpga_pad_GPIO_PAD[1] = 1'b0;
	assign gfpga_pad_GPIO_PAD[2] = 1'b0;
	assign gfpga_pad_GPIO_PAD[4] = 1'b0;
	assign gfpga_pad_GPIO_PAD[5] = 1'b0;

// ----- Reference Benchmark Instanication -------
	or2 REF_DUT(
		A_shared_input,
		B_shared_input,
		Y_benchmark
	);
// ----- End reference Benchmark Instanication -------

// ----- Begin bitstream loading during configuration phase -----
`define BITSTREAM_LENGTH 2034
`define BITSTREAM_WIDTH 1
// ----- Virtual memory to store the bitstream from external file -----
reg [0:`BITSTREAM_WIDTH - 1] bit_mem[0:`BITSTREAM_LENGTH - 1];
reg [$clog2(`BITSTREAM_LENGTH):0] bit_index;
// ----- Registers used for fast configuration logic -----
reg [$clog2(`BITSTREAM_LENGTH):0] ibit;
reg [0:0] skip_bits;
// ----- Preload bitstream file to a virtual memory -----
initial begin
	$readmemb("fabric_bitstream.bit", bit_mem);
// ----- Configuration chain default input -----
	ccff_head[0] <= 1'b0;
	bit_index <= 0;
	skip_bits[0] <= 1'b0;
	for (ibit = 0; ibit < `BITSTREAM_LENGTH + 1; ibit = ibit + 1) begin
		if (1'b0 == bit_mem[ibit]) begin
			if (1'b1 == skip_bits[0]) begin
				bit_index <= bit_index + 1;
			end
		end else begin
			skip_bits[0] <= 1'b0;
		end
	end
end
// ----- 'else if' condition is required by Modelsim to synthesis the Verilog correctly -----
always @(negedge __prog_clock___reg__[0]) begin
	if (bit_index >= `BITSTREAM_LENGTH) begin
		__config_done__[0] <= 1'b1;
	end else if (bit_index >= 0 && bit_index < `BITSTREAM_LENGTH) begin
		ccff_head[0] <= bit_mem[bit_index];
		bit_index <= bit_index + 1;
	end
end
// ----- End bitstream loading during configuration phase -----


// ------ END driver initialization -----
// ----- Begin reset signal generation -----
// ----- Input Initialization -------
	initial begin
		A_shared_input <= 1'b0;
		B_shared_input <= 1'b0;

		Y_flag[0] <= 1'b0;
	end

// ----- Input Stimulus -------
	always@(negedge __op_clock__[0]) begin
		A_shared_input <= $random;
		B_shared_input <= $random;
	end

// ----- Begin checking output vectors -------
// ----- Skip the first falling edge of clock, it is for initialization -------
	reg [0:0] sim_start;

	always@(negedge __op_clock__[0]) begin
		if (1'b1 == sim_start[0]) begin
			sim_start[0] <= ~sim_start[0];
		end else 
if (1'b1 == __config_done__) begin
			if(!(Y_fpga === Y_benchmark) && !(Y_benchmark === 1'bx)) begin
				Y_flag <= 1'b1;
			end else begin
				Y_flag<= 1'b0;
			end
		end
	end

	always@(posedge Y_flag) begin
		if(Y_flag) begin
			nb_error = nb_error + 1;
			$display("Mismatch on Y_fpga at time = %t", $realtime);
		end
	end


// ----- Configuration done must be raised in the end -------
	always@(posedge __config_done__[0]) begin
		nb_error = nb_error - 1;
	end

// ----- Begin output waveform to VCD file-------
	initial begin
		$dumpfile("or2_formal.vcd");
		$dumpvars(1, or2_autocheck_top_tb);
	end
// ----- END output waveform to VCD file -------

initial begin
	sim_start[0] <= 1'b1;
	$timeformat(-9, 2, "ns", 20);
	$display("Simulation start");
// ----- Can be changed by the user for his/her need -------
	#6815
	if(nb_error == 0) begin
		$display("Simulation Succeed");
	end else begin
		$display("Simulation Failed with %d error(s)", nb_error);
	end
	$finish;
end

endmodule
// ----- END Verilog module for or2_autocheck_top_tb -----

//----- Default net type -----
`default_nettype none

