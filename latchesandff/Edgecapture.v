module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] in_delay;
    wire [31:0] falling_edge;
    integer i;
    
    always @(posedge clk) begin
        in_delay <= in;
    end
    
    always @(posedge clk) begin
        if(reset)
            out <= 32'b0;
        else begin
            for(i=0; i<32; i++) begin
            	if(falling_edge[i])
                	out[i] <= 1'b1;
        	end
        end
    end
    
    assign falling_edge = (~in) & in_delay;        

endmodule
