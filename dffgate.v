module top_module (
    input clk,
    input in, 
    output out);
    
    wire w1;
    
    always @(*) begin
        w1 <= in ^ out;
    end
    
    always @(posedge clk) begin
        out <= w1;        
    end

endmodule
