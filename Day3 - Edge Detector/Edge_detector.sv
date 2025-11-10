
//Design and verify a rising and falling edge detector

module EdgeDetector(
    input  logic  clk,
    input logic reset,
    input logic a_i, //serial input to the module
    output logic rising_edge_o, // Rising edge output
    output logic falling_edge_o  // Falling edge output
);

    logic delayed_input;
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            delayed_input <= 0;
        else
            delayed_input <= a_i;
    end

    always_comb begin
        rising_edge_o = 1'b0;
        falling_edge_o = 1'b0;

        if(a_i ^ delayed_input) //means there is a change in the edge
            if(a_i == 1'b1)
                rising_edge_o = 1'b1;
            else
                falling_edge_o = 1'b1;
    end

    

endmodule
