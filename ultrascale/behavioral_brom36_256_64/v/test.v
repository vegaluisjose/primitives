module test_main (
    input        clock,
    input        reset,
    input [31:0] cycles
);

    logic [7:0] addr;
    logic [63:0] y;
    logic [63:0] z;

    always @(posedge clock) begin
        if (reset) begin
            addr <= 'd0;
        end
        else begin
	    addr <= addr + 1'b1;
        end
    end

    main behav (clock, reset, addr, y);
    main_impl impl (clock, reset, addr, z);

    always @(posedge clock) begin
        if (!reset) begin
            $display("cycle:%4d addr:%03x behav:%016x impl:%016x", cycles, addr, y, z);
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
