// ロード・ストア
`define LW     b'xxxxxxxxxxxxxxxxx010xxxxx0000011
`define SW     b'xxxxxxxxxxxxxxxxx010xxxxx0100011

// 加算
`define ADD    b'0000000xxxxxxxxxx000xxxxx0110011
`define ADDI   b'xxxxxxxxxxxxxxxxx000xxxxx0010011

// 減算
`define SUB    b'0100000xxxxxxxxxx000xxxxx0110011

// 論理演算
`define AND    b'0000000xxxxxxxxxx111xxxxx0110011
`define OR     b'0000000xxxxxxxxxx110xxxxx0110011
`define XOR    b'0000000xxxxxxxxxx100xxxxx0110011
`define ANDI   b'xxxxxxxxxxxxxxxxx111xxxxx0010011
`define ORI    b'xxxxxxxxxxxxxxxxx110xxxxx0010011
`define XORI   b'xxxxxxxxxxxxxxxxx100xxxxx0010011

// シフト
`define SLL    b'0000000xxxxxxxxxx001xxxxx0110011
`define SRL    b'0000000xxxxxxxxxx101xxxxx0110011
`define SRA    b'0100000xxxxxxxxxx101xxxxx0110011
`define SLLI   b'0000000xxxxxxxxxx001xxxxx0010011
`define SRLI   b'0000000xxxxxxxxxx101xxxxx0010011
`define SRAI   b'0100000xxxxxxxxxx101xxxxx0010011

// 比較
`define SLT    b'0000000xxxxxxxxxx010xxxxx0110011
`define SLTU   b'0000000xxxxxxxxxx011xxxxx0110011
`define SLTI   b'xxxxxxxxxxxxxxxxx010xxxxx0010011
`define SLTIU  b'xxxxxxxxxxxxxxxxx011xxxxx0010011

// 条件分岐
`define BEQ    b'xxxxxxxxxxxxxxxxx000xxxxx1100011
`define BNE    b'xxxxxxxxxxxxxxxxx001xxxxx1100011
`define BLT    b'xxxxxxxxxxxxxxxxx100xxxxx1100011
`define BGE    b'xxxxxxxxxxxxxxxxx101xxxxx1100011
`define BLTU   b'xxxxxxxxxxxxxxxxx110xxxxx1100011
`define BGEU   b'xxxxxxxxxxxxxxxxx111xxxxx1100011

// ジャンプ
`define JAL    b'xxxxxxxxxxxxxxxxxxxxxxxxx1101111
`define JALR   b'xxxxxxxxxxxxxxxxx000xxxxx1100111

// 即値ロード
`define LUI    b'xxxxxxxxxxxxxxxxxxxxxxxxx0110111
`define AUIPC  b'xxxxxxxxxxxxxxxxxxxxxxxxx0010111

// CSR
`define CSRRW  b'xxxxxxxxxxxxxxxxx001xxxxx1110011
`define CSRRWI b'xxxxxxxxxxxxxxxxx101xxxxx1110011
`define CSRRS  b'xxxxxxxxxxxxxxxxx010xxxxx1110011
`define CSRRSI b'xxxxxxxxxxxxxxxxx110xxxxx1110011
`define CSRRC  b'xxxxxxxxxxxxxxxxx011xxxxx1110011
`define CSRRCI b'xxxxxxxxxxxxxxxxx111xxxxx1110011

// 例外
`define ECALL  b'00000000000000000000000001110011