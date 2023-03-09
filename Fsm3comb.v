module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=2'b00, B=2'b01, C=2'b10, D=2'b11;

    // State transition logic: next_state = f(state, in)
    always @(*) begin
        if(state == A & in == 0)
            next_state <= A;
        else if(state == A & in == 1)
            next_state <= B;
        else if(state == B & in == 0)
            next_state <= C;
        else if(state == B & in == 1)
            next_state <= B;
        else if(state == C & in == 0)
            next_state <= A;
        else if(state == C & in == 1)
            next_state <= D;
        else if(state == D & in == 0)
            next_state <= C;
        else
            next_state <= B;
    end

    // Output logic:  out = f(state) for a Moore state machine
    assign out = (state==D) ? 1'b1 : 1'b0;

endmodule
