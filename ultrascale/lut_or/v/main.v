module main(input clock, input reset, input a, input b, output y);

    (* LOC = "SLICE_X0Y0", BEL = "A6LUT" *)
    LUT2 #(.INIT(4'h6)) i0 (.I0(a), .I1(b), .O(y));

endmodule
