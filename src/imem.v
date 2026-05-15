`timescale 1ns/1ps
module imem(input [7:0] addr, output [31:0] instr);
  reg [31:0] mem [0:255];
  initial begin
    $readmemh("imem.mem", mem);
  end
  assign instr = mem[addr];
endmodule
