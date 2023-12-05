`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/16 11:29:37
// Design Name: 
// Module Name: eda03
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

module FA(Sum,Co,A,B,Ci);
	input A,B,Ci;
	output Sum,Co;
	wire 	S1,S2,S3;
		xor (Sum,A,B,Ci);//构建sum
		and (S1,A,B);
		xor (S2,A,B);
		and	(S3,Ci,S2);
		or  (Co,S1,S3);//构建co
endmodule

module Adder(Sum,Co,A,B,Ci);
	input [7:0] A,B;
	input Ci;
	output [7:0]Sum,Co;
		FA	UO(Sum[0],Co[0],A[0],B[0],Ci);
		FA	U1(Sum[1],Co[1],A[1],B[1],Co[0]);
		FA 	U2(Sum[2],Co[2],A[2],B[2],Co[1]);
		FA	U3(Sum[3],Co[3],A[3],B[3],Co[2]);
		FA	U4(Sum[4],Co[4],A[4],B[4],Co[3]);
		FA	U5(Sum[5],Co[5],A[5],B[5],Co[4]);
		FA	U6(Sum[6],Co[6],A[6],B[6],Co[5]);
		FA	U7(Sum[7],Co[7],A[7],B[7],Co[6]);
endmodule

