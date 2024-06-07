`timescale 1ns / 1ps

module FA(
    input iA,
    input iB,
    input iC,
    output oS,
    output oC
);
    assign oS = iA ^ iB ^ iC;
    assign oC = (iA & iB) | ((iA ^ iB) & iC); // 进位输出逻辑
endmodule

module Adder(
    input [7:0] iData_a,
    input [7:0] iData_b,
    input iC,
    output [7:0] oData,
    output oData_c
);
    wire [6:0] idc; // 中间进位信号
    
    FA d1(.iA(iData_a[0]), .iB(iData_b[0]), .iC(iC), .oS(oData[0]), .oC(idc[0]));
    FA d2(.iA(iData_a[1]), .iB(iData_b[1]), .iC(idc[0]), .oS(oData[1]), .oC(idc[1]));
    FA d3(.iA(iData_a[2]), .iB(iData_b[2]), .iC(idc[1]), .oS(oData[2]), .oC(idc[2]));
    FA d4(.iA(iData_a[3]), .iB(iData_b[3]), .iC(idc[2]), .oS(oData[3]), .oC(idc[3]));
    FA d5(.iA(iData_a[4]), .iB(iData_b[4]), .iC(idc[3]), .oS(oData[4]), .oC(idc[4]));
    FA d6(.iA(iData_a[5]), .iB(iData_b[5]), .iC(idc[4]), .oS(oData[5]), .oC(idc[5]));
    FA d7(.iA(iData_a[6]), .iB(iData_b[6]), .iC(idc[5]), .oS(oData[6]), .oC(idc[6]));
    FA d8(.iA(iData_a[7]), .iB(iData_b[7]), .iC(idc[6]), .oS(oData[7]), .oC(oData_c));
endmodule



