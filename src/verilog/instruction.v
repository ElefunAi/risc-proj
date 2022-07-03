// ロード・ストア
`define LW     31'bxxxxxxxxxxxxxxxxx010xxxxx0000011
`define SW     31'bxxxxxxxxxxxxxxxxx010xxxxx0100011

// 加算
`define ADD    31'b0000000xxxxxxxxxx000xxxxx0110011
`define ADDI   31'bxxxxxxxxxxxxxxxxx000xxxxx0010011

// 減算
`define SUB    31'b0100000xxxxxxxxxx000xxxxx0110011

// 論理演算
`define AND    31'b0000000xxxxxxxxxx111xxxxx0110011
`define OR     31'b0000000xxxxxxxxxx110xxxxx0110011
`define XOR    31'b0000000xxxxxxxxxx100xxxxx0110011
`define ANDI   31'bxxxxxxxxxxxxxxxxx111xxxxx0010011
`define ORI    31'bxxxxxxxxxxxxxxxxx110xxxxx0010011
`define XORI   31'bxxxxxxxxxxxxxxxxx100xxxxx0010011

// シフト
`define SLL    31'b0000000xxxxxxxxxx001xxxxx0110011
`define SRL    31'b0000000xxxxxxxxxx101xxxxx0110011
`define SRA    31'b0100000xxxxxxxxxx101xxxxx0110011
`define SLLI   31'b0000000xxxxxxxxxx001xxxxx0010011
`define SRLI   31'b0000000xxxxxxxxxx101xxxxx0010011
`define SRAI   31'b0100000xxxxxxxxxx101xxxxx0010011

// 比較
`define SLT    31'b0000000xxxxxxxxxx010xxxxx0110011
`define SLTU   31'b0000000xxxxxxxxxx011xxxxx0110011
`define SLTI   31'bxxxxxxxxxxxxxxxxx010xxxxx0010011
`define SLTIU  31'bxxxxxxxxxxxxxxxxx011xxxxx0010011

// 条件分岐
`define BEQ    31'bxxxxxxxxxxxxxxxxx000xxxxx1100011
`define BNE    31'bxxxxxxxxxxxxxxxxx001xxxxx1100011
`define BLT    31'bxxxxxxxxxxxxxxxxx100xxxxx1100011
`define BGE    31'bxxxxxxxxxxxxxxxxx101xxxxx1100011
`define BLTU   31'bxxxxxxxxxxxxxxxxx110xxxxx1100011
`define BGEU   31'bxxxxxxxxxxxxxxxxx111xxxxx1100011

// ジャンプ
`define JAL    31'bxxxxxxxxxxxxxxxxxxxxxxxxx1101111
`define JALR   31'bxxxxxxxxxxxxxxxxx000xxxxx1100111

// 即値ロード
`define LUI    31'bxxxxxxxxxxxxxxxxxxxxxxxxx0110111
`define AUIPC  31'bxxxxxxxxxxxxxxxxxxxxxxxxx0010111

// ここから下は実装なし
// CSR
`define CSRRW  31'bxxxxxxxxxxxxxxxxx001xxxxx1110011
`define CSRRWI 31'bxxxxxxxxxxxxxxxxx101xxxxx1110011
`define CSRRS  31'bxxxxxxxxxxxxxxxxx010xxxxx1110011
`define CSRRSI 31'bxxxxxxxxxxxxxxxxx110xxxxx1110011
`define CSRRC  31'bxxxxxxxxxxxxxxxxx011xxxxx1110011
`define CSRRCI 31'bxxxxxxxxxxxxxxxxx111xxxxx1110011

// 例外
`define ECALL  31'b00000000000000000000000001110011