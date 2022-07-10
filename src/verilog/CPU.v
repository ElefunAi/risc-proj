module CPU;
    wire [31:0] ;
    wire ;

    decoder decoder (
        .inst(),
        .op1_data(),
        .op2_data(),
        .exe_fun(),
        .op1(),
        .mem_wen(),
        .op2(),
        .wb_sel(),
        .rf_wen()
    );

    ALU ALU (
        .alu_fn(),
        .rs1_data(),
        .rs2_data(),
        .out()
    );

    PC PC (
        .clk(),
        .jump_flag(),
        .jump_target(),
        .pc()
    );

    mem mem (
    .clk(),
    .write_en(),
    .addr(),
    .write_data(),
    .read_data()
);
endmodule