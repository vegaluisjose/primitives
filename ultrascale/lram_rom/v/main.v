module main(input clock, input reset, input [2:0] addr, output [7:0] y);

  wire gnd;
  wire vcc;
  GND _gnd (
      .G(gnd)
  );
  VCC _vcc (
      .P(vcc)
  );

  // RAM64M8: 64-deep by 8-wide Multi Port LUT RAM (Mapped to eight LUT6s)
  //          UltraScale
  // Xilinx HDL Language Template, version 2020.2
  (* LOC = "SLICE_X1Y1", BEL = "H6LUT" *)
  RAM64M8 #(
     .INIT_A(64'h0001110011001100), // Initial contents of A Port
     .INIT_B(64'h0100111100001111), // Initial contents of B Port
     .INIT_C(64'h0000111111110000), // Initial contents of C Port
     .INIT_D(64'h0000111111111111), // Initial contents of D Port
     .INIT_E(64'h0001110011001100), // Initial contents of E Port
     .INIT_F(64'h0100111100001111), // Initial contents of F Port
     .INIT_G(64'h0000111111110000), // Initial contents of G Port
     .INIT_H(64'h0000111111111111), // Initial contents of H Port
     .IS_WCLK_INVERTED(1'b0)        // Specifies active high/low WCLK
  ) RAM64M8_inst (
        .ADDRA({addr[2], addr[1], addr[0], gnd, gnd, gnd}),
        .ADDRB({addr[2], addr[1], addr[0], gnd, gnd, gnd}),
        .ADDRC({addr[2], addr[1], addr[0], gnd, gnd, gnd}),
        .ADDRD({addr[2], addr[1], addr[0], gnd, gnd, gnd}),
        .ADDRE({addr[2], addr[1], addr[0], gnd, gnd, gnd}),
        .ADDRF({addr[2], addr[1], addr[0], gnd, gnd, gnd}),
        .ADDRG({addr[2], addr[1], addr[0], gnd, gnd, gnd}),
        .ADDRH({addr[2], addr[1], addr[0], gnd, gnd, gnd}),
        .DIA(gnd),
        .DIB(gnd),
        .DIC(gnd),
        .DID(gnd),
        .DIE(gnd),
        .DIF(gnd),
        .DIG(gnd),
        .DIH(gnd),
        .DOA(y[0]),
        .DOB(y[1]),
        .DOC(y[2]),
        .DOD(y[3]),
        .DOE(y[4]),
        .DOF(y[5]),
        .DOG(y[6]),
        .DOH(y[7]),
        .WCLK(clock),
        .WE(gnd)
    );
endmodule
