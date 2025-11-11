module tb_priorityArbiter();
    parameter NUM_PORTS = 4;

    logic [NUM_PORTS-1:0] requests_i;
    logic [NUM_PORTS-1:0] grants_o;


    PriorityArbiter dut(
        .requests_i(requests_i),
        .grants_o(grants_o)
    );

    initial begin
        $monitor("The values for requests and grants: %b, %b \n", requests_i, grants_o);
    end

    //Stimulus
    initial begin
        logic [NUM_PORTS-1:0] req_stimulus;
        requests_i = '0;
        
        $display("===============alternating 1s and 0s=========== \n");
        for(int i = 0; i < NUM_PORTS; i++) begin
            if(i%2==0) begin
                req_stimulus[i] = 1;
            end else begin
                req_stimulus[i] = 0;
            end
        end
        requests_i = req_stimulus;
        #10

        $display("Reverse alternating 1s and 0s \n");
        for(int i = 0; i < NUM_PORTS; i++) begin
            if(i%2 == 0) begin
                req_stimulus[i] = 0;
            end else begin
                req_stimulus[i] = 1;
            end
        end
        requests_i = req_stimulus;
        #10

        $display("Making the LSB alone high \n");
        req_stimulus = '0;
        req_stimulus[0] = 1;
        requests_i = req_stimulus;
        #10

        $display("Making the LSB alone low \n");
        req_stimulus = '1;
        req_stimulus[0] = 0;
        requests_i = req_stimulus;
        #10

        $display("Making the MSB alone high \n");
        req_stimulus = '0;
        req_stimulus[NUM_PORTS-1] = 1;
        requests_i = req_stimulus;
        #10

        $display("Making the MSB alone low \n");
        req_stimulus = '1;
        req_stimulus[NUM_PORTS-1] = 0;
        requests_i = req_stimulus;
        #10

        $display("testing has been completed! \n");
        $finish;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_priorityArbiter);
    end


endmodule