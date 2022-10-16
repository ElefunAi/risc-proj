// memoryモジュール
module inst_mem (
    input wire clk,
    input wire [31:0] addr,
    output wire [31:0] read_data
);
    // 1byte*16384行=16384byte=16KB
    reg [7:0] rom [0:16383];
    reg [7:0] read_reg0, read_reg1, read_reg2, read_reg3;

    initial begin
        $readmemh("./src/hex/test1.hex", rom);
    end
    
    always @(posedge clk) begin
        read_reg0 <= rom[addr];
        read_reg1 <= rom[addr+1];
        read_reg2 <= rom[addr+2];
        read_reg3 <= rom[addr+3];
    end

    assign read_data = {read_reg3, read_reg2, read_reg1, read_reg0};
endmodule