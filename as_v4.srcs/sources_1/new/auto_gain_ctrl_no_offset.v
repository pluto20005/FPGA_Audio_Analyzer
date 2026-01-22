`timescale 1ns / 1ps

module auto_gain_ctrl_step(
    input  wire        clk,          //输入100MHz时钟
    input  wire        rst_n,        //复位
    input  wire        drdy_out,     //XADC输出数据完成标志
    input  wire [15:0] adc_raw_data, //XADC DO_OUT [15:4]
    output reg  [15:0] scaled_data,  //增益后数据
    output reg  [1:0]  current_gain  //当前增益值0:x1, 1:x2, 2:x4, 3:x8
);

    wire [11:0] adc_data_12b = adc_raw_data[15:4];

    // 1. 峰值检测 (维持 1024 点采样周期)
    reg [11:0] sample_cnt;
    reg [11:0] max_val;
    reg [11:0] last_max;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sample_cnt <= 0;
            max_val <= 0;
            last_max <= 0;
        end else if (drdy_out) begin
            if (sample_cnt == 12'd1023) begin
                sample_cnt <= 0;
                last_max <= (adc_data_12b > max_val) ? adc_data_12b : max_val;
                max_val <= 0;
            end else begin
                sample_cnt <= sample_cnt + 1'b1;
                if (adc_data_12b > max_val) max_val <= adc_data_12b;
            end
        end
    end

    // 2. 逐级增益判定逻辑
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_gain <= 2'd0;
        end else if (drdy_out && sample_cnt == 12'd1023) begin
            if (last_max < 12'd500)
                current_gain <= 2'd3;
            if (last_max >= 12'd500 && last_max < 12'd1000)
                current_gain <= 2'd2;
            if (last_max >= 12'd1000 && last_max < 12'd2000)
                current_gain <= 2'd1;
            if (last_max >= 12'd2000)
                current_gain <= 2'd0;
        end
    end

    // 3. 数字移位
    always @(*) begin
        case(current_gain)
            2'd0: scaled_data = {4'd0, adc_data_12b};           // x1
            2'd1: scaled_data = {3'd0, adc_data_12b, 1'b0};     // x2
            2'd2: scaled_data = {2'd0, adc_data_12b, 2'b0};     // x4
            2'd3: scaled_data = {1'd0, adc_data_12b, 3'b0};     // x8
            default: scaled_data = {4'd0, adc_data_12b};
        endcase
    end

endmodule
