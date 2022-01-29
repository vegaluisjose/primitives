#!/bin/bash

set -e
set -u
set -o pipefail

GLBL_V=${XILINX_VIVADO}/data/verilog/src/glbl.v

xvlog --sv --incr --relax ${GLBL_V} test.v rom_behav_a.v rom_behav_b.v rom_prim_c.v
xelab --snapshot test --timescale 1ps/1ps -R -L unisims_ver glbl test
