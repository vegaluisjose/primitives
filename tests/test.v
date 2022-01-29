module test;

  logic        clock = 1'b0;
  logic        reset;
  logic [31:0] cycles;
  logic  [4:0] addr;
  logic [31:0] roma;
  logic [31:0] romb;
  logic [31:0] romc;

  always #50000 clock = ~clock;

  initial begin
    reset = 1'b1;
    repeat(3)@(negedge clock);
    reset = 1'b0;
  end

  always @(posedge clock) begin
    if (reset) begin
      cycles <= 32'd0;
    end
    else begin
      cycles <= cycles + 1'b1;
    end
  end

  always @(posedge clock) begin
    if (cycles == 32'd17) begin
      $finish;
    end
  end

  always @(posedge clock) begin
    if (reset) begin
      addr <= 0;
    end
    else begin
      addr <= addr + 1'b1;
    end
  end

  rom_behav_a ra (.clock(clock), .reset(reset), .addr(addr), .y(roma));
  rom_behav_b rb (.clock(clock), .reset(reset), .addr(addr), .y(romb));
  rom_prim_c rc (.clock(clock), .reset(reset), .addr(addr), .y(romc));

  always @(posedge clock) begin
    if (!reset) begin
      $display("cycles:%04d, addr:%02x roma:%08x romb:%08x romc:%08x", cycles, addr, roma, romb, romc);
    end
  end

endmodule
