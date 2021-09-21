module main (
   input wire clock,
   input wire reset,
   input wire [7:0] addr,
   output wire [63:0] y
);
   (* ram_style = "block" *) reg [63:0] ram;

   always @(posedge clock) begin
     case(addr)
       8'd0: ram <= 64'h44881112_3100C1A1;
       8'd1: ram <= 64'h77101937_4014A2B2;
       8'd2: ram <= 64'h89239447_2932DAC3;
       8'd3: ram <= 64'h34784782_7910FCD4;
       8'd4: ram <= 64'hAD127839_139A12E5;
       8'd5: ram <= 64'h48572015_722903F6;
       8'd6: ram <= 64'hFF237248_24742117;
       8'd7: ram <= 64'h13874949_28924428;
       default: ram <= 64'd0;
     endcase
   end

   assign y = ram;

endmodule
