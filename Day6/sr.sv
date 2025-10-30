module SR (
    input logic clk,
    input logic reset,
    input logic x_input,
    output logic[3:0] sr_output
);

    logic [3:0] next_sr_output;
    logic [3:0] current_sr_output;


    always_ff @( posedge clk or posedge reset) begin
        if (reset)
            current_sr_output <= 4'b0000;
        else
            current_sr_output <= next_sr_output;
    end

    assign next_sr_output = {current_sr_output[2:0], x_input};

    assign sr_output = current_sr_output;

endmodule