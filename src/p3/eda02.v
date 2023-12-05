`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/16 11:21:06
// Design Name: 
// Module Name: eda02
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

module DataCompare4(
    input [3:0] iData_a,
    input [3:0] iData_b,
    input [2:0] iData,
    output reg [2:0] oData
);

always@(*)
begin
    if( iData == 3'b100) oData = 3'b100;
    else if ( iData == 3'b010 ) oData = 3'b010;
    else
    begin
    if( iData_a[3] > iData_b[3]) oData = 3'b100;
    else if( iData_a[3] < iData_b[3] ) oData = 3'b010;
    else 
    begin
        if(iData_a[2] > iData_b[2]) oData = 3'b100;
        else if(iData_a[2] < iData_b[2]) oData = 3'b010;
        else
        begin
        if(iData_a[1] > iData_b[1]) oData = 3'b100;
            else if( iData_a[1] < iData_b[1] ) oData = 3'b010;
        else
        begin
            if( iData_a[0] > iData_b[0]) oData = 3'b100;
                else if( iData_a[0] > iData_b[0] ) oData = 3'b010;
            else oData = 3'b001;
        end
        end
     end
     end
end
endmodule

module DataCompare8(
    input [7:0] iData_a,
    input [7:0] iData_b,
    output reg [2:0] oData
);
    wire [2:0] a,b;
    assign a = 3'b001;
    DataCompare4 V1( iData_a [7:4] ,iData_b [7:4] ,a ,b) ;
    DataCompare4 V2( iData_a [3:0] ,iData_b [3:0] ,b ,oData) ;

endmodule
    
