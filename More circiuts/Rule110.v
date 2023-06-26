module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
        	integer i;
        	for (i=1; i<511; i=i+1) begin
                q[i] <= (~q[i+1]&q[i-1])|(~q[i]&q[i-1])|(q[i]&~q[i-1]);	// solved by K map
        	end
            q[0] <= q[0];
            q[511] <= q[510]|(q[511]&~q[510]);
        end
    end
            
endmodule
