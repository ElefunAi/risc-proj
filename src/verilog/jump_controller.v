module jump_controller (
    input wire [4:0] exe_fn,
    input wire [31:0] default_target,
    output wire jump_flag,
    output wire [31:0] jump_target,
);

    reg jump_flag_reg,
    reg [31:0] jump_target_reg,

    // 条件分岐
    wire [31:0] beq_out;
    assign beq_out = (rs1_data == rs2_data) ? 32'b1 : 32'b0;

    wire [31:0] bne_out;
    assign bne_out = (rs1_data != rs2_data) ? 32'b1 : 32'b0;

    wire [31:0] blt_out;
    assign blt_out = ($signed(rs1_data) < $signed(rs2_data)) ? 32'b1 : 32'b0;

    wire [31:0] bge_out;
    assign bge_out = ($signed(rs1_data) > $signed(rs2_data)) ? 32'b1 : 32'b0;
    
    wire [31:0] bltu_out;
    assign bltu_out = (rs1_data < rs2_data) ? 32'b1 : 32'b0;

    wire [31:0] bgeu_out;
    assign bgeu_out = (rs1_data > rs2_data) ? 32'b1 : 32'b0;

    wire [31:0] jalr_out;
    assign jalr_out = (rs1_data + rs2_data) & ~32'b1;

    always @(*) begin
        case (exe_fn)
            `BR_BEQ   : jump_flag <= beq_out;
            `BR_BNE   : jump_flag <= bne_out;
            `BR_BLT   : jump_flag <= blt_out;
            `BR_BGE   : jump_flag <= bge_out;
            `BR_BLTU  : jump_flag <= bltu_out;
            `BR_BGEU  : jump_flag <= bgeu_out;
            default   : jump_flag <= 0;
        endcase
        case (exe_fn)
            `ALU_JALR : jump_target_reg <= jalr_out;
            default   : jump_target_reg <= rs2_data;
        endcase
    end

    assign jump_flag = jump_flag_reg;
    assign jump_target = jump_target_reg;

endmodule