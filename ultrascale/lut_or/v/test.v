module test_main (
    input        clock,
    input        reset,
    input [31:0] cycles
);

    logic a;
    logic b;
    logic y;

    assign a = 1'b1;
    assign b = 1'b0;

    main dut (clock, reset, a, b, y);

    always @(posedge clock) begin
        if (!reset) begin
            $display("cycle:%4d a:%1b b:%1b y:%1b", cycles, a, b, y);
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
        if (cycles == 32'd3) begin
            $finish;
        end
    end

    test_main t0  (clock, reset, cycles);

endmodule
