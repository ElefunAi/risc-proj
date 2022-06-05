`include "instruction.v"

module ALU (
    input wire [31:0] inst_id,
    input wire [31:0] rs1,
    input wire [31:0] rs2,
    output wire [31:0] out
);

    reg [31:0] out_reg;
    assign out = out_reg;
    
    always @(*) begin
        case (inst_id)
            ADD: out_reg = rs1 + rs2;
            default: out_reg = out_reg;
        endcase
    end
    
endmodule