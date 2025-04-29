# Makefile for RISCV Verilog project

# Define variables
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
SIM = simv
SOURCES = RISCV.v tb.v
WAVEFILE = waves.vcd

# Default target
all: $(SIM)

# Compile the Verilog source files
$(SIM): $(SOURCES)
	$(IVERILOG) -o $(SIM) $(SOURCES)

# Run the simulation
run: $(SIM)
	$(VVP) $(SIM)

# View waveform
plot: $(WAVEFILE)
	$(GTKWAVE) $(WAVEFILE)

# Run simulation and generate waveform
sim: $(SIM)
	$(VVP) $(SIM)
	@echo "Simulation complete. Run 'make plot' to view waveforms."

# Clean up generated files
clean:
	rm -f $(SIM) $(WAVEFILE) *.vcd

# Help target
help:
	@echo "Makefile targets:"
	@echo "  make all    - Compile the Verilog source files"
	@echo "  make run    - Run the simulation"
	@echo "  make plot   - View waveforms with GTKWave"
	@echo "  make sim    - Run simulation and notify when finished"
	@echo "  make clean  - Remove generated files"
	@echo "  make help   - Display this help message"

# Phony targets
.PHONY: all run plot sim clean help