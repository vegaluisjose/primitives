module rom_behav_a (
  input wire clock,
  input wire reset,
  input wire [4:0] addr,
  output wire [31:0] y
);
  reg [31:0] ram [31:0];

  initial begin
    ram[0] = 32'hD3301861;
    ram[1] = 32'hCC0D694A;
    ram[2] = 32'h3248C9DA;
    ram[3] = 32'h376425D3;
    ram[4] = 32'hC53D7454;
    ram[5] = 32'h8495153B;
    ram[6] = 32'hCAC4CFEC;
    ram[7] = 32'hFF56CBC7;
    ram[8] = 32'h1CB3B3A6;
    ram[9] = 32'h27E588EA;
    ram[10] = 32'h8A4880C6;
    ram[11] = 32'h6956C4DC;
    ram[12] = 32'hCF4735F1;
    ram[13] = 32'hCDFF9AA3;
    ram[14] = 32'h24BD4009;
    ram[15] = 32'h5D10546E;
    ram[16] = 32'h359A76C9;
    ram[17] = 32'h7F55F4A4;
    ram[18] = 32'h4EF132A2;
    ram[19] = 32'h5470D8D9;
    ram[20] = 32'h7D5B1F08;
    ram[21] = 32'h5082840F;
    ram[22] = 32'h3ECCAE03;
    ram[23] = 32'h9FF5814E;
    ram[24] = 32'hF4050D9A;
    ram[25] = 32'h0B8B41BF;
    ram[26] = 32'h5FF6006A;
    ram[27] = 32'h843ECF22;
    ram[28] = 32'h28F4779D;
    ram[29] = 32'h7041677E;
    ram[30] = 32'hEBD55AC8;
    ram[31] = 32'h0C3F0B5D;
  end

  reg [31:0] data;

  always @(posedge clock) begin
    if (reset) begin
      data <= 0;
    end else begin
      data <= ram[addr];
    end
  end

  assign y = data;
endmodule
