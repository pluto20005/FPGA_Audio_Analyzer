`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/27 01:12:16
// Design Name: 
// Module Name: key_debounce
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


module key_debounce (
    input  wire clk,      // 假设 50MHz
    input  wire r_n,    // 复位
    input  wire key_in,   // 物理按键输入
    output reg  key_posedge // 按键上升沿脉冲（有效触发信号）
);

    // 20ms 消抖计数器：50MHz * 0.02s = 1,000,000
    parameter COUNT_MAX = 1_000_000;
    reg [19:0] cnt;
    reg key_reg;

    // 1. 同步按键输入，消除亚稳态
    reg key_s0, key_s1;
    always @(posedge clk) begin
        key_s0 <= key_in;
        key_s1 <= key_s0;
    end

    // 2. 状态监测与计数
    always @(posedge clk or negedge r_n) begin
        if (!r_n) begin
            cnt <= 0;
            key_reg <= key_s1;
        end else begin
            if (key_s1 != key_reg) begin
                // 如果当前输入与寄存器值不同，说明在抖动或刚开始切换，计数器累加
                if (cnt < COUNT_MAX)
                    cnt <= cnt + 1;
                else begin
                    // 计数达到 20ms，说明电平稳定，更新寄存器值
                    cnt <= 0;
                    key_reg <= key_s1;
                end
            end else begin
                // 电平没有变化，计数器清零
                cnt <= 0;
            end
        end
    end

    // 3. 提取上升沿（假设按键按下为高电平）
    reg key_reg_d1;
    always @(posedge clk) begin
        key_reg_d1 <= key_reg;
        // 当 key_reg 从 0 变为 1 的那一瞬间，输出一个周期的脉冲
        key_posedge <= key_reg && !key_reg_d1;
    end

endmodule

