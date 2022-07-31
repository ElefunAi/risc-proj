// decoderモジュールが参照
// RV32Iのみ(例外処理もなし)

// 命令の識別
`define LUI     7'b0110111
`define AUIPC   7'b0010111
`define JAL     7'b1101111
`define JALR    7'b1100111
`define BRANCH  7'b1100011
`define LW      7'b0010111
`define STORE   7'b0100011
`define OPIMI   7'b0010011 //OPERATION IMIDIATE
`define OPRS2   7'b0110011 //OPERATION RS2

// EXE
`define ALU_X    5'd0
`define ALU_ADD  5'd1
`define ALU_SUB  5'd2
`define ALU_AND  5'd3
`define ALU_OR   5'd4
`define ALU_XOR  5'd5
`define ALU_SLL  5'd6
`define ALU_SRL  5'd7
`define ALU_SRA  5'd8
`define ALU_SLT  5'd9
`define ALU_SLTU 5'd10
`define BR_BEQ   5'd11
`define BR_BNE   5'd12
`define BR_BLT   5'd13
`define BR_BGE   5'd14
`define BR_BLTU  5'd15
`define BR_BGEU  5'd16
`define ALU_JALR 5'd17

// op1
`define OP1_X    2'd0
`define OP1_RS1  2'd1
`define OP1_PC   2'd2
//`define OP1_IMZ  2'd3

// op2
`define OP2_X    3'd0
`define OP2_RS2  3'd1
`define OP2_IMI  3'd2
`define OP2_IMS  3'd3
`define OP2_IMJ  3'd4
`define OP2_IMU  3'd5

// mem_wen
`define MEN_X   2'd0
`define MEN_S   2'd1
// `define MEN_V   2'2

// rf_wen

`define REN_X   2'd0
`define REN_S   2'd1
// `define REN_V   2'd2

// wb_sel
`define WB_X      2'd0
`define WB_ALU    2'd1
`define WB_MEM    2'd2
`define WB_PC     2'd3

