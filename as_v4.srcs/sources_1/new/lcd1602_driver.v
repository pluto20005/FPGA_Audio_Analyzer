`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/25 17:06:24
// Design Name: 
// Module Name: lcd1602_driver
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


module lcd1602_driver(
    input  wire       clk,                          //输入时钟50MHZ
    input  wire       rst_n,
    input  wire       [7:0] d1, d2, d3, d4, d5,     // 传入的 5 位频率 ASCII 字符
    input             [31:0] nfft_chars,            //FFT点数字符
    input             [23:0] note_name,             //音名字符
    input             [31:0] gain_chars,            //增益字符
    output reg        lcd_rs,
    output wire       lcd_rw,
    output reg        lcd_e,
    output reg        [7:0] lcd_db
);

    assign lcd_rw = 1'b0; // 只写模式

    reg [23:0] cnt;
    parameter CLK_FREQ = 50_000_000;
    
    // 状态机定义
    reg [5:0] state;
    localparam IDLE=0, INIT_1=1, INIT_2=2, INIT_3=3, INIT_4=4, 
               LINE1_ADDR=5, LINE1_STR=6, LINE2_ADDR=7, LINE2_STR=8, WAIT=9,WAIT_1=10;
    localparam LINE1_END_ADDR = 20, LINE1_NFFT_STR = 21;
    localparam LINE2_END_ADDR = 22, LINE2_YM_STR = 23;
    localparam LINE1_MID_ADDR = 24, LINE1_G_STR = 25;

    reg [3:0] char_cnt;
    reg [5:0] next_state;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            lcd_e <= 0;
            cnt <= 0;
        end else begin
            case(state)
                IDLE: begin
                    if (cnt < CLK_FREQ/100) cnt <= cnt + 1; 
                    else begin cnt <= 0; state <= INIT_1; end
                end
                
                // --- 初始化序列 ---
                INIT_1: begin // 0x38: 8位数据, 2行显示
                    lcd_rs <= 0; lcd_db <= 8'h38;
                    state <= WAIT; next_state <= INIT_2;
                end
                INIT_2: begin // 0x0C: 开显示, 无光标
                    lcd_rs <= 0; lcd_db <= 8'h0C;
                    state <= WAIT; next_state <= INIT_3;
                end
                INIT_3: begin // 0x06: 光标右移
                    lcd_rs <= 0; lcd_db <= 8'h06;
                    state <= WAIT; next_state <= INIT_4;
                end
                INIT_4: begin // 0x01: 清屏
                    lcd_rs <= 0; lcd_db <= 8'h01;
                    state <= WAIT_1; next_state <= LINE1_ADDR;
                end
                // --- 第一行显示 "Freq:" ---
                LINE1_ADDR: begin
                    lcd_rs <= 0; 
                    lcd_db <= 8'h80; // 第一行起始地址
                    state <= WAIT; 
                    next_state <= LINE1_STR;
                    char_cnt <= 0;
                end
                LINE1_STR: begin
                    lcd_rs <= 1;
                    case(char_cnt)
                        0: lcd_db <= "F"; 
                        1: lcd_db <= "r"; 
                        2: lcd_db <= "e";
                        3: lcd_db <= "q"; 
                        4: lcd_db <= ":"; 
                        5: lcd_db <= " ";
                        default: lcd_db <= " ";
                    endcase
                    if(char_cnt < 6) begin 
                        char_cnt <= char_cnt + 1; 
                        state <= WAIT; 
                        next_state <= LINE1_STR; end
                    else begin 
                        state <= LINE1_MID_ADDR; 
                    end
                end
                // --- 第一行中间 增益值 ---
                LINE1_MID_ADDR: begin
                    lcd_rs <= 0;
                    lcd_db <= 8'h87; // 第一行中间地址
                    state <= WAIT; 
                    next_state <= LINE1_G_STR;
                    char_cnt <= 0;
                end
                // 显示增益值
                LINE1_G_STR: begin
                    lcd_rs <= 1;
                    case(char_cnt)
                        0: lcd_db <= gain_chars[31:24]; 
                        1: lcd_db <= gain_chars[23:16]; 
                        2: lcd_db <= gain_chars[15:8];  
                        3: lcd_db <= gain_chars[7:0];   
                        4: lcd_db <= " ";   
                        default: lcd_db <= " ";
                    endcase
                    
                    if(char_cnt < 4) begin
                        char_cnt <= char_cnt + 1;
                        state <= WAIT;
                        next_state <= LINE1_G_STR;
                    end else begin
                        state <= LINE1_END_ADDR; 
                    end
                end
                // --- 第一行末尾 点数值 ---
                LINE1_END_ADDR: begin
                    lcd_rs <= 0;
                    lcd_db <= 8'h8C; // 第一行最后四位的起始地址
                    state <= WAIT; 
                    next_state <= LINE1_NFFT_STR;
                    char_cnt <= 0;
                end
                // 显示点数内容
                LINE1_NFFT_STR: begin
                    lcd_rs <= 1;
                    case(char_cnt)
                        0: lcd_db <= nfft_chars[31:24]; 
                        1: lcd_db <= nfft_chars[23:16]; 
                        2: lcd_db <= nfft_chars[15:8];  
                        3: lcd_db <= nfft_chars[7:0];   
                        4: lcd_db <= " ";   
                        default: lcd_db <= " ";
                    endcase
                    
                    if(char_cnt < 4) begin
                        char_cnt <= char_cnt + 1;
                        state <= WAIT;
                        next_state <= LINE1_NFFT_STR;
                    end else begin
                        state <= LINE2_ADDR; 
                    end
                end
                // --- 第二行显示 频率值 ---
                LINE2_ADDR: begin
                    lcd_rs <= 0; 
                    lcd_db <= 8'hC0; // 第二行起始地址
                    state <= WAIT; 
                    next_state <= LINE2_STR;
                    char_cnt <= 0;
                end
                LINE2_STR: begin
                    lcd_rs <= 1;
                    case(char_cnt)
                        0: lcd_db <= d1; 
                        1: lcd_db <= d2; 
                        2: lcd_db <= d3;
                        3: lcd_db <= d4; 
                        4: lcd_db <= d5; 
                        5: lcd_db <= " ";
                        6: lcd_db <= "H"; 
                        7: lcd_db <= "z";
                        default: lcd_db <= " ";
                    endcase
                    if(char_cnt < 8) begin 
                        char_cnt <= char_cnt + 1; 
                        state <= WAIT; 
                        next_state <= LINE2_STR; 
                    end
                    else begin 
                        cnt <= 0; 
                        state <= LINE2_END_ADDR; 
                    end 
                end
                // --- 第二行末尾 显示音名 ---
                LINE2_END_ADDR: begin
                    lcd_rs <= 0;
                    lcd_db <= 8'hCD;
                    state <= WAIT; 
                    next_state <= LINE2_YM_STR;
                    char_cnt <= 0;
                end
                // 显示音名
                LINE2_YM_STR: begin
                    lcd_rs <= 1;
                    case(char_cnt)
                        0: lcd_db <= note_name[23:16]; 
                        1: lcd_db <= note_name[15:8]; 
                        2: lcd_db <= note_name[7:0];  
                        3: lcd_db <= " ";    
                        default: lcd_db <= " ";
                    endcase
                    
                    if(char_cnt < 3) begin
                        char_cnt <= char_cnt + 1;
                        state <= WAIT;
                        next_state <= LINE2_YM_STR;
                    end else begin
                        state <= IDLE;      // 回到起始周期刷新
                    end
                end


                // --- 通用等待/使能脉冲产生 ---
                WAIT: begin
                    if (cnt < 7000) begin // 产生 Enable 高电平脉冲
                        cnt <= cnt + 1;
                        if (cnt > 500 && cnt < 3500) lcd_e <= 1;
                        else lcd_e <= 0;
                    end else begin
                        cnt <= 0;
                        state <= next_state;
                    end
                end


                // --- 长等待 用于LCD清屏 ---
                WAIT_1: begin
                    if (cnt < 80000) begin 
                        cnt <= cnt + 1;
                        if (cnt > 1000 && cnt < 10000) lcd_e <= 1;
                        else lcd_e <= 0;
                    end else begin
                        cnt <= 0;
                        state <= next_state;
                    end
                end
            endcase
        end
    end

endmodule
