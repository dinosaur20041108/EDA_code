`timescale 1ns / 1ps

module Datacompare4(
    input [3:0]  iData_a,
    input [3:0]  iData_b,
    input [2:0] iData,
    output reg [2:0] oData
);
    always @* begin
        if ( iData_a >  iData_b) begin
            oData = 3'b001;
        end else if ( iData_a <  iData_b) begin
            oData = 3'b100;
        end else begin
            case (iData)
                3'b100: oData = 3'b100;
                3'b001: oData = 3'b001;
                3'b010: oData = 3'b010;
                default: oData = 3'b000;
            endcase
        end
    end
endmodule


module Datacompare8(
    input [7:0]  iData_a,
    input [7:0]  iData_b,
    output [2:0] oData
);
    wire [2:0] mid;
    wire [2:0] low = 3'b010;

    Datacompare4 comp_low4(
        . iData_a( iData_a[3:0]),
        . iData_b( iData_b[3:0]),
        .iData(low),
        .oData(mid)
    );

    Datacompare4 comp_high4(
        . iData_a( iData_a[7:4]),
        . iData_b( iData_b[7:4]),
        .iData(mid),
        .oData(oData)
    );
endmodule
