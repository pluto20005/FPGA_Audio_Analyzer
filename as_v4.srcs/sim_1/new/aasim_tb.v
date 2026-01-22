`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/30 21:58:38
// Design Name: 
// Module Name: aasim_tb
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


module aasim_tb();


    // 1. 信号定义
    reg clk;
    reg rstn;
    reg s0,s1,s2,s3;
    reg [15:0] xadc_data;
    reg data_tvalid;  // 新增：数据有效信号
    wire temp;
    wire [7:0] seg1;
    wire [7:0] seg2;
    wire [7:0] digit;
    wire [7:0] lcd_db;
    wire lcd_rs;
    wire lcd_rw;
    wire lcd_e;


    // 2. 测试数据存储（1024点）
    reg [15:0] data_in[0:1023];
    integer i;

    // 3. 时钟生成（100MHz，周期10ns）
    always #5 clk = ~clk;

    // 4. 测试数据读取与驱动（同步时序）
    initial begin
        // 读取测试数据文件（二进制）
        $readmemb("D:/vivado_project/as_v3/as_v3.srcs/sources_1/new/fft_test_signal.txt", data_in);
        i = 0;
        xadc_data = 16'd0;
        data_tvalid = 1'b0;
        
        // 等待复位释放后，开始驱动数据
        @(posedge rstn);
        forever begin
            @(posedge clk) begin
                    data_tvalid <= 1'b1;
                    xadc_data <= data_in[i];
                    // 帧计数：1024点为一帧
                    if (i == 1023) begin
                        i <= 0;
                    end else begin
                        i <= i + 1;;
                    end
                end 
            end
        end

    // 5. 复位信号生成（规范脉宽：100ns=10个时钟周期）
    initial begin
        clk = 1'b0;
        rstn = 1'b0;
        #100;  // 100ns低电平，满足IP核复位要求
        rstn = 1'b1;#2000;
        // 仿真时长：处理3帧数据后结束（3*1024*10ns=30720ns）
        s0=1;s1=0;s2=0;s3=0; #1000;
        s0=0;s1=0;s2=0;s3=0;#30700;
        // s1=1;s0=0;s2=0;s3=0; #100;
        // s0=0;s1=0;s2=0;s3=0;#30700;
        // s2=1;s0=0;s1=0;s3=0;#100;
        // s0=0;s1=0;s2=0;s3=0;#30700;
        // s3=1;s0=0;s1=0;s2=0; #100;
        // s0=0;s1=0;s2=0;s3=0;#30700;
        // $display("FFT仿真完成，最后一个幅度值：%h", data);
        $finish;
    end

assim assim_tb(
    .clk(clk),
    .rstn(rstn),
    .S0(s0),
    .S1(s1),
    .S2(s2),
    .S3(s3),
    .data_tvalid(data_tvalid),
    .xadc_data(xadc_data),
    .temp(temp),
    .seg1(seg1),
    .seg2(seg2),
    .digit(digit),
    .lcd_db(lcd_db),
    .lcd_rs(lcd_rs),
    .lcd_rw(lcd_rw),
    .lcd_e(lcd_e)
);



endmodule
