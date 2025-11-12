module tb_roundRobinArbiter();
    parameter NUM_PORTS = 4;
    logic clk;
    logic reset;
    logic [NUM_PORTS-1:0] request_i;
    logic [NUM_PORTS-1:0] grant_o;


    RoundRobinArb dut (
        .clk(clk),
        .reset(reset),
        .request_i(request_i),
        .grant_o(grant_o)
    );

    initial begin
        $monitor("Time = %0t| Requests=%b | Grants=%b \n", $time, request_i, grant_o);
    end

    initial clk = 1'b0;
    always #5 clk = ~clk;

    //stimulus
    initial begin
        logic [NUM_PORTS-1:0] req_stimulus;
        request_i = '0;
        reset = 0;
        
        $display("===============alternating 1s and 0s=========== \n");
        for(int i = 0; i < NUM_PORTS; i++) begin
            if(i%2==0) begin
                req_stimulus[i] = 1;
            end else begin
                req_stimulus[i] = 0;
            end
        end
        request_i = req_stimulus;
        @(posedge clk);
        @(posedge clk);

        $display("Reverse alternating 1s and 0s \n");
        for(int i = 0; i < NUM_PORTS; i++) begin
            if(i%2 == 0) begin
                req_stimulus[i] = 0;
            end else begin
                req_stimulus[i] = 1;
            end
        end
        request_i = req_stimulus;
        @(posedge clk);
        @(posedge clk);

        $display("Making the LSB alone high \n");
        req_stimulus = '0;
        req_stimulus[0] = 1;
        request_i = req_stimulus;
        @(posedge clk);
        @(posedge clk);

        $display("Making the LSB alone low \n");
        req_stimulus = '1;
        req_stimulus[0] = 0;
        request_i = req_stimulus;
        
        @(posedge clk);
        @(posedge clk);

        $display("Making the MSB alone high \n");
        req_stimulus = '0;
        req_stimulus[NUM_PORTS-1] = 1;
        request_i = req_stimulus;
        
        @(posedge clk);
        @(posedge clk);

        $display("Making the MSB alone low \n");
        req_stimulus = '1;
        req_stimulus[NUM_PORTS-1] = 0;
        request_i = req_stimulus;
        
        @(posedge clk);
        @(posedge clk);

        $display("testing has been completed! \n");
        $finish;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_roundRobinArbiter);
    end

endmodule