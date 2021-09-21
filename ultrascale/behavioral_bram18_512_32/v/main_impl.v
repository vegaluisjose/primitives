// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
// Date        : Tue Sep 21 03:01:12 2021
// Host        : boba running 64-bit unknown
// Command     : write_verilog -file
//               /home/vega/github/fpga-prim-examples/ultrascale/behavioral_bram_512_32/out/main_netlist.v
// Design      : main
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xczu3eg-sbva484-1-e
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* STRUCTURAL_NETLIST = "yes" *)
module main_impl
   (clock,
    reset,
    addr,
    data,
    wen,
    y);
  input clock;
  input reset;
  input [8:0]addr;
  input [31:0]data;
  input wen;
  output [31:0]y;

  wire \<const0> ;
  wire \<const1> ;
  wire [8:0]addr;
  wire clock;
  wire [31:0]data;
  wire wen;
  wire [31:0]y;

  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p2_d16" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p0_d14" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-6 {cell *THIS*}}" *) 
  (* OPT_MODIFIED = "MLO" *) 
  (* RDADDR_COLLISION_HWCONFIG = "DELAYED_WRITE" *) 
  (* RTL_RAM_BITS = "16384" *) 
  (* RTL_RAM_NAME = "ram" *) 
  (* RTL_RAM_TYPE = "RAM_SP" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "511" *) 
  (* ram_ext_slice_begin = "18" *) 
  (* ram_ext_slice_end = "31" *) 
  (* ram_offset = "512" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "17" *) 
  RAMB18E2 #(
    .CASCADE_ORDER_A("NONE"),
    .CASCADE_ORDER_B("NONE"),
    .CLOCK_DOMAINS("COMMON"),
    .DOA_REG(0),
    .DOB_REG(0),
    .ENADDRENA("FALSE"),
    .ENADDRENB("FALSE"),
    .INIT_A(18'h00000),
    .INIT_B(18'h00000),
    .INIT_FILE("NONE"),
    .RDADDRCHANGEA("FALSE"),
    .RDADDRCHANGEB("FALSE"),
    .READ_WIDTH_A(18),
    .READ_WIDTH_B(18),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SLEEP_ASYNC("FALSE"),
    .SRVAL_A(18'h00000),
    .SRVAL_B(18'h00000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(18),
    .WRITE_WIDTH_B(18)) 
    ram_reg
       (.ADDRARDADDR({\<const0> ,addr,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .ADDRBWRADDR({\<const1> ,addr,\<const1> ,\<const1> ,\<const1> ,\<const1> }),
        .ADDRENA(\<const1> ),
        .ADDRENB(\<const1> ),
        .CASDIMUXA(\<const0> ),
        .CASDIMUXB(\<const0> ),
        .CASDINA({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CASDINB({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .CASDINPA({\<const0> ,\<const0> }),
        .CASDINPB({\<const0> ,\<const0> }),
        .CASDOMUXA(\<const0> ),
        .CASDOMUXB(\<const0> ),
        .CASDOMUXEN_A(\<const1> ),
        .CASDOMUXEN_B(\<const1> ),
        .CASOREGIMUXA(\<const0> ),
        .CASOREGIMUXB(\<const0> ),
        .CASOREGIMUXEN_A(\<const1> ),
        .CASOREGIMUXEN_B(\<const1> ),
        .CLKARDCLK(clock),
        .CLKBWRCLK(clock),
        .DINADIN(data[15:0]),
        .DINBDIN({\<const1> ,\<const1> ,data[31:18]}),
        .DINPADINP(data[17:16]),
        .DINPBDINP({\<const1> ,\<const1> }),
        .DOUTADOUT(y[15:0]),
        .DOUTBDOUT(y[31:18]),
        .DOUTPADOUTP(y[17:16]),
        .ENARDEN(\<const1> ),
        .ENBWREN(\<const1> ),
        .REGCEAREGCE(\<const1> ),
        .REGCEB(\<const1> ),
        .RSTRAMARSTRAM(\<const0> ),
        .RSTRAMB(\<const0> ),
        .RSTREGARSTREG(\<const0> ),
        .RSTREGB(\<const0> ),
        .SLEEP(\<const0> ),
        .WEA({wen,wen}),
        .WEBWE({\<const0> ,\<const0> ,wen,wen}));
endmodule
