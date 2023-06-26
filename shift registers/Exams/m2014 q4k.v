module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    wire [2:0] r;
    
    always @(posedge clk) begin
        if (~resetn) begin
            r[2:0] <= 3'b0;
            out <= 1'b0;
        end
        else begin
            r[2] <= in;
            r[1:0] <= r[2:1];
            out <= r[0];
        end
    end
            

endmodule
