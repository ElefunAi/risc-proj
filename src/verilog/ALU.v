/* モジュール名：ALU
 * 役割：ほとんどすべての計算を行う
 * しないこと：ストア・ロード、条件分岐、ジャンプ
*/ 

`include "define.vh"

module ALU (
    input wire [4:0] alu_fn,
    input wire [31:0] rs1_data,
    input wire [31:0] rs2_data,
    output wire [31:0] out
);

    // 算術演算
    wire [31:0] add_out;
    assign add_out = rs1_data+rs2_data;

    wire [31:0] sub_out;
    assign sub_out = rs1_data-rs2_data;
    
    // 論理演算
    wire [31:0] and_out;
    assign and_out = rs1_data & rs2_data;

    wire [31:0] or_out;
    assign or_out = rs1_data | rs2_data;

    wire [31:0] xor_out;
    assign xor_out = rs1_data ^ rs2_data;

    // シフト
    wire [31:0] sll_out;
    assign sll_out = rs1_data << rs2_data;

    wire [31:0] srl_out;
    assign srl_out = rs1_data >> rs2_data;

    wire [31:0] sra_out;
    assign sra_out = rs1_data >>> rs2_data;

    // 比較
    wire [31:0] slt_out;
    assign slt_out = ($signed(rs1_data) < $signed(rs2_data)) ? 32'b1 : 32'b0;

    wire [31:0] sltu_out;
    assign sltu_out = (rs1_data < rs2_data) ? 32'b1 : 32'b0;

    assign out = (alu_fn == `ALU_X) ? 32'bx :
                 (alu_fn == `ALU_ADD) ? add_out :
                 (alu_fn == `ALU_SUB) ? sub_out :
                 (alu_fn == `ALU_AND) ? and_out :
                 (alu_fn == `ALU_OR) ? or_out :
                 (alu_fn == `ALU_XOR) ? xor_out :
                 (alu_fn == `ALU_SLL) ? sll_out :
                 (alu_fn == `ALU_SRL) ? srl_out :
                 (alu_fn == `ALU_SRA) ? sra_out :
                 (alu_fn == `ALU_SLT) ? slt_out :
                 (alu_fn == `ALU_SLTU) ? sltu_out :
                 32'bx;

endmodule