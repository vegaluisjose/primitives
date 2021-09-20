create_clock -period 2 -name clock -waveform {0.0 1} [get_ports clock]
set_property HD.CLK_SRC BUFGCTRL_X0Y0 [get_ports clock]
