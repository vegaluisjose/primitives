set top_name [lindex $argv 0]
set verilog_file [lindex $argv 1]
set netlist_file [lindex $argv 2]
set part_name "xczu3eg-sbva484-1-e"

read_verilog -sv $verilog_file
read_xdc -mode out_of_context constraint.xdc
synth_design -mode "out_of_context" -flatten_hierarchy "rebuilt" -top $top_name -part $part_name
opt_design
write_verilog -file $netlist_file
