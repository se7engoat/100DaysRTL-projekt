module tb_edgeDetector();
    logic clk;
    logic reset;
    logic a_i;
    logic rising_edge_o;
    logic falling_edge_o;

    EdgeDetector dut (
        .clk(clk),
        .reset(reset),
        .a_i(a_i),
        .rising_edge_o(rising_edge_o),
        .falling_edge_o(falling_edge_o)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $monitor("Time=%0t | clk=%b | reset=%b | a_i=%b | delayed=%b | RISING=%b | FALLING=%b",
                 $time, clk, reset, a_i, dut.delayed_input, rising_edge_o, falling_edge_o);
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_edgeDetector);
    end
    

    //Stimulus
    initial begin
        // 1. Apply reset
        reset = 1;
        a_i   = 0;
        @(posedge clk);
        @(posedge clk); // Hold reset for 2 cycles
        
        // 2. De-assert reset
        reset = 0;
        @(negedge clk); // Go to negedge to change inputs

        // 3. Test Rising Edge (0 -> 1)
        $display("--- Test: Rising Edge ---");
        a_i = 1'b1;     // Change a_i at negedge
        @(negedge clk); // Wait one full cycle
        
        // 4. Test Staying High
        $display("--- Test: Stay High ---");
        a_i = 1'b1;
        @(negedge clk);

        // 5. Test Falling Edge (1 -> 0)
        $display("--- Test: Falling Edge ---");
        a_i = 1'b0;
        @(negedge clk);

        // 6. Test Staying Low
        $display("--- Test: Stay Low ---");
        a_i = 1'b0;
        @(negedge clk);
        
        // 7. Test another rise/fall
        $display("--- Test: Rise/Fall Again ---");
        a_i = 1'b1;
        @(negedge clk);
        a_i = 1'b0;
        @(negedge clk);

        $display("--- Test Complete ---");
        #20;
        $finish;
    end

    


endmodule