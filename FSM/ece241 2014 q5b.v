module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    localparam S0 = 1'b0;
    localparam S1 = 1'b1;
    
    reg state,state_n;
    
    always @(*) begin
        case(state)
            S0: state_n = x? S1 : S0;
            S1: state_n = S1;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state <= S0;
        end
        else begin
            state <= state_n;
        end  
    end
    
    assign z = ((state == S1 & ~x) | (state == S0 & x));
   
endmodule
