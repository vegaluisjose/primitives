set top_name [lindex $argv 0]
set verilog_file [lindex $argv 1]
set utilization_file [lindex $argv 2]
set timing_file [lindex $argv 3]
set dcp_file [lindex $argv 4]
set netlist_file [lindex $argv 5]
set xdc_file [lindex $argv 6]

set part_name "xck26-sfvc784-2LV-c"

read_verilog -sv $verilog_file
read_xdc -mode out_of_context $xdc_file
synth_design -mode "out_of_context" -flatten_hierarchy "rebuilt" -top $top_name -part $part_name
#opt_design
#place_design -directive Default
write_verilog -file $netlist_file
#route_design -directive Default
#report_timing -file $timing_file
#report_utilization -file $utilization_file
#report_timing_summary -check_timing_verbose -file time.txt
write_checkpoint $dcp_file
