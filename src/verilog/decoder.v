`include "define.vh"
module decoder (
    input wire [31:0] inst,
    output wire [31:0] op1_data, op2_data,
    output wire [4:0] exe_fun,
    output wire [1:0] op1, mem_wen, rf_wen
    output wire [2:0] op2, wb_sel,
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
    // exe_fun(演算内容),op1(第1オペランド),op2(第2オペランド),mem_wen(メモリenable),rf_wen(ライトバックenable),wb_sel(ライトバックデータセレクタ)
    // 32bit op1_data, op2_data
    always @(*) begin
        case (opcode)
            `LUI : begin

            end
            `AUIPC : begin
                
            end
            `JAL : begin
                
            end
            `JALR : begin
                
            end
            `BRANCH : begin
                case (funct3)
                    3`b000 : begin  //BEQ
                        
                    end
                    3`b001 : begin  //BNE
                        
                    end
                    3`b100 : begin  //BLT
                        
                    end
                    3`b101 : begin  //BGE
                        
                    end
                    3`b110 : begin  //BLTU
                        
                    end
                    3`b111 : begin  //BGEU
                        
                    end
                    default: //NOP=>_Xで統一
                endcase
            end
            `LW : begin
                
            end
            `STORE : begin
                
            end
            `OPIMI : begin
                case (funct3)
                    3`b000 : begin  //ADDI
                        
                    end
                    3`b001 : begin  //SLLI
                        
                    end
                    3`b010 : begin  //SLTI
                        
                    end
                    3`b011 : begin  //SLTIU
                        
                    end
                    3`b100 : begin  //XORI
                        
                    end
                    3`b101 : begin
                        case (funct7)
                            7`b0000000 : begin  //SRLI
                                
                            end
                            7`b0100000 : begin  //SRAI
                                
                            end
                            default: //NOP=>_Xで統一
                        endcase
                    end
                    3`b110 : begin  //ORI
                        
                    end
                    3`b111 : begin  //ANDI
                        
                    end
                    default: //NOP=>_Xで統一 
                endcase
            end
            `OPRS2 : begin
                case (funct3)
                    3`b000 : begin
                        case (funct7)
                            7`b0000000 :  begin  //ADD

                            end
                            7`b0100000 :  begin  //SUB

                            end
                            default: //NOP=>_Xで統一 
                        endcase
                    end
                    3`b001 : begin  //SLL
                        
                    end
                    3`b010 : begin  //SLT
                        
                    end
                    3`b011 : begin  //SLTU
                        
                    end
                    3`b100 : begin  //XOR
                        
                    end
                    3`b101 : begin
                        case (funct7)
                            7`b0000000 :  begin  //SRL

                            end
                            7`b0100000 :  begin  //SRA

                            end
                            default: //NOP=>_Xで統一 
                        endcase
                    end
                    3`b110 : begin  //OR
                        
                    end
                    3`b111 : begin  //AND
                        
                    end
                    default: //NOP=>_Xで統一 
                endcase
            end
            default: //NOP=>_Xで統一 
        endcase
    end
endmodule