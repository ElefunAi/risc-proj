module jump_controller (
    input wire [4:0] exe_fn,
    input wire [31:0] rs1_data,
    input wire [31:0] rs2_data,
    output wire jump_flag,
    output wire [31:0] jump_target,
);

    reg jump_flag_reg,
    reg [31:0] jump_target_reg,

    // 条件分岐
    wire beq_out;
    assign beq_out = (rs1_data == rs2_data) ? 1'b1 : 1'b0;

    wire bne_out;
    assign bne_out = (rs1_data != rs2_data) ? 1'b1 : 1'b0;

    wire blt_out;
    assign blt_out = ($signed(rs1_data) < $signed(rs2_data)) ? 1'b1 : 1'b0;

    wire bge_out;
    assign bge_out = ($signed(rs1_data) > $signed(rs2_data)) ? 1'b1 : 1'b0;
    
    wire bltu_out;
    assign bltu_out = (rs1_data < rs2_data) ? 1'b1 : 1'b0;

    wire bgeu_out;
    assign bgeu_out = (rs1_data > rs2_data) ? 1'b1 : 1'b0;

    wire [31:0] jalr_out;
    assign jalr_out = (rs1_data + rs2_data) & ~32'b1;

    always @(*) begin
        case (exe_fn)
            `BR_BEQ   : jump_flag_reg <= beq_out;
            `BR_BNE   : jump_flag_reg <= bne_out;
            `BR_BLT   : jump_flag_reg <= blt_out;
            `BR_BGE   : jump_flag_reg <= bge_out;
            `BR_BLTU  : jump_flag_reg <= bltu_out;
            `BR_BGEU  : jump_flag_reg <= bgeu_out;
            default   : jump_flag_reg <= 1'b0;
        endcase
        case (exe_fn)
            `ALU_JALR : jump_target_reg <= jalr_out;
            default   : jump_target_reg <= rs2_data;
        endcase
    end

    assign jump_flag = jump_flag_reg;
    assign jump_target = jump_target_reg;

endmodule