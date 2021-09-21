module test_main (
    input        clock,
    input        reset,
    input [31:0] cycles
);

    logic [7:0] addr;
    logic [7:0] y;
    logic [7:0] z;
    logic [7:0] data;
    logic wen;

    assign data = addr + 8'h10;

    always @(posedge clock) begin
      if (reset) begin
        wen <= 1'b1;
      end
      else if (addr == 8'd7) begin
        wen <= ~wen;
      end
    end

    always @(posedge clock) begin
        if (reset | addr == 8'd7) begin
            addr <= 8'd0;
        end
        else begin
	    addr <= addr + 1'b1;
        end
    end

    main behav (clock, reset, addr, data, wen, y);
    main_impl impl (clock, reset, addr, data, wen, z);

    always @(posedge clock) begin
        if (!reset) begin
            $display("cycle:%4d addr:%2x behav:%2x impl:%2x", cycles, addr, y, z);
        end
    end

endmodule

module test();
    logic clock = 1'b0;
    logic reset;
    logic [31:0] cycles;

    always #50000 clock = ~clock;

    // reset for 3 cycles
    initial begin
        reset = 1'b1;
        repeat(3)@(negedge clock);
        reset = 1'b0;
    end

    // cycle counter
    always @(posedge clock) begin
        if (reset) begin
            cycles <= 32'd0;
        end
        else begin
            cycles <= cycles + 1'b1;
        end
    end

    // run for 10 cycles
    always @(posedge clock) begin
        if (cycles == 32'd17) begin
            $finish;
        end
    end

    test_main t0  (clock, reset, cycles);

endmodule
