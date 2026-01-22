`timescale 1ns / 1ps

module fft_maxindex_finder(
    input aclk,                             //时钟输入
    input aresetn,                          //复位
    input [4:0] curr_nfft,                  //当前FFT点数值
    input [31:0] s_axis_data_tdata,         //FFT输出数据
    input s_axis_data_tvalid,               //FFT输出数据有效标志
    input s_axis_data_tlast,                //FFT输出数据一帧结束标志
    output reg [9:0] final_max_bin,         //最大
    output reg [31:0] final_max_pow
    );

    // 1. 拆分实部和虚部
    wire signed [15:0] fft_re = s_axis_data_tdata[15:0];
    wire signed [15:0] fft_im = s_axis_data_tdata[31:16];

    // 2. 例化乘法器计算能量 (2 拍延迟)
    wire [31:0] re_sq, im_sq;
    mult_gen_0 mult_re_inst (.CLK(aclk), .A(fft_re), .B(fft_re), .P(re_sq));
    mult_gen_0 mult_im_inst (.CLK(aclk), .A(fft_im), .B(fft_im), .P(im_sq));

    // 3. 计算能量和 (1 拍延迟)
    reg [31:0] power_sum;
    always @(posedge aclk) begin
        power_sum <= re_sq + im_sq;
    end

    // 4. 时序对齐 (总延迟 3 拍)
    // 必须把 curr_nfft 也进行延迟，防止在比较时点数切换导致上限错误
    reg [2:0] vld_delay, lst_delay;
    reg [4:0] nfft_delay [2:0]; 
    
    always @(posedge aclk) begin
        vld_delay <= {vld_delay[1:0], s_axis_data_tvalid};
        lst_delay <= {lst_delay[1:0], s_axis_data_tlast};
        nfft_delay[0] <= curr_nfft;
        nfft_delay[1] <= nfft_delay[0];
        nfft_delay[2] <= nfft_delay[1];
    end
    
    wire [4:0] aligned_nfft = nfft_delay[2];
    wire aligned_vld = vld_delay[2];
    wire aligned_lst = lst_delay[2];

    // 5. 动态计算搜索上限 (N/2)
    // 利用移位快速计算：10->512, 9->256, 8->128, 7->64
    wire [9:0] search_limit = (1 << (aligned_nfft - 1));

    // 6. 寻找最大值逻辑
    reg [31:0] temp_max_pow;
    reg [9:0]  temp_max_bin;
    reg [9:0]  bin_cnt;

    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            temp_max_pow <= 0;
            temp_max_bin <= 0;
            bin_cnt      <= 0;
            final_max_bin <= 0;
            final_max_pow <= 0;
        end else if (aligned_vld) begin
            // 每一帧开始重置比较器
            if (bin_cnt == 0) begin
                temp_max_pow <= 0;
                temp_max_bin <= 0;
            end 
            
            // 搜索逻辑：跳过直流并搜索到 N/2
            if (bin_cnt > 1 && bin_cnt < search_limit) begin
                if (power_sum > temp_max_pow) begin
                    temp_max_pow <= power_sum;
                    temp_max_bin <= bin_cnt;
                end
            end

            // 帧结束输出
            if (aligned_lst) begin
                final_max_bin <= temp_max_bin;
                final_max_pow <= temp_max_pow;
                bin_cnt <= 0;
            end else begin
                bin_cnt <= bin_cnt + 1;
            end
        end
    end

endmodule

