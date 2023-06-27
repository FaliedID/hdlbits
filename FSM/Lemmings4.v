module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    // parameter LEFT=0, RIGHT=1, ...
    localparam LEFT = 3'b000;
    localparam RIGHT = 3'b001;
    localparam FALL_L = 3'b010;
    localparam FALL_R = 3'b011;
    localparam DIG_L = 3'b110;
    localparam DIG_R = 3'b111;
    localparam SPLAT = 3'b100;
    
    reg [2:0] state, next_state;
    int cnt;

    always @(*) begin
        // State transition logic
        case (state)
            LEFT: next_state = (~ground) ? FALL_L : ((dig) ? DIG_L : (bump_left ? RIGHT : LEFT));
            RIGHT: next_state = (~ground) ? FALL_R : ((dig) ? DIG_R : (bump_right ? LEFT : RIGHT));
            FALL_L: next_state = ground ? (cnt > 19 ? SPLAT : LEFT): FALL_L;
            FALL_R: next_state = ground ? (cnt > 19 ? SPLAT : RIGHT): FALL_R;
            DIG_L: next_state = ground ? DIG_L : FALL_L;
            DIG_R: next_state = ground ? DIG_R : FALL_R;
            SPLAT: next_state = SPLAT;
        endcase
        
    end

    always @(posedge clk or posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) begin
            state <= LEFT;
            cnt <= 5'b0;
        end else begin
            state <= next_state;
            if (aaah) begin
                cnt <= cnt + 1'b1;
            end else if (walk_left | walk_right) begin
                cnt <= 5'b0;
            end
        end
    end

    // Output logic
    assign walk_left = (state == LEFT) ? 1'b1 : 1'b0;
    assign walk_right = (state == RIGHT) ? 1'b1 : 1'b0;
    assign aaah = (state == FALL_L | state == FALL_R) ? 1'b1 : 1'b0;
    assign digging = (state == DIG_L | state == DIG_R) ? 1'b1 : 1'b0;

endmodule
