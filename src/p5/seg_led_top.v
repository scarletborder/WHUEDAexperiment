//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 2020/04/01 10:12:07
//// Design Name: 
//// Module Name: seg_led_top
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module seg_led_top(


//    );
//endmodule
//****************************************Copyright (c)***********************************//
//����֧�֣�www.openedv.com
//�Ա����̣�http://openedv.taobao.com
//��ע΢�Ź���ƽ̨΢�źţ�"����ԭ��"����ѻ�ȡFPGA & STM32���ϡ�
//��Ȩ���У�����ؾ���
//Copyright(C) ����ԭ�� 2018-2028
//All rights reserved
//----------------------------------------------------------------------------------------
// File name:           top_seg_led
// Last modified Date:  2018��5��16��17:30:50
// Last Version:        V1.0
// Descriptions:        ����ܶ�̬��ʾʵ�鶥��ģ��
//----------------------------------------------------------------------------------------
// Created by:          ����ԭ��
// Created date:        2018��5��16��17:30:56
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module seg_led_top(
    //global clock
    input            sys_clk  ,       // ȫ��ʱ���ź�
    input            sys_rst_n,       // ��λ�źţ�����Ч��
    input            sw,

    //seg_led interface
    output    [5:0]  seg_sel  ,       // �����λѡ�ź�
    output    [7:0]  seg_led          // ����ܶ�ѡ�ź�
);

//wire define
wire    [19:0]  data;                 // �������ʾ����ֵ
wire    [ 5:0]  point;                // �����С�����λ��
wire            en;                   // �������ʾʹ���ź�
wire            sign;                 // �������ʾ���ݵķ���λ
wire  neg_rst_n;

//*****************************************************
//**                    main code
//*****************************************************

//������ģ�飬�����������Ҫ��ʾ������
count u_count(
    .clk           (sys_clk  ),       // ʱ���ź�
    .sw            (sw ),
//    .rst_n         (sys_rst_n),       // ��λ�ź�
    .rst_n         (neg_rst_n),       // ��λ�ź�

    .data          (data     ),       // 6λ�����Ҫ��ʾ����ֵ
    .point         (point    ),       // С���������ʾ��λ��,�ߵ�ƽ��Ч
    .en            (en       ),       // �����ʹ���ź�
    .sign          (sign     )        // ����λ
);

//����ܶ�̬��ʾģ��
seg_led u_seg_led(
    .clk           (sys_clk  ),       // ʱ���ź�
//    .rst_n         (sys_rst_n),       // ��λ�ź�
    
      .rst_n         (neg_rst_n),       // ��λ�ź�
  

    .data          (data     ),       // ��ʾ����ֵ
    .point         (point    ),       // С���������ʾ��λ��,�ߵ�ƽ��Ч
    .en            (en       ),       // �����ʹ���ź�
    .sign          (sign     ),       // ����λ���ߵ�ƽ��ʾ����(-)
    
    .seg_sel       (seg_sel  ),       // λѡ
    .seg_led       (seg_led  )        // ��ѡ
);

assign  neg_rst_n = ~sys_rst_n;


endmodule