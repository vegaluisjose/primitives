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
    
    logic [127:0] pass_ciphertext;
    logic pass_ready;

    assign aes_key = 128'h000102030405060708090a0b0c0d0e0f;
    assign aes_plaintext = 128'h00112233445566778899aabbccddeeff;
    assign aes_reset = cycles == 32'd2;

    main a (clock, reset, aes_key, aes_plaintext, aes_ciphertext);
    pass b (clock, reset, aes_key, aes_plaintext, pass_ciphertext);

    always @(posedge clock) begin
        $display("cycle:%4d reticle:%032x pyrtl:%032x", cycles, aes_ciphertext, pass_ciphertext);
    end

endmodule

module test();
    logic clock = 1'b0;
    logic reset;
    logic [31:0] cycles;

    always #500000 clock = ~clock;

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
        if (cycles == 32'd32) begin
            $finish;
        end
    end

    test_main t0  (clock, reset, cycles);

endmodule
