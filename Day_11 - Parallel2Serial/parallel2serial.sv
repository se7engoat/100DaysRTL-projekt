module Parallel2Serial #(
    parameter WIDTH = 4
) (
    input logic clk,
    input logic reset,
    input logic [WIDTH-1:0] parallel_i,
    output logic serial_o,
    output logic valid_o, // -> Serial bit is valid
    output logic empty_o // -> Should be asserted when all of the bits are given out serially
);
    logic next_val;
    always_ff @( posedge clk or posedge reset ) begin
        if(reset)
            next_val <= 1'b0;
        for ( int i = 0; i < WIDTH ; i++ ) begin
            next_val <= parallel_i[i];
            //checking the sent out serial bit is the same as the input parallel bit
            if(~(next_val ^ parallel_i[i]))
                valid_o <= 1'b1; //if they are the same then, set valid bit as high
            else
                valid_o <= 1'b0;

            empty_o <= 1? (i==3): 0;
        end
    end

    assign serial_o = next_val;
endmodule


