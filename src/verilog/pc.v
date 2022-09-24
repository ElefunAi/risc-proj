module PC (
    input wire clk,reset,
    input wire jump_flag,
    input wire [31:0] jump_target,
    output wire [31:0] pc
);
    reg [31:0] pc_reg;

    always @(posedge clk) begin
        if (reset) pc_reg <= 32'b0;
        else pc_reg <= (jump_flag) ? jump_target : pc + 4;
    end

    assign pc = pc_reg;

endmodule