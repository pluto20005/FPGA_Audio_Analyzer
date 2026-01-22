`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/25 00:07:00
// Design Name: 
// Module Name: seg
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


module seg(
    input           clk,        // 系统时钟（100MHz）
    input           rst_n,      // 低电平复位
    input [31:0]    data_in,    // 8位显示数据（每4位1个BCD码）
    input [7:0]     dp_ctrl,    // 小数点控制（1点亮，0熄灭）
    output reg [7:0]seg1,       // 段选1（控制第1~4位）
    output reg [7:0]seg2,       // 段选2（控制第5~8位）
    output reg [7:0]digit       // 位选输出（低电平有效）
);

// 1. 时钟分频：100MHz → 1000Hz（扫描周期ms，每位移位1.25ms）
reg [31:0] cnt_div;  // 分频计数器（100e6/1000Hz=100000，计数到99999溢出）
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cnt_div <= 19'd0;
    else if(cnt_div == 31'd99999)
        cnt_div <= 19'd0;
    else
        cnt_div <= cnt_div + 19'd1;
end
wire clk_scan = (cnt_div == 31'd99999);  // 扫描触发时钟（100Hz）

// 2. 位选计数器：0~7循环（选择当前点亮的数码管）
reg [2:0] cnt_digit;  // 0~7对应8位数码管
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cnt_digit <= 3'd0;
    else if(clk_scan)
        cnt_digit <= cnt_digit + 3'd1;
end

// 3. 数据选择：根据当前位选，提取对应4位BCD码和小数点控制
reg [3:0] bcd_data;
reg dp_bit;
reg is_seg1_group;  // 标记当前位是否属于seg1组（第1~4位：cnt_digit[2] = 0）
always @(*) begin
    case(cnt_digit)
        3'd0: begin bcd_data = data_in[31:28];  dp_bit = dp_ctrl[7]; is_seg1_group = 1'b1; end  // 第1位（seg1组）
        3'd1: begin bcd_data = data_in[27:24];  dp_bit = dp_ctrl[6]; is_seg1_group = 1'b1; end  // 第2位（seg1组）
        3'd2: begin bcd_data = data_in[23:20]; dp_bit = dp_ctrl[5]; is_seg1_group = 1'b1; end  // 第3位（seg1组）
        3'd3: begin bcd_data = data_in[19:16];dp_bit = dp_ctrl[4]; is_seg1_group = 1'b1; end  // 第4位（seg1组）
        3'd4: begin bcd_data = data_in[15:12];dp_bit = dp_ctrl[3]; is_seg1_group = 1'b0; end  // 第5位（seg2组）
        3'd5: begin bcd_data = data_in[11:8];dp_bit = dp_ctrl[2]; is_seg1_group = 1'b0; end  // 第6位（seg2组）
        3'd6: begin bcd_data = data_in[7:4];dp_bit = dp_ctrl[1]; is_seg1_group = 1'b0; end  // 第7位（seg2组）
        3'd7: begin bcd_data = data_in[3:0];dp_bit = dp_ctrl[0]; is_seg1_group = 1'b0; end  // 第8位（seg2组）
        default: begin bcd_data = 4'd0; dp_bit = 1'b0; is_seg1_group = 1'b1; end
    endcase
end

// 4. 段码解码：BCD码→段码（共阴极，含小数点）
reg [7:0] seg_code;  // 临时段码
always @(*) begin
    case(bcd_data)
        4'd0: seg_code[6:0] = 7'b0111111;  // 0
        4'd1: seg_code[6:0] = 7'b0000110;  // 1
        4'd2: seg_code[6:0] = 7'b1011011;  // 2
        4'd3: seg_code[6:0] = 7'b1001111;  // 3
        4'd4: seg_code[6:0] = 7'b1100110;  // 4
        4'd5: seg_code[6:0] = 7'b1101101;  // 5
        4'd6: seg_code[6:0] = 7'b1111101;  // 6
        4'd7: seg_code[6:0] = 7'b0000111;  // 7
        4'd8: seg_code[6:0] = 7'b1111111;  // 8
        4'd9: seg_code[6:0] = 7'b1101111;  // 9
        4'd10: seg_code[6:0] = 7'b1110111; // A
        4'd11: seg_code[6:0] = 7'b1111100; // B
        4'd12: seg_code[6:0] = 7'b0111001; // C
        4'd13: seg_code[6:0] = 7'b1011110; // D
        4'd14: seg_code[6:0] = 7'b1111001; // E
        4'd15: seg_code[6:0] = 7'b1110001; // F
        default: seg_code[6:0] = 7'b0000000; // 全灭
    endcase
    seg_code[7] = dp_bit;  // 小数点
end

// 5. 段选输出控制：仅当前组的段选输出有效，另一组全灭（避免串扰）
always @(*) begin
    if(is_seg1_group) begin
        seg1 = seg_code;    // seg1组有效
        seg2 = 8'b00000000; // seg2组熄灭
    end else begin
        seg1 = 8'b00000000; // seg1组熄灭
        seg2 = seg_code;    // seg2组有效
    end
end

// 6. 位选输出：低电平有效，仅当前位选通
always @(*) begin
    digit = 8'b0;  // 默认全灭
    case(cnt_digit)
        3'd0: digit[0] = 1'b1;  // 第1位（seg1组）
        3'd1: digit[1] = 1'b1;  // 第2位（seg1组）
        3'd2: digit[2] = 1'b1;  // 第3位（seg1组）
        3'd3: digit[3] = 1'b1;  // 第4位（seg1组）
        3'd4: digit[4] = 1'b1;  // 第5位（seg2组）
        3'd5: digit[5] = 1'b1;  // 第6位（seg2组）
        3'd6: digit[6] = 1'b1;  // 第7位（seg2组）
        3'd7: digit[7] = 1'b1;  // 第8位（seg2组）
    endcase
end
endmodule
