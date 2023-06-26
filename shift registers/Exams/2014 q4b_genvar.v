module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
);
    wire [3:0] LED;
    assign LED[2:0] = LEDR[3:1];
    assign LED[3] = KEY[3];
    
    genvar i;
    
    generate
        for(i=0; i<4; i=i+1) begin : generate_block_identifier
            MUXDFF inst0 (.clk(KEY[0]),.w(LED[i]), .R(SW[i]),.E(KEY[1]),.L(KEY[2]),.Q(LEDR[i]));
        end
    endgenerate
	/*
	MUXDFF inst3 (.clk(KEY[0]),.w(KEY[3]), .R(SW[3]),.E(KEY[1]),.L(KEY[2]),.Q(LEDR[3]));
    MUXDFF inst2 (.clk(KEY[0]),.w(LEDR[3]),.R(SW[2]),.E(KEY[1]),.L(KEY[2]),.Q(LEDR[2]));
    MUXDFF inst1 (.clk(KEY[0]),.w(LEDR[2]),.R(SW[1]),.E(KEY[1]),.L(KEY[2]),.Q(LEDR[1]));
    MUXDFF inst0 (.clk(KEY[0]),.w(LEDR[1]),.R(SW[0]),.E(KEY[1]),.L(KEY[2]),.Q(LEDR[0]));
    */
    
endmodule

module MUXDFF (
	input clk,
    input w, R, E, L,
    output Q
);
    wire d1, d2;
    assign d1 = E ? w : Q;
    assign d2 = L ? R : d1;
    always @(posedge clk) begin
        Q <= d2;
    end

endmodule
