module main (
   input wire clock,
   input wire reset,
   input wire [9:0] addr,
   input wire [15:0] data,
   input wire wen,
   output reg [15:0] y
);
   (* ram_style = "ultra" *) reg [15:0] ram [1023:0];

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
