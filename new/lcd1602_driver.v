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
    input  wire       clk,        // 建议使用 50MHz 或更低，如果是 100MHz 请调大计数器
    input  wire       rst_n,
    input  wire [7:0] d1, d2, d3, d4, d5, // 传入的 5 位频率 ASCII 字符
    input  [31:0] nfft_chars,
    input  [23:0] note_name,
    output reg        lcd_rs,
    output wire       lcd_rw,
    output reg        lcd_e,
    output reg  [7:0] lcd_db
);

    assign lcd_rw = 1'b0; // 只写模式

    // 产生一个约 10Hz 的刷新节拍，防止 LCD 刷新过快看不清
    reg [23:0] cnt;
    parameter CLK_FREQ = 50_000_000;
    parameter DELAY_MS = 2000; // 初始化的长延迟
    
    // 状态机定义
    reg [5:0] state;
    localparam IDLE=0, INIT_1=1, INIT_2=2, INIT_3=3, INIT_4=4, 
               LINE1_ADDR=5, LINE1_STR=6, LINE2_ADDR=7, LINE2_STR=8, WAIT=9,WAIT_1=10;

    localparam LINE1_END_ADDR = 20, LINE1_NFFT_STR = 21;
    localparam LINE2_END_ADDR = 22, LINE2_YM_STR = 23;

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
                    if (cnt < CLK_FREQ/100) cnt <= cnt + 1; // 延迟等待稳定，10毫秒延迟
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

                // 新增状态：显示点数内容
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
                        state <= LINE2_ADDR; // 显示完点数，再去第二行写频率
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

                // 新增状态：显示音名
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
                    if (cnt < 10000) begin // 产生 Enable 高电平脉冲
                        cnt <= cnt + 1;
                        if (cnt > 1000 && cnt < 4000) lcd_e <= 1;
                        else lcd_e <= 0;
                    end else begin
                        cnt <= 0;
                        state <= next_state;
                    end
                end

                WAIT_1: begin
                    if (cnt < 100000) begin // 产生 Enable 高电平脉冲
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

// module lcd1602_driver(
//     input  wire       clk,        // 假设 50MHz
//     input  wire       rst_n,
//     input  wire [7:0] d1, d2, d3, d4, d5, 
    
//     output reg        lcd_rs,
//     output wire       lcd_rw,
//     output reg        lcd_e,
//     output reg  [7:0] lcd_db
// );

//     assign lcd_rw = 1'b0;

//     // 延迟参数计算 (基于 50MHz)
//     parameter DELAY_20MS  = 1_000_000;
//     parameter DELAY_4MS   = 205_000;
//     parameter DELAY_2MS   = 100_000;
//     parameter DELAY_100US = 5_000;
//     parameter DELAY_50US  = 2_500;

//     reg [23:0] cnt;
//     reg [5:0]  state;
//     reg [5:0]  next_state;
//     reg [3:0]  char_cnt;

//     // 状态定义（扩展了初始化步骤）
//     localparam IDLE=0, POWER_ON=1, 
//                HANDSHAKE_1=2, HANDSHAKE_2=3, HANDSHAKE_3=4,
//                FUNC_SET_8BIT=5, FUNC_SET_4BIT=6, FUNC_SET_FINAL=7,
//                DISP_ON=8, ENTRY_MODE=9, CLEAR=10,
//                LINE1_ADDR=11, LINE1_STR=12, LINE2_ADDR=13, LINE2_STR=14, WAIT=15;

//     always @(posedge clk or negedge rst_n) begin
//         if (!rst_n) begin
//             state <= IDLE;
//             lcd_e <= 0;
//             cnt   <= 0;
//         end else begin
//             case(state)
//                 IDLE: begin
//                     cnt <= 0;
//                     state <= POWER_ON;
//                 end

//                 POWER_ON: begin // 1. 上电延时 >15ms
//                     if (cnt < DELAY_20MS) cnt <= cnt + 1;
//                     else begin cnt <= 0; state <= HANDSHAKE_1; end
//                 end

//                 // --- 三次握手步骤 ---
//                 HANDSHAKE_1: begin // 2. 发送 0x30
//                     lcd_rs <= 0; lcd_db <= 8'h30;
//                     state <= WAIT; next_state <= HANDSHAKE_2;
//                     delay_target <= DELAY_4MS; // 延时 >4.1ms
//                 end

