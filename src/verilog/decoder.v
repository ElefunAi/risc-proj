`include "define.vh"
module decoder (
    input wire [31:0] inst,
    output wire [31:0] imm,
    output wire [4:0] op1_addr, op2_addr, rd_addr,
    output reg [4:0] exe_fun,
    output reg mem_wen, rf_wen,
    output reg [1:0] op1, wb_sel,
    output reg [2:0] op2
);
    // 宣言
    // 内部信号
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;

    // opcodeから命令形式保持(R,I,S,B,U,Jなので、3bitレジスタで保持)
    reg [2:0] alu_x;

    // assign
    assign opcode = inst[6:0];
    assign rd = inst[11:7];
    assign funct3 = inst[14:12];
    assign funct7 = inst[31:25];
    assign rs1 = inst[19:15];
    assign rs2 = inst[24:20];

    // デコーダが渡すもの
    // exe_fun(演算内容),op1(第1オペランド),op2(第2オペランド),mem_wen(メモリenable),
    // rf_wen(ライトバックenable),wb_sel(ライトバックデータセレクタ)
    // wb_selで例えばWB_ALUは、ALUの出力をレジスタへ書き戻すことを表す
    // つまり、reg_fileにとってはWB_ALU & rf_wen(Write ENable)がenable信号
    // reg_fileに対して=>32bit op1_addr, op2_addr, rd_addr, imm(即値)
    assign op1_addr = inst[19:15];
    assign op2_addr = inst[24:20];
    assign rd_addr = inst[11:7];
    // 即値の扱い方 risc-v ISA manual参照(P.24)
    assign imm = (opcode == `LUI || opcode == `AUIPC) ? {inst[31:12], 12'd0} : // U-format
                 (opcode == `JAL) ? {{11{inst[31]}},inst[31],inst[19:12],inst[20],inst[30:21],1'd0} : // J-format
                 (opcode == `JALR || opcode == `LW || opcode == `OPIMI) ? {{20{inst[31]}},inst[31],inst[30:25],inst[24:21],inst[20]} : // I-format
                 (opcode == `BRANCH) ? {{18{inst[31]}},inst[31],inst[7],inst[30:25],inst[11:8],1'd0} : //B-format
                 (opcode == `STORE) ? {{20{inst[31]}},inst[31],inst[30:25],inst[11:8],inst[7]} : 32'd0;// ? S-format : R-format(即値なし)

    always @(*) begin
        case (opcode)
            `LUI : begin
                exe_fun = `ALU_ADD;
                op1 = `OP1_X;
                op2 = `OP2_IMU; 
                mem_wen = `MEN_X;
                rf_wen = `REN_S;
                wb_sel = `WB_ALU;
            end
            `AUIPC : begin
                exe_fun = `ALU_ADD;
                op1 = `OP1_PC;
                op2 = `OP2_IMU;
                mem_wen = `MEN_X;
                rf_wen = `REN_S;
                wb_sel = `WB_ALU;                
            end
            `JAL : begin
                exe_fun = `ALU_ADD;
                op1 = `OP1_PC;
                op2 = `OP2_IMJ; 
                mem_wen = `MEN_X;
                rf_wen = `REN_S;
                wb_sel = `WB_PC;                
            end
            `JALR : begin
                exe_fun = `ALU_JALR;
                op1 = `OP1_RS1;
                op2 = `OP2_IMI; 
                mem_wen = `MEN_X;
                rf_wen = `REN_S;
                wb_sel = `WB_PC;                
            end
            `BRANCH : begin
                case (funct3)
                    3'b000 : begin  //BEQ
                        exe_fun = `BR_BEQ;
                        op1 = `OP1_RS1;
                        op2 = `OP2_RS2;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_X;
                        wb_sel = `WB_X;                        
                    end
                    3'b001 : begin  //BNE
                        exe_fun = `BR_BNE;
                        op1 = `OP1_RS1;
                        op2 = `OP2_RS2;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_X;
                        wb_sel = `WB_X;                        
                    end
                    3'b100 : begin  //BLT
                        exe_fun = `BR_BLT;
                        op1 = `OP1_RS1;
                        op2 = `OP2_RS2;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_X;
                        wb_sel = `WB_X;                        
                    end
                    3'b101 : begin  //BGE
                        exe_fun = `BR_BGE;
                        op1 = `OP1_RS1;
                        op2 = `OP2_RS2;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_X;
                        wb_sel = `WB_X;                        
                    end
                    3'b110 : begin  //BLTU
                        exe_fun = `BR_BLTU;
                        op1 = `OP1_RS1;
                        op2 = `OP2_RS2;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_X;
                        wb_sel = `WB_X;                        
                    end
                    3'b111 : begin  //BGEU
                        exe_fun = `BR_BGEU;
                        op1 = `OP1_RS1;
                        op2 = `OP2_RS2;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_X;
                        wb_sel = `WB_X;                        
                    end
                    default: begin //NOP=>_Xで統一
                        exe_fun = `ALU_X;
                        op1 = `OP1_X;
                        op2 = `OP2_X;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_X;
                        wb_sel = `WB_X;
                    end
                endcase
            end
            `LW : begin
                exe_fun = `ALU_ADD;
                op1 = `OP1_RS1;
                op2 = `OP2_IMI; 
                mem_wen = `MEN_X;
                rf_wen = `REN_S;
                wb_sel = `WB_MEM;                
            end
            `STORE : begin
                exe_fun = `ALU_ADD;
                op1 = `OP1_RS1;
                op2 = `OP2_IMS; 
                mem_wen = `MEN_S;
                rf_wen = `REN_X;
                wb_sel = `WB_X;                
            end
            `OPIMI : begin
                case (funct3)
                    3'b000 : begin  //ADDI
                        exe_fun = `ALU_ADD;
                        op1 = `OP1_RS1;
                        op2 = `OP2_IMI;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_S;
                        wb_sel = `WB_ALU;                        
                    end
                    3'b001 : begin  //SLLI
                        exe_fun = `ALU_SLL;
                        op1 = `OP1_RS1;
                        op2 = `OP2_IMI;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_S;
                        wb_sel = `WB_ALU;                        
                    end
                    3'b010 : begin  //SLTI
                        exe_fun = `ALU_SLT;
                        op1 = `OP1_RS1;
                        op2 = `OP2_IMI;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_S;
                        wb_sel = `WB_ALU;                        
                    end
                    3'b011 : begin  //SLTIU
                        exe_fun = `ALU_SLTU;
                        op1 = `OP1_RS1;
                        op2 = `OP2_IMI;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_S;
                        wb_sel = `WB_ALU;                             
                    end
                    3'b100 : begin  //XORI
                        exe_fun = `ALU_XOR;
                        op1 = `OP1_RS1;
                        op2 = `OP2_IMI;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_S;
                        wb_sel = `WB_ALU;                        
                    end
                    3'b101 : begin
                        case (funct7)
                            7'b0000000 : begin  //SRLI
                                exe_fun = `ALU_SRL;
                                op1 = `OP1_RS1;
                                op2 = `OP2_IMI;
                                mem_wen = `MEN_X;
                                rf_wen = `REN_S;
                                wb_sel = `WB_ALU;                                
                            end
                            7'b0100000 : begin  //SRAI
                                exe_fun = `ALU_SRA;
                                op1 = `OP1_RS1;
                                op2 = `OP2_IMI;
                                mem_wen = `MEN_X;
                                rf_wen = `REN_S;
                                wb_sel = `WB_ALU;                                
                            end
                            default: begin //NOP=>_Xで統一
                                exe_fun = `ALU_X;
                                op1 = `OP1_X;
                                op2 = `OP2_X;
                                mem_wen = `MEN_X;
                                rf_wen = `REN_X;
                                wb_sel = `WB_X;
                            end
                        endcase
                    end
                    3'b110 : begin  //ORI
                        exe_fun = `ALU_OR;
                        op1 = `OP1_RS1;
                        op2 = `OP2_IMI;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_S;
                        wb_sel = `WB_ALU;                        
                    end
                    3'b111 : begin  //ANDI
                        exe_fun = `ALU_AND;
                        op1 = `OP1_RS1;
                        op2 = `OP2_IMI;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_S;
                        wb_sel = `WB_ALU;                        
                    end
                    default: begin //NOP=>_Xで統一 
                        exe_fun = `ALU_X;
                        op1 = `OP1_X;
                        op2 = `OP2_X;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_X;
                        wb_sel = `WB_X;
                    end
                endcase
            end
            `OPRS2 : begin
                case (funct3)
                    3'b000 : begin
                        case (funct7)
                            7'b0000000 :  begin  //ADD
                                exe_fun = `ALU_ADD;
                                op1 = `OP1_RS1;
                                op2 = `OP2_RS2;
                                mem_wen = `MEN_X;
                                rf_wen = `REN_S;
                                wb_sel = `WB_ALU;
                            end
                            7'b0100000 :  begin  //SUB
                                exe_fun = `ALU_SUB;
                                op1 = `OP1_RS1;
                                op2 = `OP2_RS2;
                                mem_wen = `MEN_X;
                                rf_wen = `REN_S;
                                wb_sel = `WB_ALU;
                            end
                            default: begin //NOP=>_Xで統一 
                                exe_fun = `ALU_X;
                                op1 = `OP1_X;
                                op2 = `OP2_X;
                                mem_wen = `MEN_X;
                                rf_wen = `REN_X;
                                wb_sel = `WB_X;
                            end
                        endcase
                    end
                    3'b001 : begin  //SLL
                        exe_fun = `ALU_SLL;
                        op1 = `OP1_RS1;
                        op2 = `OP2_RS2;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_S;
                        wb_sel = `WB_ALU;                        
                    end
                    3'b010 : begin  //SLT
                        exe_fun = `ALU_SLT;
                        op1 = `OP1_RS1;
                        op2 = `OP2_RS2;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_S;
                        wb_sel = `WB_ALU;                        
                    end
                    3'b011 : begin  //SLTU
                        exe_fun = `ALU_SLTU;
                        op1 = `OP1_RS1;
                        op2 = `OP2_RS2;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_S;
                        wb_sel = `WB_ALU;                        
                    end
                    3'b100 : begin  //XOR
                        exe_fun = `ALU_XOR;
                        op1 = `OP1_RS1;
                        op2 = `OP2_RS2;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_S;
                        wb_sel = `WB_ALU;                        
                    end
                    3'b101 : begin
                        case (funct7)
                            7'b0000000 :  begin  //SRL
                                exe_fun = `ALU_SRL;
                                op1 = `OP1_RS1;
                                op2 = `OP2_RS2;
                                mem_wen = `MEN_X;
                                rf_wen = `REN_S;
                                wb_sel = `WB_ALU; 
                            end
                            7'b0100000 :  begin  //SRA
                                exe_fun = `ALU_SRA;
                                op1 = `OP1_RS1;
                                op2 = `OP2_RS2;
                                mem_wen = `MEN_X;
                                rf_wen = `REN_S;
                                wb_sel = `WB_ALU; 
                            end
                            default: begin //NOP=>_Xで統一
                                exe_fun = `ALU_X;
                                op1 = `OP1_X;
                                op2 = `OP2_X;
                                mem_wen = `MEN_X;
                                rf_wen = `REN_X;
                                wb_sel = `WB_X;
                            end
                        endcase
                    end
                    3'b110 : begin  //OR
                        exe_fun = `ALU_OR;
                        op1 = `OP1_RS1;
                        op2 = `OP2_RS2;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_S;
                        wb_sel = `WB_ALU;                        
                    end
                    3'b111 : begin  //AND
                        exe_fun = `ALU_AND;
                        op1 = `OP1_RS1;
                        op2 = `OP2_RS2;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_S;
                        wb_sel = `WB_ALU;                        
                    end
                    default: begin //NOP=>_Xで統一 
                        exe_fun = `ALU_X;
                        op1 = `OP1_X;
                        op2 = `OP2_X;
                        mem_wen = `MEN_X;
                        rf_wen = `REN_X;
                        wb_sel = `WB_X;
                    end
                endcase
            end
            default: begin //NOP=>_Xで統一 
                exe_fun = `ALU_X;
                op1 = `OP1_X;
                op2 = `OP2_X;
                mem_wen = `MEN_X;
                rf_wen = `REN_X;
                wb_sel = `WB_X;
            end
        endcase
    end
endmodule