module tb_parallel2serial();
    parameter WIDTH = 4;
    logic clk;
    logic reset;
    logic [WIDTH-1:0] parallel_i;
    logic serial_o;
    logic valid_o;
    logic empty_o;
    
    Parallel2Serial dut (
        .clk(clk),
        .reset(reset),
        .parallel_i(parallel_i),
        .serial_o(serial_o),
        .valid_o(valid_o),
        .empty_o(empty_o)
    );
    
    task automatic parallel2serial(logic [3:0] input_data);
        parallel_i = input_data;
        $display("\nLoading parallel data: %b", input_data);
        
        repeat(WIDTH) begin
            @(posedge clk);
            $display("  Serial output: %b, Valid: %b, Empty: %b", 
                     serial_o, valid_o, empty_o);
        end
    endtask
    
    // Clock
    initial clk = 1'b0;
    always #5 clk = ~clk;
    
    // Stimulus
    initial begin
        reset = 1;
        parallel_i = 4'b0;
        
        @(posedge clk);
        reset = 0;
        @(posedge clk);
        
        parallel2serial(4'b1010);
        parallel2serial(4'b1100);
        parallel2serial(4'b0011);
        parallel2serial(4'b1111);
        
        $display("\nTest completed!");
        $finish;
    end
    
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_parallel2serial);
    end
    
endmodule