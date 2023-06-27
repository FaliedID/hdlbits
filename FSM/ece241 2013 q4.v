module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
);
    reg [2:0] state, state_n;
    // state param
    localparam S0 = 3'b000;
    localparam S1A = 3'b001;
    localparam S1B = 3'b101;
    localparam S2A = 3'b010;
    localparam S2B = 3'b110;
    localparam S3 = 3'b011;
    // transition logic
    always @(*) begin
        case (state)
            S0: state_n = (s[1])? S1A:S0;
            S1A: state_n = (s[2])? S2A:(s[1]?S1A:S0);
            S1B: state_n = (s[2])? S2A:(s[1]?S1B:S0);
            S2A: state_n = (s[3])? S3:(s[2]?S2A:S1B);
            S2B: state_n = (s[3])? S3:(s[2]?S2B:S1B);
            S3: state_n = (s[3])? S3:S2B;
            default state_n = S0;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= state_n;
        end
    end
    
    // output assign
    assign fr3 = (state == S0) ? 1'b1 : 1'b0;
    assign fr2 = (state == S1A | state == S1B | state == S0) ? 1'b1 : 1'b0;
    assign fr1 = (state == S3) ? 1'b0 : 1'b1;
    assign dfr = (state == S0 | state == S1B | state == S2B) ? 1'b1 : 1'b0;
    
endmodule
