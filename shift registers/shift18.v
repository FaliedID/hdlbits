// arithmetic shifter 1 or 8 bits
module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q);
    
    // sequential logic
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else if(ena) begin
            case (amount)
                2'b00:    // shift left 1 bit
                    begin
                        q[63:1] <= q[62:0];
                        q[0] <= 0;
                    end
                2'b01:    // shift left 8 bits
                    begin
                        q[63:8] <= q[55:0];
                        q[7:0] <= 0;
                    end
                2'b10: q[62:0] <= q[63:1];     // shift right 1 bit (arithmetic)
                2'b11: // shift right 8 bits (arithmetic)
                    begin
                        if(q[63]) begin
                            q[55:0] <= q[63:8];
                            q[63:56] <= 8'hFF;
                        end
                        else begin
                            q[55:0] <= q[63:8];
                            q[63:56] <= 0;
                        end
                    end
            endcase
        end
    end
                        
            

endmodule
