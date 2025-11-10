module tb_seqDetector ();
    // Sequence to detect
    // LEN: Length of the sequence to be detected
    parameter LEN = 12;
    parameter SEQ = 12'b111011011011;

    logic clk;
    logic reset;
    logic x_i;
    logic det_o;
    
    SequenceDetector dut (
        .clk    (clk),
        .reset  (reset),
        .x_i    (x_i),
        .det_o  (det_o)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 1;
        x_i = 0;
        #12;
        reset = 0;

        // Input sequence: 111011011011 (with overlapping)
        // Expected det_o to be asserted at the end of the sequence
        @(posedge clk) x_i = 1; // 1
        @(posedge clk) x_i = 1; // 11
        @(posedge clk) x_i = 1; // 111
        @(posedge clk) x_i = 0; // 1110
        @(posedge clk) x_i = 1; // 11101
        @(posedge clk) x_i = 1; // 111011
        @(posedge clk) x_i = 0; // 1110110
        @(posedge clk) x_i = 1; // 11101101
        @(posedge clk) x_i = 1; // 111011011
        @(posedge clk) x_i = 0; // 1110110110
        @(posedge clk) x_i = 1; // 11101101101
        @(posedge clk) x_i = 1; // 111011011011 -> det_o should be asserted here
        @(posedge clk);
        $display("Testing has been completed \n");
        $display("The values in the shift register are: %b \n", dut.shift_reg);
        $display("The sequence is: %b \n", SEQ );
        $display("Has the output been asserted or not? %s \n", (det_o==1)? "Yes": "No");

        
        $finish;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb_seqDetector);
    end

endmodule