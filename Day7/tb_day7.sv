module tb_lfsr();
    logic clk;
    logic reset;
    logic [3:0] lfsr_o;

    LFSR dut(
        .clk(clk),
        .reset(reset),
        .lfsr_o(lfsr_o)  
    );

    always begin
        clk = 1'b0;
        #5;
        clk = 1'b1;
        #5;
    end

    //Stimulus
    initial begin
        //Init reset
        reset = 1'b0;
        @(posedge clk);

        // Test 1: Release reset, i.e make it zero and verify clear
        reset = 1'b1;
        @(posedge clk);
        $display("After reset release lfsr_o = %b (expected 0001)", lfsr_o);

        // Test 2: assign values to lfsr and see
        // lfsr_o[0] = 1'b1;
        // @(posedge clk);
        // lfsr_o[1] = 1'b1;
        // @(posedge clk);
        // lfsr_o[2] = 1'b1;
        // @(posedge clk);
        // lfsr_o[3] = 1'b0;

        // @(posedge clk);

        // $display("This is the value in the D flip flops = %b (expected 0110) because of XOR-ing", lfsr_o);

        // @(posedge clk);
        // @(posedge clk);
        @(posedge clk);
      
      	reset = 1'b0;
        @(posedge clk);
        $display("Reset has been released from now");
        @(posedge clk);
      	$display("After reset release lfsr_o = %b ()", lfsr_o);
        @(posedge clk);
      	$display("After reset release lfsr_o = %b ()", lfsr_o);
        @(posedge clk);
      	$display("After reset release lfsr_o = %b ()", lfsr_o);
        @(posedge clk);
      	$display("After reset release lfsr_o = %b ()", lfsr_o);
        @(posedge clk);
      	$display("After reset release lfsr_o = %b ()", lfsr_o);

        @(posedge clk);
        $display("All tests completed!");
        $finish;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_lfsr);
    end




endmodule

    