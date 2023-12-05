//****************************************Copyright (c)***********************************//
//技术支持：www.openedv.com
//淘宝店铺：http://openedv.taobao.com 
//关注微信公众平台微信号："正点原子"，免费获取FPGA & STM32资料。
//版权所有，盗版必究。
//Copyright(C) 正点原子 2018-2028
//All rights reserved                                  
//----------------------------------------------------------------------------------------
// File name:           count
// Last modified Date:  2018/3/13 8:36:43
// Last Version:        V1.0
// Descriptions:        计数模块
//----------------------------------------------------------------------------------------
// Created by:          正点原子
// Created date:        2018/3/13 8:36:37
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module count(
    //mudule clock
    input                   clk  ,      // 时钟信号
    input                   rst_n,      // 复位信号
    input                   sw,
    
    //user interface
    output   reg [19:0]     data ,      // 6个数码管要显示的数值
    output   reg [ 5:0]     point,      // 小数点的位置,高电平点亮对应数码管位上的小数点
    output   reg            en   ,      // 数码管使能信号
    output   reg            sign        // 符号位，高电平时显示负号，低电平不显示负号
);

//parameter define
parameter  MAX_NUM0 = 26'd5000_0000;  
parameter  MAX_NUM1 = 23'd5000_000;      // 计数器计数的最大值

//reg define
reg    [26:0]   cnt ;                   // 计数器，用于计时100ms
reg             flag;                   // 标志信号

//*****************************************************
//**                    main code
//*****************************************************

//计数器对系统时钟计数达10ms时，输出一个时钟周期的脉冲信号
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= 26'b0;
        flag<= 1'b0;
    end
    else if (sw == 1'b0 && cnt < MAX_NUM0 - 1'b1) begin
        cnt <= cnt + 1'b1;
        flag<= 1'b0;
    end
     else if (sw == 1'b1 && cnt < MAX_NUM1 - 1'b1) begin
           cnt <= cnt + 1'b1;
           flag<= 1'b0;
       end
    else begin
        cnt <= 26'b0;
        flag <= 1'b1;
    end
end 

//数码管需要显示的数据，从0累加到999999
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n)begin
        data  <= 20'b0;
        point <=6'b000000;
        en    <= 1'b0;
        sign  <= 1'b0;
    end 
    else begin
        point <= 6'b000000;             //不显示小数点
        en    <= 1'b1;                  //打开数码管使能信号
        sign  <= 1'b0;                  //不显示负号
        if (flag) begin                 //显示数值每隔0.01s累加一次
            if( (data%100) < 20'd000059) 
                data <= data +1'b1;     
            else
                data <= data + 20'd41;
            if( (data % 20'd10000) == 20'd5959)
                data <= data + 20'd4041;
            if( (data % 20'd1000000) == 20'd240000)
                data <= 20'b0;
                
        end 
    end 
end 

endmodule 