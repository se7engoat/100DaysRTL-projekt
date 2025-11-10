module tb_sr();
    logic clk;
    logic reset;
    logic x_input;
    logic [3:0] sr_output;
    
    SR dut(
        .clk(clk),
        .reset(reset),
        .x_input(x_input),
        .sr_output(sr_output)
    );
    
    // Clock generation
    always begin
        clk = 1'b0;
        #5;
        clk = 1'b1;
        #5;
    end
    
    // Stimulus
    initial begin
        // Initialize
        reset = 1'b1;
        x_input = 1'b0;
        @(posedge clk);
        @(posedge clk);
        
        // Test 1: Release reset and verify clear
        reset = 1'b0;
        @(posedge clk);
        $display("After reset release: sr_output = %b (expected 0000)", sr_output);
        
        // Test 2: Shift in all 1's
        repeat(4) begin
            x_input = 1'b1;
            @(posedge clk);
            $display("Shifting 1: sr_output = %b", sr_output);
        end
        $display("After 4 ones: sr_output = %b (expected 1111)", sr_output);
        
        // Test 3: Shift in all 0's
        repeat(4) begin
            x_input = 1'b0;
            @(posedge clk);
            $display("Shifting 0: sr_output = %b", sr_output);
        end
        $display("After 4 zeros: sr_output = %b (expected 0000)", sr_output);
        
        // Test 4: Shift in pattern 1011
        x_input = 1'b1; @(posedge clk);
        x_input = 1'b1; @(posedge clk);
        x_input = 1'b0; @(posedge clk);
        x_input = 1'b1; @(posedge clk);
        $display("After pattern 1011: sr_output = %b (expected 1011)", sr_output);
        
        // Test 5: Reset during operation
        reset = 1'b1;
        @(posedge clk);
        $display("After reset: sr_output = %b (expected 0000)", sr_output);
        
        // Test 6: Verify shift direction (detailed)
        reset = 1'b0;
        x_input = 1'b0;
        @(posedge clk); // sr_output should be 0000
        
        x_input = 1'b1;
        @(posedge clk); // sr_output should be 0001
        $display("After 1st shift: sr_output = %b (expected 0001)", sr_output);
        
        x_input = 1'b0;
        @(posedge clk); // sr_output should be 0010
        $display("After 2nd shift: sr_output = %b (expected 0010)", sr_output);
        
        x_input = 1'b0;
        @(posedge clk); // sr_output should be 0100
        $display("After 3rd shift: sr_output = %b (expected 0100)", sr_output);
        
        x_input = 1'b0;
        @(posedge clk); // sr_output should be 1000
        $display("After 4th shift: sr_output = %b (expected 1000)", sr_output);
        
        x_input = 1'b0;
        @(posedge clk); // sr_output should be 0000 (1 shifted out)
        $display("After 5th shift: sr_output = %b (expected 0000)", sr_output);
        
        $display("All tests completed!");
        $finish;
    end
    
    // Optional: Waveform dump
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_sr);
    end
    
endmodule