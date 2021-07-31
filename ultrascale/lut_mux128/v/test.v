module test_main (
    input        clock,
    input        reset,
    input [31:0] cycles
);

    logic c;
    logic [127:0] a;
    logic [127:0] b;
    logic [127:0] y;

    assign c = (cycles == 1)? 1'b1 : 1'b0;
    assign a = {8{16'habcd}};
    assign b = {8{16'hdead}};

    main dut (clock, reset, c, a, b, y);

    always @(posedge clock) begin
        if (!reset) begin
            $display("cycle:%4d c:%b a:%032x b:%032x y:%032x", cycles, c, a, b, y);
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
