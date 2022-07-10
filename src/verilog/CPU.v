module CPU;

    wire clk;
    wire [4:0] exe_fn;
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;
    wire [31:0] alu_out;
    wire [31:0] pc;
    wire jump_flag,
    wire [31:0] jump_target,

    decoder decoder (
        .inst(pc),
        .op1_data(rs1_data),
        .op2_data(rs2_data),
        .exe_fun(exe_fn),
        .op1(),
        .mem_wen(),
        .op2(),
        .wb_sel(),
        .rf_wen()
    );

    ALU ALU (
        .alu_fn(exe_fn),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .out(alu_out)
    );

    jump_controller jump_controller (
        .exe_fn(exe_fn),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .jump_flag(jump_flag),
        .jump_target(jump_target),
    );

    PC PC (
        .clk(clk),
        .jump_flag(jump_flag),
        .jump_target(jump_target),
        .pc(pc)
    );

    mem mem (
    .clk(clk),
    .write_en(),
    .addr(),
    .write_data(),
    .read_data()
);
endmodule
