`timescale 1ns/1ps
module tb;

  reg clk = 0;
  reg rst;

  // Clock: toggle every 5 ns -> 10 ns period
  always #5 clk = ~clk;

  // Proper reset sequence
  initial begin
    rst = 1;        // Apply reset at start
    #20 rst = 0;    // Release reset after 20 ns
  end

  // Instantiate the CPU top
  cpu_top uut (.clk(clk), .rst(rst));

  initial begin
    $display("Starting simulation...");
    #300; // wait enough cycles for program to run

    // Print register values and memory content
    $display("x1=%0d x2=%0d x3=%0d x4=%0d mem0=%0d",
       uut.rf.regs[1], uut.rf.regs[2], uut.rf.regs[3], uut.rf.regs[4], uut.dmem0.mem[0]);

    $finish;
  end

endmodule
