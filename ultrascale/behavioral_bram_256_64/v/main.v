module main (
   input wire clock,
   input wire reset,
   input wire [7:0] addr,
   input wire [63:0] data,
   input wire wen,
   output reg [63:0] y
);
   (* ram_style = "block" *) reg [63:0] ram [255:0];

   always @(posedge clock) begin
     if (wen) begin
       ram[addr] <= data;
       y <= data;
     end
     else begin
       y <= ram[addr];
     end
   end

endmodule
