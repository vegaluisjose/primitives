OUT_DIR = $(abspath .)/out
V_DIR = $(abspath .)/v

NAME = main

IMPL_FILE = $(V_DIR)/$(NAME).v

TIME_FILE = $(OUT_DIR)/$(NAME)_time.txt
UTIL_FILE = $(OUT_DIR)/$(NAME)_util.txt
DCP_FILE = $(OUT_DIR)/$(NAME).dcp
NETLIST_FILE = $(OUT_DIR)/$(NAME)_netlist.v
XDC_FILE = $(abspath .)/tcl/constraint.xdc

GLBL_V = $(XILINX_VIVADO)/data/verilog/src/glbl.v

default: sim

sim: xvlog xelab

.PHONY: impl
impl: | $(OUT_DIR)
	vivado -mode batch -source tcl/vivado.tcl -tclargs $(NAME) $(IMPL_FILE) $(UTIL_FILE) $(TIME_FILE) $(DCP_FILE) $(NETLIST_FILE) $(XDC_FILE)

xvlog:
	xvlog --sv --incr --relax $(GLBL_V) v/main.v v/test.v v/pass.v

xelab:
	xelab --snapshot test --timescale 1ps/1ps -R -L unisims_ver glbl test

$(OUT_DIR):
	mkdir -p $@

clean:
	-rm -rf *.log *.wdb *.jou *.dir *.pb $(OUT_DIR) hd_visual
