`timescale 1ns / 1ps


module fft_config_manager (
    input  wire       clk,               //输入时钟
    input  wire       rst_n,             //复位
    input  wire       btn_switch_s0,     // 切换按键s0
    input  wire       btn_switch_s1,     // 切换按键s1
    input  wire       btn_switch_s2,     // 切换按键s2
    input  wire       btn_switch_s3,     // 切换按键s3
    output reg [4:0]  curr_nfft,         // 输出给 TLAST 计数器和频率换算逻辑
    output reg [23:0] config_tdata,
    output reg        config_tvalid,
    input  wire       config_tready
);

    // 1. 按键消抖      btn_edge为按键上升沿脉冲

    key_debounce key_debounce_S0(
        .clk(clk),
        .r_n(rst_n),
        .key_in(btn_switch_s0),
        .key_posedge(btn_edge_S0)
    );

    key_debounce key_debounce_S1(
        .clk(clk),
        .r_n(rst_n),
        .key_in(btn_switch_s1),
        .key_posedge(btn_edge_S1)
    );

    key_debounce key_debounce_S2(
        .clk(clk),
        .r_n(rst_n),
        .key_in(btn_switch_s2),
        .key_posedge(btn_edge_S2)
    );

    key_debounce key_debounce_S3(
        .clk(clk),
        .r_n(rst_n),
        .key_in(btn_switch_s3),
        .key_posedge(btn_edge_S3)
    );

    wire btn_edge_S0;       //1024
    wire btn_edge_S1;       //512
    wire btn_edge_S2;       //256
    wire btn_edge_S3;       //128



    
    // 2. 切换逻辑
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            curr_nfft <= 5'd10; // 默认 1024 点
            config_tvalid <= 0;
        end else if (btn_edge_S0) begin
            curr_nfft <= 5'd10;
            config_tvalid <= 1; // 触发一次配置
        end 
        else if (btn_edge_S1) begin
            curr_nfft <= 5'd9;
            config_tvalid <= 1; // 触发一次配置
        end
        else if (btn_edge_S2) begin
            curr_nfft <= 5'd8;
            config_tvalid <= 1; // 触发一次配置
        end
        else if (btn_edge_S3) begin
            curr_nfft <= 5'd7;
            config_tvalid <= 1; // 触发一次配置
        end
        else if (config_tready && config_tvalid) begin
            config_tvalid <= 0;
        end
    end

    // 3. 组装配置数据
    always @(*) begin
        config_tdata = 24'b0;
        config_tdata[4:0] = curr_nfft;
        config_tdata[8]   = 1'b1; // Forward FFT
        config_tdata[18:9] = 10'h155;
    end
endmodule

