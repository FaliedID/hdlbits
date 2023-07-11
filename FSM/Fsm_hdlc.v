module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    localparam NONE = 4'b0000;
    localparam ONE = 4'b0001;
    localparam TWO = 4'b0010;
    localparam THREE = 4'b0011;
    localparam FOUR = 4'b0100;
    localparam FIVE = 4'b0101;
    localparam SIX = 4'b0110;
    localparam ERROR = 4'b0111;
    localparam FLAG = 4'b1000;
    localparam DISC = 4'b1001;
    
    reg [3:0] state, state_n;
    
    always @ (*) begin
        case(state)
            NONE: state_n = in ? ONE : NONE;
            ONE: state_n = in ? TWO : NONE;
            TWO: state_n = in ? THREE : NONE;
            THREE: state_n = in ? FOUR : NONE;
            FOUR: state_n = in ? FIVE : NONE;
            FIVE: state_n = in ? SIX : DISC;
            SIX: state_n = in ? ERROR : FLAG;
            ERROR: state_n = in ? ERROR : NONE;
            DISC: state_n = in ? ONE : NONE;
            FLAG: state_n = in ? ONE : NONE;
            default: state_n = NONE;
        endcase
    end
    
    always @ (posedge clk) begin
        if(reset) begin
            state <= NONE;
        end else begin
            state <= state_n;
        end
    end
    
    assign disc = (state == DISC);
    assign flag = (state == FLAG);
    assign err = (state == ERROR);
            
    

endmodule
