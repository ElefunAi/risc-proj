// memoryモジュール
module mem (
    input wire clk,
    input wire [31:0] addr,
    output wire [31:0] read_data
);
    // 4byte*4096行=16384byte=16KB
    reg [31:0] rom [0:4095];
    reg [31:0] read_reg;

    initial begin
        $readmemh("./src/hex/c.hex", rom);
    end
    
    always @(posedge clk) begin
        read_reg <= rom[addr];
    end

    assign read_data = read_reg;
endmodule