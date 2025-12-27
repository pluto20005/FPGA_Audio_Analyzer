`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/24 17:41:45
// Design Name: 
// Module Name: as_v4
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


module as_v4(
    input clk,
    input rstn,
    input vauxp2,
    input vauxn2,
    input S0,
    input S1,
    input S2,
    input S3,
    output temp,
    output [7:0] seg1,
    output [7:0] seg2,
    output [7:0] digit,
    output [7:0] lcd_db,
    output lcd_rs,
    output lcd_rw,
    output lcd_e
    );

    wire clk_100mhz;
    wire clk_150mhz;
    wire clk_50mhz;
    wire locked;
    wire sys_rst_n;

    assign sys_rst_n=rstn&&locked;
    assign temp=locked;

  clk_wiz_0 clk_module
   (
    // Clock out ports
    .clk_100mhz(clk_100mhz),     // output clk_100mhz
    .clk_150mhz(clk_150mhz),     // output clk_150mhz
    .clk_50mhz(clk_50mhz),     // output clk_50mhz
    // Status and control signals
    .resetn(rstn), // input resetn
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk)      // input clk_in1
);

    wire drdy_out;
    wire eoc_out;
    wire [15 : 0] do_out;
    wire eos_out;


xadc_wiz_0 xadc_module (
  .di_in(16'd0),              // input wire [15 : 0] di_in
  .daddr_in(7'h12),        // input wire [6 : 0] daddr_in
  .den_in(eoc_out),            // input wire den_in
  .dwe_in(1'b0),            // input wire dwe_in
  .drdy_out(drdy_out),        // output wire drdy_out
  .do_out(do_out),            // output wire [15 : 0] do_out
  .dclk_in(clk_100mhz),          // input wire dclk_in
  .reset_in(!sys_rst_n),        // input wire reset_in
  .vp_in(),              // input wire vp_in
  .vn_in(),              // input wire vn_in
  .vauxp2(vauxp2),            // input wire vauxp2
  .vauxn2(vauxn2),            // input wire vauxn2
  .channel_out(),  // output wire [4 : 0] channel_out
  .eoc_out(eoc_out),          // output wire eoc_out
  .alarm_out(),      // output wire alarm_out
  .eos_out(eos_out),          // output wire eos_out
  .busy_out()        // output wire busy_out
);

    wire s_axis_data_tready;
    wire [31 : 0] s_axis_data_tdata;

    wire [31:0] fifo_din;
    assign fifo_din = {16'd0,{4{do_out[15]}},do_out[15:4]};
    // assign fifo_din = {20'd0,do_out[15:4]};

    wire fifo_empty;
    wire fft_rd_en;
    wire [11 : 0] rd_cnt;
    assign fft_rd_en = (rd_cnt >= 1024) && s_axis_data_tready;


fifo_generator_0 fifo_module (
  .rst(!sys_rst_n),                      // input wire rst
  .wr_clk(clk_100mhz),                // input wire wr_clk
  .rd_clk(clk_150mhz),                // input wire rd_clk
  .din(fifo_din),                      // input wire [31 : 0] din
  .wr_en(drdy_out),                  // input wire wr_en
  .rd_en(fft_rd_en),                  // input wire rd_en
  .dout(s_axis_data_tdata),                    // output wire [31 : 0] dout
  .full(),                    // output wire full
  .empty(fifo_empty),                  // output wire empty
  .rd_data_count(rd_cnt),  // output wire [11 : 0] rd_data_count
  .wr_rst_busy(),      // output wire wr_rst_busy
  .rd_rst_busy()      // output wire rd_rst_busy
);

    //fft配置信息
    wire [23 : 0] s_axis_config_tdata;
    wire s_axis_config_tvalid;
    wire s_axis_config_tready;
    // assign s_axis_config_tdata = 16'b0000_0101010101_1; // Scaled + Forward
    // assign s_axis_config_tvalid = 1'b1;

    wire [4:0]  curr_nfft;


//fft配置更改模块，根据按下开关不同进行更改配置
fft_config_manager fft_config_manager_module(
    .clk(clk_150mhz),
    .rst_n(sys_rst_n),
    .btn_switch_s0(S0),
    .btn_switch_s1(S1),
    .btn_switch_s2(S2),
    .btn_switch_s3(S3),
    .curr_nfft(curr_nfft),
    .config_tdata(s_axis_config_tdata),
    .config_tvalid(s_axis_config_tvalid),
    .config_tready(s_axis_config_tready)
);

    //fft端口引出

    wire s_axis_data_tvalid;
    assign s_axis_data_tvalid = fft_rd_en;
    wire s_axis_data_tlast;

    wire [31 : 0] m_axis_data_tdata;
    wire [15 : 0] m_axis_data_tuser;
    wire m_axis_data_tvalid;
    wire m_axis_data_tready;
    wire m_axis_data_tlast;

    //fft_s_tlast信号生成
    fft_tlast_gen fft_tlast_gen_module (
        .clk(clk_150mhz),
        .rstn(sys_rst_n),
        .curr_nfft(curr_nfft),
        .fft_s_axis_tvalid(s_axis_data_tvalid),
        .fft_s_axis_ready(s_axis_data_tready),
        .s_axis_data_tlast(s_axis_data_tlast)
    );



xfft_0 fft_module (
  .aclk(clk_150mhz),                                             // input wire aclk
  .aresetn(sys_rst_n),                                          // input wire aresetn

  .s_axis_config_tdata(s_axis_config_tdata),                  // input wire [23 : 0] s_axis_config_tdata
  .s_axis_config_tvalid(s_axis_config_tvalid),                // input wire s_axis_config_tvalid
  .s_axis_config_tready(s_axis_config_tready),                // output wire s_axis_config_tready

  .s_axis_data_tdata(s_axis_data_tdata),                      // input wire [31 : 0] s_axis_data_tdata
  .s_axis_data_tvalid(s_axis_data_tvalid),                    // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready),                    // output wire s_axis_data_tready
  .s_axis_data_tlast(s_axis_data_tlast),                      // input wire s_axis_data_tlast

  .m_axis_data_tdata(m_axis_data_tdata),                      // output wire [31 : 0] m_axis_data_tdata
  .m_axis_data_tuser(m_axis_data_tuser),                      // output wire [15 : 0] m_axis_data_tuser
  .m_axis_data_tvalid(m_axis_data_tvalid),                    // output wire m_axis_data_tvalid
  .m_axis_data_tready(1'b1),                    // input wire m_axis_data_tready
  .m_axis_data_tlast(m_axis_data_tlast),                      // output wire m_axis_data_tlast

  .event_frame_started(),                  // output wire event_frame_started
  .event_tlast_unexpected(),            // output wire event_tlast_unexpected
  .event_tlast_missing(),                  // output wire event_tlast_missing
  .event_status_channel_halt(),      // output wire event_status_channel_halt
  .event_data_in_channel_halt(),    // output wire event_data_in_channel_halt
  .event_data_out_channel_halt()  // output wire event_data_out_channel_halt
);

    wire [9:0] max_index;



fft_maxindex_finder fft_maxindex_finder_module(
    .aclk(clk_150mhz),
    .aresetn(sys_rst_n),
    .curr_nfft(curr_nfft),
    .s_axis_data_tdata(m_axis_data_tdata),
    .s_axis_data_tvalid(m_axis_data_tvalid),
    .s_axis_data_tlast(m_axis_data_tlast),
    .final_max_bin(max_index),
    .final_max_pow()
);

//     wire [9:0] f_single=46;
//     wire [19:0] f;

// mult_gen_1 mult_f_module (
//   .CLK(clk_150mhz),  // input wire CLK
//   .A(f_single),      // input wire [9 : 0] A
//   .B(max_index),      // input wire [9 : 0] B
//   .P(f)      // output wire [19 : 0] P
// );

//------------计算f逻辑--------------------------------------------------------------

    wire [15:0] f;


final_f_gen final_f_gen_module(
    .clk(clk_150mhz),
    .max_index(max_index),
    .curr_nfft(curr_nfft),
    .final_freq_hz(f)
);
//------------计算f逻辑---------------------------------------------------------------



    wire [31:0] f_final;
    assign f_final = {16'd0,f};

    wire [31:0] data_in;

data_in_gen data_in_gen_module(
    .clk(clk_150mhz),
    .reset(sys_rst_n),
    .f(f_final),
    .data_in(data_in)
);

    wire [7:0] dp_ctrl;

seg seg_module(
    .clk(clk_150mhz),
    .rst_n(sys_rst_n),
    .data_in(data_in),
    .dp_ctrl(dp_ctrl),
    .seg1(seg1),
    .seg2(seg2),
    .digit(digit)
);

    // //LCD1602驱动模块

    // // 放在你的 Top 模块中
    // // wire [19:0] freq_hz = (max_index * 48000) / 1024; // 假设 Fs=48kHz, N=1024
    // // wire [19:0] freq_hz = 0; // 假设 Fs=48kHz, N=1024
    // // 简单的提取十进制位 (为了节省资源，实际可用 Binary to BCD 模块)
    // wire [7:0] char_10000 = 8'h30 + (f / 10000 % 10);
    // wire [7:0] char_01000 = 8'h30 + (f / 1000 % 10);
    // wire [7:0] char_00100 = 8'h30 + (f / 100 % 10);
    // wire [7:0] char_00010 = 8'h30 + (f / 10 % 10);
    // wire [7:0] char_00001 = 8'h30 + (f % 10);

    reg [15:0] f_sync_1, f_sync_2;
    always @(posedge clk_50mhz) begin
        f_sync_1 <= f;        // 第一拍采样
        f_sync_2 <= f_sync_1; // 第二拍稳定信号
    end

    wire [3:0] bcd4, bcd3, bcd2, bcd1, bcd0;

    wire [23:0] note_name;

freq_to_note_full_48k freq_to_note_full_48k_module(
    .freq(f),
    .note_name(note_name)
);



bin_to_bcd bin_to_bcd_module(
    .clk(clk_50mhz),
    .rst_n(sys_rst_n),
    .bin_val(f_sync_2),
    .bcd4(bcd4), .bcd3(bcd3), .bcd2(bcd2), .bcd1(bcd1), .bcd0(bcd0)
);


    reg [7:0] d1, d2, d3, d4, d5;
    always @(posedge clk_50mhz) begin
        d1 <= 8'h30 + bcd4;
        d2 <= 8'h30 + bcd3;
        d3 <= 8'h30 + bcd2;
        d4 <= 8'h30 + bcd1;
        d5 <= 8'h30 + bcd0;
    end

    reg [31:0] nfft_chars; // 存储4个字符，每个8位

    always @(*) begin
        case(curr_nfft)
            5'd10:   nfft_chars = "1024";
            5'd9:    nfft_chars = " 512"; 
            5'd8:    nfft_chars = " 256";
            5'd7:    nfft_chars = " 128";
            default: nfft_chars = "1024";
        endcase
    end



    wire [7:0] lcd_db;
    wire lcd_rs;
    wire lcd_rw;
    wire lcd_e;

lcd1602_driver lcd1602_driver_module(
    .clk(clk_50mhz),
    .rst_n(sys_rst_n),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .d4(d4),
    .d5(d5),
    .nfft_chars(nfft_chars),
    .note_name(note_name),
    .lcd_rs(lcd_rs),
    .lcd_rw(lcd_rw),
    .lcd_e(lcd_e),
    .lcd_db(lcd_db)
);



endmodule
