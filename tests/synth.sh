#!/bin/bash

set -e
set -u
set -o pipefail

TOP_NAME="rom_behav_b"
VERILOG_FILE="rom_behav_b.v"
NETLIST_FILE="rom_prim_d.v"

vivado -mode batch -source synth.tcl \
-tclargs ${TOP_NAME} \
${VERILOG_FILE} \
${NETLIST_FILE}
