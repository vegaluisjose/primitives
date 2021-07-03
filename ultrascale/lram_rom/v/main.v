module main(input clock, input reset, input [5:0] addr, output [7:0] data);

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
     .DOA(data[0]),
     .DOB(data[1]),
     .DOC(data[2]),
     .DOD(data[3]),
     .DOE(data[4]),
     .DOF(data[5]),
     .DOG(data[6]),
     .DOH(data[7]),
     .DIA(1'b0),
     .DIB(1'b0),
     .DIC(1'b0),
     .DID(1'b0),
     .DIE(1'b0),
     .DIF(1'b0),
     .DIG(1'b0),
     .DIH(1'b0),
     // Read port A 1-bit output
     // Read port B 1-bit output
     // Read port C 1-bit output
     // Read port D 1-bit output
     // Read port E 1-bit output
     // Read port F 1-bit output
     // Read port G 1-bit output
     // Read/write port H 1-bit output
     // RAM 1-bit data write input addressed by ADDRD,
     //   read addressed by ADDRA
     // RAM 1-bit data write input addressed by ADDRD,
     //   read addressed by ADDRB
     // RAM 1-bit data write input addressed by ADDRD,
     //   read addressed by ADDRC
     // RAM 1-bit data write input addressed by ADDRD,
     //   read addressed by ADDRD
     // RAM 1-bit data write input addressed by ADDRD,
     //   read addressed by ADDRE
     // RAM 1-bit data write input addressed by ADDRD,
     //   read addressed by ADDRF
     // RAM 1-bit data write input addressed by ADDRD,
     //   read addressed by ADDRG
     // RAM 1-bit data write input addressed by ADDRD,
     //   read addressed by ADDRH
     .ADDRA({addr[2:0], 3'd0}), // Read port A 6-bit address input
     .ADDRB({addr[2:0], 3'd0}), // Read port B 6-bit address input
     .ADDRC({addr[2:0], 3'd0}), // Read port C 6-bit address input
     .ADDRD({addr[2:0], 3'd0}), // Read port D 6-bit address input
     .ADDRE({addr[2:0], 3'd0}), // Read port E 6-bit address input
     .ADDRF({addr[2:0], 3'd0}), // Read port F 6-bit address input
     .ADDRG({addr[2:0], 3'd0}), // Read port G 6-bit address input
     .ADDRH({addr[2:0], 3'd0}), // Read/write port H 6-bit address input
     .WE(1'b0),     // Write enable input
     .WCLK(clock)   // Write clock input
  );

endmodule
