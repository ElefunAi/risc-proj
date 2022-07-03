/* モジュール名：ALU
 * 役割：ほとんどすべての計算を行う
 * しないこと：ストア・ロード、条件分岐、ジャンプ
 * ただし、"しないこと"に必要な計算はALUで行う。
*/ 

//`include "define.vh"

module ALU (
    input wire [4:0] alu_fn,
    input wire [31:0] rs1_data,
    input wire [31:0] rs2_data,
    output wire [31:0] out
);
    // 変数定義
    wire [31:0] imm_data;
    assign imm_data = rs2_data;

    // 算術演算
    wire [31:0] add_out;
    assign add_out = $signed(rs1_data) + $signed(rs2_data);

    wire [31:0] addi_out;
    assign addi_out = $signed(rs1_data) + $signed(imm_data);

    wire [31:0] sub_out;
    assign sub_out = $signed(rs1_data) - $signed(rs2_data);
    
    // 論理演算
    wire [31:0] and_out;
    assign and_out = rs1_data & rs2_data;

    wire [31:0] or_out;
    assign or_out = rs1_data | rs2_data;

    wire [31:0] xor_out;
    assign xor_out = rs1_data ^ rs2_data;

    wire [31:0] andi_out;
    assign andi_out = rs1_data & imm_data;

    wire [31:0] ori_out;
    assign ori_out = rs1_data | imm_data;

    wire [31:0] xori_out;
    assign xori_out = rs1_data ^ imm_data;

    // シフト
    wire [31:0] sll_out;
    assign sll_out = rs1_data << rs2_data;

    wire [31:0] srl_out;
    assign srl_out = rs1_data >> rs2_data;

    wire [31:0] sra_out;
    assign sra_out = rs1_data >>> rs2_data;

    wire [31:0] slli_out;
    assign slli_out = rs1_data << imm_data;

    wire [31:0] srli_out;
    assign srl_out = rs1_data >> imm_data;

    wire [31:0] srai_out;
    assign sra_out = rs1_data >>> imm_data;

    // 比較
    wire [31:0] slt_out;
    assign slt_out = ($signed(rs1_data) < $signed(rs2_data)) ? 32'b1 : 32'b0;

    wire [31:0] sltu_out;
    assign sltu_out = (rs1_data < rs2_data) ? 32'b1 : 32'b0;

    wire [31:0] slti_out;
    assign slti_out = ($signed(rs1_data) < $signed(imm_data)) ? 32'b1 : 32'b0;

    wire [31:0] sltiu_out;
    assign sltiu_out = (rs1_data < imm_data) ? 32'b1 : 32'b0;
    
    always @(*) begin
        case (alu_fn)
            32'b0 : out <= 1;
            default: out <= 0;
        endcase
    end

endmodule