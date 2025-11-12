
//     Output should be produced in a single cycle
//     Output must be one-hot
//     The module should have the following interface:

module RoundRobinArb #(
    parameter NUM_PORTS = 4 // this is the number of physical ports
)(
    input   logic      clk,
    input   logic     reset,
    input     logic[NUM_PORTS-1:0] request_i,
    output    logic[NUM_PORTS-1:0]  grant_o
);

    logic [$clog2(NUM_PORTS)-1:0] priority_ptr;
    logic [NUM_PORTS-1:0] grant_reg;
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            priority_ptr <= '0;
            grant_reg <= '0;
        end
        else begin
            logic grant_found;
            for(int i = priority_ptr; i < NUM_PORTS; i++) begin
                if (request_i[i]) begin
                    grant_reg[i] <= 1'b1;
                    priority_ptr <= (i + 1) % NUM_PORTS;
                    grant_found <= 1'b1;
                end
            end
            if(!grant_found) begin
                for(int i = 0; i < priority_ptr; i++) begin
                    if (request_i[i]) begin
                        grant_reg[i] <= 1'b1;
                        priority_ptr <= (i + 1) % NUM_PORTS;
                        grant_found <= 1'b1;
                    end
                end
            end
        end
    end

    assign grant_o = grant_reg;

endmodule