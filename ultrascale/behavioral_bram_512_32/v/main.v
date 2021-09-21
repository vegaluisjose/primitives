module main (
   input wire clock,
   input wire reset,
   input wire [8:0] addr,
   input wire [31:0] data,
   input wire wen,
   output reg [31:0] y
);
   (* ram_style = "block" *) reg [31:0] ram [511:0];

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
