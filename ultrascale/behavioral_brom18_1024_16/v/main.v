module main (
   input wire clock,
   input wire reset,
   input wire [9:0] addr,
   output wire [15:0] y
);
   (* ram_style = "block" *) reg [15:0] ram;

   always @(posedge clock) begin
     case(addr)
       10'd0: ram <= 16'hC1A1;
       10'd1: ram <= 16'hA2B2;
       10'd2: ram <= 16'hDAC3;
       10'd3: ram <= 16'hFCD4;
       10'd4: ram <= 16'h12E5;
       10'd5: ram <= 16'h03F6;
       10'd6: ram <= 16'h2117;
       10'd7: ram <= 16'h4428;
       default: ram <= 16'h0000;
     endcase
   end

   assign y = ram;

endmodule
