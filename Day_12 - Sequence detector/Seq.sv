// Code your design here
//Design and verify a sequence detector to detect the following sequence: 1110_1101_1011
//Overlapping sequences should be detected
module SequenceDetector (
    input     logic        clk,
    input     logic        reset,
    input     logic        x_i,    //-> Serial input
    output    logic        det_o   //-> Output asserted when sequence is detected
);

    parameter SEQ = 12'b111011011011;
    parameter LEN = 12;


  logic [LEN-1:0] shift_reg = 12'b0;

    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            shift_reg <= 0;
        else
            shift_reg <= {shift_reg[LEN-2:0],x_i};
    end

    assign det_o = (shift_reg == SEQ);
    
endmodule
