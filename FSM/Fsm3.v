module top_module(
    input clk,
    input in,
    input areset,
    output out); //
    
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;
    
    reg [1:0] state, state_n;
    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (in) begin
                   state_n = B;
                end else begin
                   state_n = A;
                end
            end
            B: begin
                if (in) begin
                   state_n = B;
                end else begin
                   state_n = C;
                end
            end
            C: begin
                if (in) begin
                   state_n = D;
                end else begin
                   state_n = A;
                end
            end
            D: begin
                if (in) begin
                   state_n = B;
                end else begin
                   state_n = C;
                end
            end
        endcase
    end
                

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if(areset) begin
        	state <= A;
        end else begin
            state <= state_n;
        end
    end

    // Output logic
    assign out = (state[1] & state[0]) ? 1'b1 : 1'b0;

endmodule
