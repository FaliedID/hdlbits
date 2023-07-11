module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    // detect 101 by mealy machine
    
    localparam S0 = 2'b00;	// IDLE
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    
    reg [1:0] state, state_n;
    
    always @ (*) begin
        case(state)
            S0: state_n = x ? S1 : S0;
            S1: state_n = x ? S1 : S2;
            S2: state_n = x ? S1 : S0;
        endcase
    end
    
    always @ (posedge clk or negedge aresetn) begin
        if(~aresetn) begin
            state <= S0;
        end else begin
            state <= state_n;
        end
    end
    
    assign z = (state == S2 & state_n == S1);

endmodule
