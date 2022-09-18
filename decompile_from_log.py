#! /usr/bin/python3

# コマンドライン第一引数で対象のログファイルを指定。

import re
import sys

instructions = {
'LW'    : 'xxxxxxxxxxxxxxxxx010xxxxx0000011',
'SW'    : 'xxxxxxxxxxxxxxxxx010xxxxx0100011',
'ADD'   : '0000000xxxxxxxxxx000xxxxx0110011',
'ADDI'  : 'xxxxxxxxxxxxxxxxx000xxxxx0010011',
'SUB'   : '0100000xxxxxxxxxx000xxxxx0110011',
'AND'   : '0000000xxxxxxxxxx111xxxxx0110011',
'OR'    : '0000000xxxxxxxxxx110xxxxx0110011',
'XOR'   : '0000000xxxxxxxxxx100xxxxx0110011',
'ANDI'  : 'xxxxxxxxxxxxxxxxx111xxxxx0010011',
'ORI'   : 'xxxxxxxxxxxxxxxxx110xxxxx0010011',
'XORI'  : 'xxxxxxxxxxxxxxxxx100xxxxx0010011',
'SLL'   : '0000000xxxxxxxxxx001xxxxx0110011',
'SRL'   : '0000000xxxxxxxxxx101xxxxx0110011',
'SRA'   : '0100000xxxxxxxxxx101xxxxx0110011',
'SLLI'  : '0000000xxxxxxxxxx001xxxxx0010011',
'SRLI'  : '0000000xxxxxxxxxx101xxxxx0010011',
'SRAI'  : '0100000xxxxxxxxxx101xxxxx0010011',
'SLT'   : '0000000xxxxxxxxxx010xxxxx0110011',
'SLTU'  : '0000000xxxxxxxxxx011xxxxx0110011',
'SLTI'  : 'xxxxxxxxxxxxxxxxx010xxxxx0010011',
'SLTIU' : 'xxxxxxxxxxxxxxxxx011xxxxx0010011',
'BEQ'   : 'xxxxxxxxxxxxxxxxx000xxxxx1100011',
'BNE'   : 'xxxxxxxxxxxxxxxxx001xxxxx1100011',
'BLT'   : 'xxxxxxxxxxxxxxxxx100xxxxx1100011',
'BGE'   : 'xxxxxxxxxxxxxxxxx101xxxxx1100011',
'BLTU'  : 'xxxxxxxxxxxxxxxxx110xxxxx1100011',
'BGEU'  : 'xxxxxxxxxxxxxxxxx111xxxxx1100011',
'JAL'   : 'xxxxxxxxxxxxxxxxxxxxxxxxx1101111',
'JALR'  : 'xxxxxxxxxxxxxxxxx000xxxxx1100111',
'LUI'   : 'xxxxxxxxxxxxxxxxxxxxxxxxx0110111',
'AUIPC' : 'xxxxxxxxxxxxxxxxxxxxxxxxx0010111',
'CSRRW' : 'xxxxxxxxxxxxxxxxx001xxxxx1110011',
'CSRRWI': 'xxxxxxxxxxxxxxxxx101xxxxx1110011',
'CSRRS' : 'xxxxxxxxxxxxxxxxx010xxxxx1110011',
'CSRRSI': 'xxxxxxxxxxxxxxxxx110xxxxx1110011',
'CSRRC' : 'xxxxxxxxxxxxxxxxx011xxxxx1110011',
'CSRRCI': 'xxxxxxxxxxxxxxxxx111xxxxx1110011',
'ECALL' : '00000000000000000000000001110011',}

def corresponding (inst_hex: str):
    # 16進数の機械語文字列を入力
    # 命令名、命令コード、入力された機械語の2進数を出力
    inst_bin = format(int(inst_hex, 16), "032b")
    for key, value in instructions.items():
        pattern = value.replace("x", ".")
        if re.compile(pattern).match(inst_bin) is not None:
            return key, value, inst_bin
    else:
        raise


def main ():
    log_file_name = sys.argv[1]
    output_file = "tmp.txt"
    with open(log_file_name, "r") as f:
        log_lines = f.readlines()
    with open(output_file, "w") as f:
        for line in log_lines:
            pattern = r"inst=[0-9a-fx]* "
            result = re.compile(pattern).search(line)
            if result is None:
                raise
            inst_hex = result.group().replace("inst=", "").replace(" ", "")
            if inst_hex == "xxxxxxxx":
                f.write("Not define instruction xxxxxxxx.\n")
            else:
                f.write("\t".join(corresponding(inst_hex)) + "\n")

if __name__ == "__main__":
    main()