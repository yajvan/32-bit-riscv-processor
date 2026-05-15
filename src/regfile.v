`timescale 1ns/1ps
module regfile(input clk, input we, input [4:0] rs1, input [4:0] rs2, input [4:0] rd, input [31:0] wd,
               output [31:0] rs1_out, output [31:0] rs2_out);
  reg [31:0] regs [0:31];
  integer i;
  initial begin
    for (i=0;i<32;i=i+1) regs[i]=0;
  end
  assign rs1_out = regs[rs1];
  assign rs2_out = regs[rs2];

  always @(posedge clk) begin
    if (we && rd != 0) regs[rd] <= wd;
  end
endmodule
