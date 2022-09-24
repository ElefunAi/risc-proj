/*****************************/
/* testbench_example         */
/*      for risc-v proj      */ 
/*  Written by Ryotaro Funai */
/*****************************/
`timescale 1 us/ 100 ns
`default_nettype none

module instmem_tb;
parameter HALFCYCLE = 0.5; //500ns
parameter CYCLE = 1;
  reg clk;
  reg [31:0] pc;
  wire [31:0] read_data;
  mem instmem (.clk(clk), .addr(pc), .read_data(read_data));

  integer idx;    //step数のカウント
  always #HALFCYCLE clk = ~clk;
  initial begin
    pc <= 0;
    clk = 1;

    for (idx = 0; idx < 4097; idx = idx + 1) begin
      #CYCLE pc <= pc+4;
      $display("%4d: %h", idx, read_data);
    end
  end

  initial #8000 $finish;
endmodule