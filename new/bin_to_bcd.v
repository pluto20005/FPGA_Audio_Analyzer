`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/28 00:21:14
// Design Name: 
// Module Name: bin_to_bcd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bin_to_bcd(
    input  wire        clk,
    input  wire        rst_n,
    input  wire [15:0] bin_val,      // 输入 16 位二进制频率
    output reg  [3:0]  bcd4, bcd3, bcd2, bcd1, bcd0 // 输出万、千、百、十、个位
);

    integer i;
    reg [35:0] shift_reg; // 16位原码 + 5*4位BCD码 = 36位

    always @(*) begin
        shift_reg = {20'b0, bin_val};
        
        for (i = 0; i < 16; i = i + 1) begin
            // 每一位 BCD 如果大于等于 5，则加 3
            if (shift_reg[19:16] >= 5) shift_reg[19:16] = shift_reg[19:16] + 3;
            if (shift_reg[23:20] >= 5) shift_reg[23:20] = shift_reg[23:20] + 3;
            if (shift_reg[27:24] >= 5) shift_reg[27:24] = shift_reg[27:24] + 3;
            if (shift_reg[31:28] >= 5) shift_reg[31:28] = shift_reg[31:28] + 3;
            if (shift_reg[35:32] >= 5) shift_reg[35:32] = shift_reg[35:32] + 3;
            
            // 整体左移一位
            shift_reg = shift_reg << 1;
        end
        
        {bcd4, bcd3, bcd2, bcd1, bcd0} = shift_reg[35:16];
    end
endmodule

