module main (
   input wire clock,
   input wire reset,
   input wire [7:0] addr,
   output wire [7:0] y
);
   (* ram_style = "block" *) reg [7:0] ram;

   always @(posedge clock) begin
     case(addr)
       8'd0: ram <= 8'hA1;
       8'd1: ram <= 8'hB2;
       8'd2: ram <= 8'hC3;
       8'd3: ram <= 8'hD4;
       8'd4: ram <= 8'hE5;
       8'd5: ram <= 8'hF6;
       8'd6: ram <= 8'h17;
       8'd7: ram <= 8'h28;
       default: ram <= 8'h00;
     endcase
   end

   assign y = ram;

endmodule
