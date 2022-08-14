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
  CPU riscv (.clk(clk), .reset(reset));

  integer idx;    //step数のカウント
  always #HALFCYCLE clk = ~clk;
  initial begin
    clk = 1;
    reset = 1;
    // ここでモジュールの出力を保存する
    $dumpfile("comp.vcd");
    $dumpvars(0, U0);

    // テストプログラム(アセンブル済み)をROM32Kの配列mに詰め込む
    $readmemb("../hex/c.hex", U0.rom.m);
    for (idx = 0; idx < 32; idx = idx + 1) begin
      $display("%4d: %b", idx, U0.rom.m[idx]);
    end
    // どうも内部のwireまで参照することが可能
    $monitor("%4dns clock=%d pc=%d I=%d A=%d D=%d M=%d", $stime, clk, U0.pc, U0.inst, U0.dataaddr, U0.cpu.outD, U0.datain);
    // #CYCLE reset = 1;
    // リセット信号は代入されないので、手動で下げる
    #CYCLE     reset = 0;
  end

  initial #1800 $finish;
endmodule