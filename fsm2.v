module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
        if(j==0&state==OFF)
            next_state <= OFF;
        else if(j==1&state==OFF)
            next_state <= ON;
        else if(k==0&state==ON)
            next_state <= ON;
        else
            next_state <= OFF;
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic
    // assign out = (state == ...);
    assign out = state;

endmodule
