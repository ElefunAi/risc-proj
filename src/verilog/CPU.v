module CPU;
    initial $display ("Hello World.");
endmodule

module decoder (
    input wire [31:0] inst,
    // output なんもわからん
);
    // 宣言
    // 内部信号
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;

    // opcodeから命令形式保持(R,I,S,B,U,Jなので、3bitレジスタで保持)
    reg [2:0] alu_x;

    // assign
    assign opcode = inst[6:0];
    assign rd = inst[11:7];
    assign funct3 = inst[14:12];
    assign funct7 = inst[31:25];
    assign rs1 = inst[19:15];
    assign rs2 = inst[24:20];

    // デコーダが渡すもの
    // exe_fun(演算内容),op1(第1オペランド),op2(第2オペランド),mem_wen(メモリenable),rf_wen(ライトバックenable),wb_sel(ライトバックデータセレクタ)
endmodule