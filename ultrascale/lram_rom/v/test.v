module test_main (
    input        clock,
    input        reset,
    input [31:0] cycles
);

    logic [2:0] addr;
    logic [7:0] y;

    always @(posedge clock) begin
        if (reset) begin
            addr <= 8'd0;
        end
        else begin
	    addr <= addr + 1'b1;
        end
    end

    main dut (clock, reset, addr, y);

    always @(posedge clock) begin
        if (!reset) begin
            $display("cycle:%4d addr:%2x y:%2x", cycles, addr, y);
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
        if (cycles == 32'd35) begin
            $finish;
        end
    end

    test_main t0  (clock, reset, cycles);

endmodule
