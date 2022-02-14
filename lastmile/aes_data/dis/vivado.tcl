read_verilog -sv /home/vega/github/primitives/lastmile/aes/reticle_dis.v
read_xdc -mode out_of_context constraint.xdc
synth_design -mode "out_of_context" -flatten_hierarchy "rebuilt" -top toplevel -part "xck26-sfvc784-2LV-c"
opt_design
place_design -directive Default
route_design -directive Default
report_timing -file timing.rpt
report_timing_summary -file timingsum.rpt
report_utilization -file util.rpt