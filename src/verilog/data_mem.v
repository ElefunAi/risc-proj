// memoryモジュール
module data_mem (
    input wire clk,
    input wire write_en,
    input wire [31:0] addr,
    input wire [31:0] write_data,
    output wire [31:0] read_data
);
    // 4byte*4096行=16384byte=16KB
    reg [31:0] rom [0:2**12-1];
    reg [31:0] read_reg;
    
    always @(negedge clk) begin
        read_reg <= rom[addr[11:0]];
        if (write_en) begin
            rom[addr[11:0]] <= write_data;
        end
    end

    assign read_data = read_reg;
endmodule