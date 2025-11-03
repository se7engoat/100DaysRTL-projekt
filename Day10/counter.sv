// Design and verify a counter which supports loading a value
// Interface Definition

//    Counter should reset to 0
//    The module should have the following interface:

module loadable_counter (
    input logic clk,
    input logic          reset,
    input logic          load_i,     //-> Load value is valid this cycle
    input logic[3:0]     load_val_i, //-> 4-bit load value
    output logic[3:0]     count_o     //-> Counter output
);

    logic [3:0] next_val; 
    logic [3:0] current_val;
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            count_o <= 4'b0;
        end
        else if (load_i) begin
            if (count_o != next_val) begin
                count_o <= next_val;
                count_o <= count_o + 1;
            end
            else
                count_o <= count_o + 1;
        end 
        else if (!load_i) begin
            if (count_o < 4'b1111) begin
                count_o <= count_o + 1;
            end 
            else begin
                count_o <= 4'b0;
            end
        end
    end

    assign next_val = load_val_i;

endmodule

