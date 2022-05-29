// memoryモジュール
module mem (
    input wire clk,
    input wire write_en,
    input wire [31:0] addr,
    input wire [31:0] write_data,
    output wire [31:0] read_data
);
    // 4byte*4096行=16384byte=16KB
    reg [31:0] rom [0:4096];
    reg [31:0] read_reg;

    initial begin
        $readmemh("../hex/data.hex", rom);
    end
    
    always @(posedge clk) begin
        read_reg <= rom[addr];
        if (write_en) begin
            rom[addr] <= write_data;
        end
    end

    assign read_data = read_reg;
endmodule