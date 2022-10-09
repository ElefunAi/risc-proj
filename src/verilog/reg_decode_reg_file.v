`include "define.vh"
module reg_decode_reg_file (
    input wire clk,
    input wire reset,
    input wire [4:0] op1_addr, op2_addr,
    input wire [31:0] pc, imm,
    input wire [1:0] op1,
    input wire [2:0] op2,

    input wire write_en,
    input wire [4:0] write_addr,
    input wire [31:0] write_value,

    output wire [31:0] rs1_data, rs2_data
);

    reg [31:0] reg_file [0:31];
    reg [31:0] rs1_data_reg, rs2_data_reg;

    always @(posedge clk) begin
        if (reset) begin
            reg_file[0] <= 32'b0; //ゼロレジスタ
            reg_file[2] <= 32'h100; //sp スタックポイント
        end
        else if (write_en) begin
            reg_file[write_addr] <= write_value;
        end

        case (op1)
            `OP1_X      : rs1_data_reg <= 32'b0;
            `OP1_RS1    : rs1_data_reg <= reg_file[op1_addr];
            `OP1_PC     : rs1_data_reg <= pc;
            default     : rs1_data_reg <= 32'bx;
        endcase

        case (op2)
            `OP2_X      : rs2_data_reg <= 32'b0;
            `OP2_RS2    : rs2_data_reg <= reg_file[op2_addr];
            `OP2_IMI,
            `OP2_IMS,
            `OP2_IMJ,
            `OP2_IMU    : rs2_data_reg <= imm;
            default     : rs2_data_reg <= 32'bx;
        endcase

    end

    assign rs1_data = rs1_data_reg;
    assign rs2_data = rs2_data_reg;

endmodule