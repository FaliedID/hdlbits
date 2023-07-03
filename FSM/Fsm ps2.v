module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
    
    reg [1:0] state, state_n;
    
    // State parameter
    localparam S0 = 2'b00; // IDLE
    localparam S1 = 2'b01; // begin
    localparam S2 = 2'b10; // trans
    localparam S3 = 2'b11; // done
    
    // State transition logic (combinational)
    always @ (*) begin
        case (state)
            S0: state_n = (in[3]) ? S1 : S0;
            S1: state_n = S2;
            S2: state_n = S3;
            S3: state_n = (in[3]) ? S1 : S0;
        endcase
    end
    // State flip-flops (sequential)
    always @ (posedge clk) begin
        if(reset) begin
            state <= S0;
        end
        else begin
            state <= state_n;
        end
    end
 
    // Output logic
    assign done = (state == S3);

endmodule
