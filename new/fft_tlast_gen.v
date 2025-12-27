`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/24 21:58:00
// Design Name: 
// Module Name: fft_tlast_gen
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


module fft_tlast_gen(
    input wire       clk,
    input wire       rstn,
    input wire [4:0] curr_nfft,        // 来自配置模块，值为 10, 9, 8, 7
    input wire       fft_s_axis_tvalid,
    input wire       fft_s_axis_ready,
    output wire      s_axis_data_tlast
);

    reg [9:0] fft_cnt;
    reg [9:0] terminal_count;

    // 1. 根据点数设置计数终点 (N-1)
    always @(*) begin
        case(curr_nfft)
            5'd10:   terminal_count = 10'd1023; // 1024点
            5'd9:    terminal_count = 10'd511;  // 512点
            5'd8:    terminal_count = 10'd255;  // 256点
            5'd7:    terminal_count = 10'd127;  // 128点
            default: terminal_count = 10'd1023;
        endcase
    end

    // 2. 计数逻辑
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            fft_cnt <= 0;
        end else if (fft_s_axis_tvalid && fft_s_axis_ready) begin
            if (fft_cnt >= terminal_count) 
                fft_cnt <= 0;
            else
                fft_cnt <= fft_cnt + 1;
        end
    end

    // 3. 生成 TLAST
    // 注意：tlast 必须与该帧的最后一个数据对齐
    assign s_axis_data_tlast = (fft_s_axis_tvalid && fft_s_axis_ready) && (fft_cnt == terminal_count);
    
endmodule

