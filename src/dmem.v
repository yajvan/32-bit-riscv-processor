`timescale 1ns/1ps
module dmem(input clk, input [7:0] addr, input we, input [31:0] wd, output [31:0] rd);
  reg [31:0] mem [0:255];
  initial begin
    $readmemh("dmem.mem", mem);
  end
  assign rd = mem[addr];
  always @(posedge clk) begin
    if (we) mem[addr] <= wd;
  end
endmodule
