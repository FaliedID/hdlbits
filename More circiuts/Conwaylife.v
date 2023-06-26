module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    
    reg [17:0][17:0] array; // SystemVerilog syntax
    
    always @(*) begin
        integer i, j;
        // Copy 1D vector to 2D vector
        for(i=1;i<=16;i=i+1) begin
            for(j=1;j<=16;j=j+1) begin
                array[i][j] = q[16*(i-1) + j - 1];
            end
        end
        // extention up, down, left, right by 1 bit 
        // rows
        for(i=1;i<=16;i=i+1) begin
            array[17][i] = array[1][i];
            array[0][i] = array[16][i];
        end
        // columbs
        for(i=1;i<=16;i=i+1) begin
            array[i][17] = array[i][1];
            array[i][0] = array[i][16];
        end
        // corners
    	array[0][0] = array[16][16];
    	array[17][17] = array[1][1];
    	array[0][17] = array[16][1];
    	array[17][0] = array[1][16];
    end
    
    always @(posedge clk) begin
        if(load) begin
            q <= data;
        end else begin
            integer i, j;
            for(i=1; i<=16; i=i+1) begin
                for(j=1; j<=16; j=j+1) begin
                    case (array[i+1][j+1]+
                          array[i+1][j]+
                          array[i][j+1]+
                          array[i-1][j-1]+
                          array[i+1][j-1]+
                          array[i-1][j+1]+
                          array[i-1][j]+
                          array[i][j-1])
                        3'b010: q[(i-1)*16 + j - 1] <= array[i][j];
                        3'b011: q[(i-1)*16 + j - 1] <= 1'b1;
                        default: q[(i-1)*16 + j - 1] <= 1'b0;
                    endcase
                end
            end                    
        end
    end
    

endmodule
