module rom_behav_b (
  input wire clock,
  input wire reset,
  input wire [4:0] addr,
  output wire [31:0] y
);
  reg [31:0] ram;

  always @(posedge clock) begin
    case(addr)
      5'd0: ram <= 32'hD3301861;
      5'd1: ram <= 32'hCC0D694A;
      5'd2: ram <= 32'h3248C9DA;
      5'd3: ram <= 32'h376425D3;
      5'd4: ram <= 32'hC53D7454;
      5'd5: ram <= 32'h8495153B;
      5'd6: ram <= 32'hCAC4CFEC;
      5'd7: ram <= 32'hFF56CBC7;
      5'd8: ram <= 32'h1CB3B3A6;
      5'd9: ram <= 32'h27E588EA;
      5'd10: ram <= 32'h8A4880C6;
      5'd11: ram <= 32'h6956C4DC;
      5'd12: ram <= 32'hCF4735F1;
      5'd13: ram <= 32'hCDFF9AA3;
      5'd14: ram <= 32'h24BD4009;
      5'd15: ram <= 32'h5D10546E;
      5'd16: ram <= 32'h359A76C9;
      5'd17: ram <= 32'h7F55F4A4;
      5'd18: ram <= 32'h4EF132A2;
      5'd19: ram <= 32'h5470D8D9;
      5'd20: ram <= 32'h7D5B1F08;
      5'd21: ram <= 32'h5082840F;
      5'd22: ram <= 32'h3ECCAE03;
      5'd23: ram <= 32'h9FF5814E;
      5'd24: ram <= 32'hF4050D9A;
      5'd25: ram <= 32'h0B8B41BF;
      5'd26: ram <= 32'h5FF6006A;
      5'd27: ram <= 32'h843ECF22;
      5'd28: ram <= 32'h28F4779D;
      5'd29: ram <= 32'h7041677E;
      5'd30: ram <= 32'hEBD55AC8;
      5'd31: ram <= 32'h0C3F0B5D;
      default: ram <= 32'd0;
    endcase
  end

  assign y = ram;
endmodule
