module CPU;
initial begin
    $display("hello");
end

wire clk;
wire jump_flag;
wire [31:0] jump_target;
wire [31:0] pc;

wire [4:0] fn;
wire [31:0] rs1_data;
wire [31:0] rs2_data;
wire [31:0] alu_out;

wire [4:0] op1_addr, op2_addr;
wire [31:0] imm;
wire [1:0] op1;
wire [2:0] op2;
wire reg_write_en;
wire [4:0] reg_write_addr;
wire [31:0] reg_write_value;

wire mem_write_en;
wire [31:0] mem_write_addr;
wire [31:0] mem_write_data;
wire [31:0] mem_out;

PC PC (.clk(clk),
    .jump_flag(jump_flag),
    .jump_target(jump_target),
    .pc(pc)
);

ALU ALU (
    .alu_fn(fn),
    .rs1_data(rs1_data),
    .rs2_data(rs2_data),
    .out(alu_out)
);

jump_controller jump_controller (
    .exe_fn(fn),
    .rs1_data(rs1_data),
    .rs2_data(rs2_data),
    .jump_flag(jump_flag),
    .jump_target(jump_target)
);

reg_decode_reg_file reg_decode_reg_file (
    .clk(clk),
    .op1_addr(op1_addr),
    .op2_addr(op2_addr),
    .pc(pc),
    .imm(imm),
    .op1(op1),
    .op2(op2),
    .write_en(reg_write_en),
    .write_addr(reg_write_addr),
    .write_value(reg_write_value),
    .rs1_data(rs1_data),
    .rs2_data(rs2_data)
);

mem mem (
    .clk(clk),
    .write_en(mem_write_en),
    .addr(mem_write_addr),
    .write_data(mem_write_data),
    .read_data(mem_out)
);

endmodule
