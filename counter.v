`timescale 1ns / 1ps
module slow( 
input CLK, 
input [1:0] pace, 
output CLK0 
    ); 
    reg [24:0] num; 
    reg CLK1; 
    assign CLK0 = CLK1; 
    always @* 
    begin 
    case (pace) 
        2'b00: CLK1 = num[24]; 
        2'b01: CLK1 = num[23]; 
        2'b10: CLK1 = num[22]; 
        2'b11: CLK1 = num[21]; 
    endcase 
    end 
    always @(posedge CLK) 
    begin 
        num = num + 1; 
end 
endmodule

module JK(
    input wire J, K, CLK0, reset,
    output reg Q, Qn
);

always @(posedge CLK0 or posedge reset) begin
    if (reset) begin
        Q <= 0;
        Qn <= 1;
    end else begin
        case ({J, K})
            2'b00: ; // No change
            2'b01: begin Q <= 0; Qn <= 1; end // Reset
            2'b10: begin Q <= 1; Qn <= 0; end // Set
            2'b11: begin Q <= ~Q; Qn <= ~Qn; end // Toggle
        endcase
    end
end

endmodule

module display7(
input [3:0] iData,
output [6:0] oData
);

  reg [6:0] tData;
  assign oData=tData;
 
  always @(*)
      begin 
	  case(iData)
		 4'b0000: tData=7'b1000000;
                   
                 4'b0001: tData=7'b1111001;
               
                 4'b0010: tData=7'b0100100;
                   
                 4'b0011: tData=7'b0110000;
                   
                 4'b0100: tData=7'b0011001;
                   
                 4'b0101: tData=7'b0010010;
                   
                 4'b0110: tData=7'b0000010;
                   
                 4'b0111: tData=7'b1111000;
                   
                 4'b1000: tData=7'b0000000;
                   
                 4'b1001: tData=7'b0010000;
                   

				
                default: tData=7'b1111111;
	  endcase
      end

endmodule


module Mod8Counter(
    input wire clk,
    input wire reset,
    input wire [1:0]Pace,
    output wire [2:0] oQ,
    output wire [6:0] oDisplay
);

// Internal signals
wire Q0, Qn0, Q1, Qn1, Q2, Qn2;
wire [3:0] counterValue;

slow div(.CLK(clk),.pace(Pace),.CLK0(clk0));

JK jk0 (  
    .J(1'b1),       // J����Ϊ1���Ա���ʱ��������ʱQ0�л�  
    .K(1'b1),       // K����Ϊ1��ͬ��  
    .CLK0(clk0),  
    .reset(reset),  // ��resetΪ��ʱ����JK����������Ϊ0  
    .Q(Q0),  
    .Qn(Qn0)  
);  
  
JK jk1 (  
    .J(Q0),         // J��ǰһ��������Q0�����  
    .K(Q0),         // KҲ��ǰһ��������Q0�����  
    .CLK0(clk0),  
    .reset(reset),  
    .Q(Q1),  
    .Qn(Qn1)  
);  
  
// ʵ����������JK�������������Чλ��  
JK jk2 (  
    .J(Q1 & Q0),  // ��Q1Ϊ0��Q0Ϊ1ʱ����2��3������Q1Ϊ1��Q0��1��Ϊ0ʱ����3��4����JΪ1  
    .K(Q1 & Q0),       // ��K����Ϊ0����Ϊ��JΪ1ʱ������ֻ����ʱ��������ʱ�л�Q2  
    .CLK0(clk0),  
    .reset(reset),  
    .Q(Q2),  
    .Qn(Qn2)  
);  
  
assign oQ = {Q2, Q1, Q0}; // ��Q2, Q1, Q0��ϳ�һ��3λ���

assign counterValue = {1'b0, oQ};

display7 display (
    .iData(counterValue),
    .oData(oDisplay)
);

endmodule