//                 HANDSHAKE_2: begin // 3. 再次发送 0x30
//                     lcd_rs <= 0; lcd_db <= 8'h30;
//                     state <= WAIT; next_state <= HANDSHAKE_3;
//                     delay_target <= DELAY_100US; // 延时 >100μs
//                 end

//                 HANDSHAKE_3: begin // 4. 第三次发送 0x30
//                     lcd_rs <= 0; lcd_db <= 8'h30;
//                     state <= WAIT; next_state <= FUNC_SET_8BIT;
//                     delay_target <= DELAY_50US;
//                 end

//                 // --- 模式设置 ---
//                 FUNC_SET_8BIT: begin // 确认 8位模式
//                     lcd_rs <= 0; lcd_db <= 8'h38;
//                     state <= WAIT; next_state <= DISP_ON;
//                     delay_target <= DELAY_50US;
//                 end

//                 DISP_ON: begin // 7. 开显示，关光标 0x0C
//                     lcd_rs <= 0; lcd_db <= 8'h0C;
//                     state <= WAIT; next_state <= ENTRY_MODE;
//                     delay_target <= DELAY_50US;
//                 end

//                 ENTRY_MODE: begin // 8. 自动增量 0x06
//                     lcd_rs <= 0; lcd_db <= 8'h06;
//                     state <= WAIT; next_state <= CLEAR;
//                     delay_target <= DELAY_50US;
//                 end

//                 CLEAR: begin // 9. 清屏 0x01
//                     lcd_rs <= 0; lcd_db <= 8'h01;
//                     state <= WAIT; next_state <= LINE1_ADDR;
//                     delay_target <= DELAY_2MS; // 关键：清屏需 >1.5ms
//                 end

//                 // --- 字符写入逻辑 (同前) ---
//                 LINE1_ADDR: begin
//                     lcd_rs <= 0; lcd_db <= 8'h80;
//                     state <= WAIT; next_state <= LINE1_STR;
//                     char_cnt <= 0; delay_target <= DELAY_50US;
//                 end

//                 LINE1_STR: begin
//                     lcd_rs <= 1;
//                     case(char_cnt)
//                         0: lcd_db <= "F"; 1: lcd_db <= "r"; 2: lcd_db <= "e";
//                         3: lcd_db <= "q"; 4: lcd_db <= ":"; 5: lcd_db <= " ";
//                         default: lcd_db <= " ";
//                     endcase
//                     if(char_cnt < 5) begin char_cnt <= char_cnt + 1; state <= WAIT; next_state <= LINE1_STR; end
//                     else begin state <= LINE2_ADDR; end
//                     delay_target <= DELAY_50US;
//                 end

//                 LINE2_ADDR: begin
//                     lcd_rs <= 0; lcd_db <= 8'hC0;
//                     state <= WAIT; next_state <= LINE2_STR;
//                     char_cnt <= 0; delay_target <= DELAY_50US;
//                 end

//                 LINE2_STR: begin
//                     lcd_rs <= 1;
//                     case(char_cnt)
//                         0: lcd_db <= d1; 1: lcd_db <= d2; 2: lcd_db <= d3;
//                         3: lcd_db <= d4; 4: lcd_db <= d5; 5: lcd_db <= "H"; 6: lcd_db <= "z";
//                         default: lcd_db <= " ";
//                     endcase
//                     if(char_cnt < 6) begin char_cnt <= char_cnt + 1; state <= WAIT; next_state <= LINE2_STR; end
//                     else begin cnt <= 0; state <= LINE1_ADDR; end // 循环刷新
//                     delay_target <= DELAY_50US;
//                 end

//                 // --- 动态延迟控制 ---
//                 WAIT: begin
//                     if (cnt < delay_target) begin
//                         cnt <= cnt + 1;
//                         // E 脉冲必须在数据稳定后产生，宽度约 20-40us
//                         if (cnt > 500 && cnt < 2500) lcd_e <= 1;
//                         else lcd_e <= 0;
//                     end else begin
//                         cnt <= 0;
//                         state <= next_state;
//                     end
//                 end
//             endcase
//         end
//     end

//     reg [23:0] delay_target;

// endmodule
