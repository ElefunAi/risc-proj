/* モジュール名：ALU
 * 役割：ほとんどすべての計算を行う
 * しないこと：ストア・ロード、条件分岐、ジャンプ
 * ただし、"しないこと"に必要な計算はALUで行う。
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
    assign add_out = $signed(rs1_data) + $signed(rs2_data);

    wire [31:0] sub_out;
    assign sub_out = $signed(rs1_data) - $signed(rs2_data);
    
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

    always @(*) begin
        case (alu_fn)
            `ALU_X    : out <= 0;
            `ALU_ADD  : out <= add_out;
            `ALU_SUB  : out <= sub_out;
            `ALU_AND  : out <= and_out;
            `ALU_OR   : out <= or_out;
            `ALU_XOR  : out <= xor_out;
            `ALU_SLL  : out <= sll_out;
            `ALU_SRL  : out <= srl_out;
            `ALU_SRA  : out <= sra_out;
            `ALU_SLT  : out <= slt_out;
            `ALU_SLTU : out <= sltu_out;
            `BR_BEQ   : out <= beq_out;
            `BR_BNE   : out <= bne_out;
            `BR_BLT   : out <= blt_out;
            `BR_BGE   : out <= bge_out;
            `BR_BLTU  : out <= bltu_out;
            `BR_BGEU  : out <= bgeu_out;
            `ALU_JALR : out <= jalr_out;
            default  : out <= 0;
        endcase
    end

endmodule