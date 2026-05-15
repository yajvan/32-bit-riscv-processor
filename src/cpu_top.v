`timescale 1ns/1ps
// cpu_top.v - Minimal single-cycle RV32I subset
module cpu_top (
    input clk,
    input rst
);

  // ------------------------------
  // Program Counter (PC) Register
  // ------------------------------
  reg [31:0] pc;          // holds current address
  wire [31:0] instr;      // instruction from memory

  // Increment PC every clock (simple design)
  always @(posedge clk or posedge rst) begin
    if (rst)
      pc <= 32'b0;        // when reset = 1 ? start from 0
    else
      pc <= pc + 4;       // next instruction (word aligned)
  end

  // ------------------------------
  // Instruction Memory
  // ------------------------------
  imem imem0 (
    .addr(pc[9:2]),       // word address (drops lower 2 bits)
    .instr(instr)
  );

  // ------------------------------
  // Register File
  // ------------------------------
  wire [31:0] rs1_out, rs2_out;
  wire [31:0] alu_result;

  regfile rf (
    .clk(clk),
    .we(1'b0),            // no write yet
    .rs1(5'd1),           // test read from reg1
    .rs2(5'd2),           // test read from reg2
    .rd(5'd3),            // test write reg3
    .wd(alu_result),      // ALU output written
    .rs1_out(rs1_out),
    .rs2_out(rs2_out)
  );

  // ------------------------------
  // ALU
  // ------------------------------
  alu alu0 (
    .a(rs1_out),
    .b(rs2_out),
    .sub(1'b0),           // add operation
    .y(alu_result)
  );

  // ------------------------------
  // Data Memory (optional)
  // ------------------------------
  wire [31:0] dmem_out;

  dmem dmem0 (
    .clk(clk),
    .we(1'b0),            // not writing yet
    .addr(alu_result[7:0]),
    .wd(rs2_out),
    .rd(dmem_out)
  );

endmodule

