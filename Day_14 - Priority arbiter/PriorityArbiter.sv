module PriorityArbiter #(
    parameter NUM_PORTS = 4
)(
    input logic [NUM_PORTS-1:0] requests_i,
    output logic [NUM_PORTS-1:0] grants_o
);

    // logic priority = 0;
    always_comb begin
        logic grant_permission = 0;

        grants_o = '0;
        for(int i = 0; i <NUM_PORTS; i++) begin 
            if(requests_i[i] && grant_permission == 0) begin
                grants_o[i] = 1'b1;
                grant_permission = 1'b1;
            end
        end
    end

endmodule