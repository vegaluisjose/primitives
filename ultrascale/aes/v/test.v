module test_main (
    input        clock,
    input        reset,
    input [31:0] cycles
);

    logic [127:0] aes_key;
    logic [127:0] aes_plaintext;
    logic aes_reset;
    logic [127:0] aes_ciphertext;
    logic aes_ready;

    assign aes_key = 128'h000102030405060708090a0b0c0d0e0f;
    assign aes_plaintext = 128'h00112233445566778899aabbccddeeff;
    assign aes_reset = cycles == 32'd0;

    main dut (clock, reset, aes_key, aes_plaintext, aes_reset, aes_ciphertext, aes_ready);

    always @(posedge clock) begin
        if (!reset && aes_ready) begin
            assert(aes_ciphertext == 128'h69c4e0d86a7b0430d8cdb78070b4c55a) $display("cycle:%4d ciphertext:%032x expected:%032x", cycles, aes_ciphertext, 128'h69c4e0d86a7b0430d8cdb78070b4c55a);
                else $error("ERROR");
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
