/*****************************/
/* testbench_example         */
/*      for risc-v proj      */ 
/*  Written by Ryotaro Funai */
/*****************************/
`include "CPU.v"
`timescale 1 us/ 100 ns
`default_nettype none

module computer_tb;
parameter HALFCYCLE = 0.5; //500ns
parameter CYCLE = 1;
  reg reset, clk;
  reg [31:0] pc;
  wire [31:0] read_data;
  inst_mem instmem (.clk(clk), .addr(pc), .read_data(read_data));
  CPU riscv (.clk(clk), .reset(reset));

  integer idx;    //step数のカウント
  integer FP;
  always #HALFCYCLE clk = ~clk;
  initial begin
    FP = $fopen("monitor2.log");
    #CYCLE
    pc <= 0;
    clk = 1;
    reset = 1;
    // ここでモジュールの出力を保存する
    $dumpfile("comp.vcd");
    $dumpvars(0, riscv);

    // 計算結果を参照
    // for (idx = 0; idx < 6600; idx = idx + 1) begin
    //   #CYCLE $fdisplay(FP, "%4dns clock=%d pc=%d inst=%d rs1_addr=%d rs1_data=%d rs2_addr=%d rs2_data=%d", $stime, clk, riscv.pc, riscv.inst_out, riscv.op1_addr, riscv.rs1_data, riscv.op2_addr, riscv.rs2_data);
      // $display("%4d: %h", idx, read_data);
      // $fdisplay(FP, "%4d: %h", idx, read_data);
    // end
    #CYCLE reset = 1;
    // リセット信号は代入されないので、手動で下げる
    #CYCLE     reset = 0;
    $fmonitor(FP, "%4dus clock=%d pc=%d inst=%h rs1_addr=%d rs1_data=%h rs2_addr=%d rs2_data=%h val=%h", $stime, clk, riscv.pc, riscv.inst_out, riscv.op1_addr, riscv.reg_decode_reg_file.rs1_data, riscv.op2_addr, riscv.reg_decode_reg_file.rs2_data, riscv.reg_decode_reg_file.write_value);


  end

  initial #8000 $finish;
endmodule