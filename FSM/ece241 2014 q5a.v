module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    
    reg [1:0] state,state_n;
    
    always @(*) begin
        case(state)
            S0: state_n = x? S1 : S0;
            S1: state_n = x? S2 : S1;
            S2: state_n = x? S2 : S1;
            default: state_n = S0;
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
    
    assign z = (state==S1);
    
endmodule
