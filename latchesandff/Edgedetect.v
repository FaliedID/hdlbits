module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0] in_dly;
    reg [7:0] in_dly_2;
    
    always @(posedge clk) begin
        in_dly = in;
    end
    
    always @(posedge clk) begin
        in_dly_2 = in_dly;
    end
    
    assign pedge = in_dly & ~in_dly_2;

endmodule
