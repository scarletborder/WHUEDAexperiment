//****************************************Copyright (c)***********************************//
//����֧�֣�www.openedv.com
//�Ա����̣�http://openedv.taobao.com 
//��ע΢�Ź���ƽ̨΢�źţ�"����ԭ��"����ѻ�ȡFPGA & STM32���ϡ�
//��Ȩ���У�����ؾ���
//Copyright(C) ����ԭ�� 2018-2028
//All rights reserved                                  
//----------------------------------------------------------------------------------------
// File name:           count
// Last modified Date:  2018/3/13 8:36:43
// Last Version:        V1.0
// Descriptions:        ����ģ��
//----------------------------------------------------------------------------------------
// Created by:          ����ԭ��
// Created date:        2018/3/13 8:36:37
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module count(
    //mudule clock
    input                   clk  ,      // ʱ���ź�
    input                   rst_n,      // ��λ�ź�
    input                   sw,
    //user interface
    output   reg [19:0]     data ,      // 6�������Ҫ��ʾ����ֵ
    output   reg [ 5:0]     point,      // С�����λ��,�ߵ�ƽ������Ӧ�����λ�ϵ�С����
    output   reg            en   ,      // �����ʹ���ź�
    output   reg            sign        // ����λ���ߵ�ƽʱ��ʾ���ţ��͵�ƽ����ʾ����
);

//parameter define
parameter  MAX_NUM = 23'd5000_000;      // ���������������ֵ
parameter  MAX_NUM2 = 26'd50000_000;      // ���������������ֵ
//reg define
reg    [26:0]   cnt ;                   // �����������ڼ�ʱ100ms
reg             flag;                   // ��־�ź�

//*****************************************************
//**                    main code
//*****************************************************

//��������ϵͳʱ�Ӽ�����10msʱ�����һ��ʱ�����ڵ������ź�
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= 23'b0;
        flag<= 1'b0;
    end
    else if (sw == 1'b0 && cnt < MAX_NUM - 1'b1) begin
        cnt <= cnt + 1'b1;
        flag<= 1'b0;
    end
    else if (sw == 1'b1 && cnt < MAX_NUM2 - 1'b1) begin
            cnt <= cnt + 1'b1;
            flag<= 1'b0;
        end
    else begin
        cnt <= 23'b0;
        flag <= 1'b1;
    end
end 

//�������Ҫ��ʾ�����ݣ���0�ۼӵ�999999
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n)begin
        data  <= 20'b0;
        point <=6'b000000;
        en    <= 1'b0;
        sign  <= 1'b0;
    end 
    else begin
        point <= 6'b000000;             //����ʾС����
        en    <= 1'b1;                  //�������ʹ���ź�
        sign  <= 1'b0;                  //����ʾ����
        if (flag) begin                 //��ʾ��ֵÿ��0.01s�ۼ�һ��
            if(data < 20'd000007) 
                data <= data +1'b1;     
            else
                data <= 20'b0;
        end 
    end 
end 

endmodule 