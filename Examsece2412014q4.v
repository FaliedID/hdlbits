module top_module (
    input clk,
    input x,
    output z
); 
    wire d1, d2, d3, q1, q2, q3;
    initial begin
        d1 <= 0;
        d2 <= 0;
        d3 <= 0;
        q1 <= 0;
        q2 <= 0;
        q3 <= 0;
    end

    always @(posedge clk) begin
        q1 <= d1;
        q2 <= d2;
        q3 <= d3;
    end
    
    assign d1 = q1 ^ x;
    assign d2 = (~q2) & x;
    assign d3 = (~q3) | x;
    assign z = ~(q1 | q2 | q3);
    
endmodule
