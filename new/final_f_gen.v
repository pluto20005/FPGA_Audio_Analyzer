`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/27 02:52:58
// Design Name: 
// Module Name: final_f_gen
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


module final_f_gen(
    input clk,
    input [9:0] max_index,
    input [4:0] curr_nfft,
    output [15:0] final_freq_hz
    );

    // 1. 乘法阶段：Index * Fs
    // 假设 max_index 是 10 位，Fs 是 16 位，结果需要 26 位
    reg [25:0] freq_product;
    always @(posedge clk) begin
        freq_product <= max_index * 48000;
    end

    // 2. 动态移位阶段：根据 curr_nfft 决定除以 2^N
    // N=10 (1024点), N=9 (512点), N=8 (256点), N=7 (128点)
    reg [15:0] final_freq_hz;
    always @(posedge clk) begin
        case(curr_nfft)
            5'd10:   final_freq_hz <= freq_product >> 10; // 相当于 / 1024
            5'd9:    final_freq_hz <= freq_product >> 9;  // 相当于 / 512
            5'd8:    final_freq_hz <= freq_product >> 8;  // 相当于 / 256
            5'd7:    final_freq_hz <= freq_product >> 7;  // 相当于 / 128
            default: final_freq_hz <= freq_product >> 10;
        endcase
    end

endmodule
