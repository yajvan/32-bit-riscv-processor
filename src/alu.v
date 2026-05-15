`timescale 1ns/1ps
module alu(input [31:0] a, input [31:0] b, input sub, output reg [31:0] y);
  always @(*) begin
    if (sub) y = a - b;
    else y = a + b;
  end
endmodule
