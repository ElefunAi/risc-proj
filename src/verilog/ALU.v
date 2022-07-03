`include "instruction.v"

module ALU (
    input wire [4:0] alu_fn,
    input wire [31:0] rs1_data,
    input wire [31:0] rs2_data,
    output wire [31:0] out
);

    wire [31:0] imm_data;
    assign imm_data = rs2_data;

    wire [31:0] add_out;
    assign add_out = rs1_data + rs2_data;

    wire [31:0] addi_out;
    assign addi_out = rs1_data + imm_data;

    wire [31:0] sub_out;
    assign sub_out = rs1_data - rs2_data;
    
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

    wire [31:0] sll_out;
    assign sll_out = rs1_data << rs2_data;

    wire [31:0] srl_out;//TODO
    assign srl_out = rs1_data >> rs2_data;

    wire [31:0] sra_out;//TODO
    assign sra_out = rs1_data >> rs2_data;

    wire [31:0] slli_out;
    assign slli_out = rs1_data << imm_data;

    wire [31:0] srli_out;//TODO
    assign srl_out = rs1_data >> imm_data;

    wire [31:0] srai_out;//TODO
    assign sra_out = rs1_data >> imm_data;

    wire [31:0] slt_out;
    //assign slt_out = 

endmodule