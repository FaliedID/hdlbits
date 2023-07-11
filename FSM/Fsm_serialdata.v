module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
    localparam S0 = 3'b000; // IDLE
    localparam S1 = 3'b001;	// TRANSFER
    localparam S2 = 3'b010;	// END
    localparam S3 = 3'b011; // STOP
    localparam S4 = 3'b100;	// ERROR
    
    reg [2:0] state, state_n;
    reg [2:0] cnt;
    reg [7:0] data;
    
    always @ (*) begin
        case (state)
            S0: state_n = (in) ? S0 : S1;
            S1: state_n = (cnt == 3'b111) ? S2 : S1;
            S2: state_n = (in) ? S3 : S4;
            S3: state_n = (in) ? S0 : S1;
            S4: state_n = (in) ? S0 : S4;
        endcase
    end
    
    always @ (posedge clk) begin
        if(reset) begin
            cnt <= 0;
            state <= S0;
            data <= 8'b0;
        end
        else begin
            state <= state_n;
            if(state == S1) begin
                cnt <= cnt + 1'b1;
                data[cnt] <= in;
            end else begin
                cnt <= 3'b000;
            end                
        end
    end
    
    assign done = (state == S3);

    // New: Datapath to latch input bits.
    assign out_byte = data;

endmodule
