module tb_Counter();
    logic clk;
    logic reset;
    logic load_i;
    logic [3:0] load_val_i;
    logic [3:0] count_o;

    loadable_counter dut (
        .clk(clk),
        .reset(reset),
        .load_i(load_i),
        .load_val_i(load_val_i),
        .count_o(count_o)
    );

    // task syntax
    // task automatic task_name(args);
    // unlike a function it does not return 
    // task can be used to define events/timings in it
    // used when need functions with events support + no return values
    task automatic loadAndCount(logic [3:0] loaded_value);
            $display("Counter value before loading: %b", count_o);
            load_i = 1'b1;
            $display("Setting the Load selector to be high: %b", load_i);
            load_val_i <= loaded_value;
            $display("Value loaded onto the counter: %b", load_val_i);
            @(posedge clk);
            $display("The counter current value is: %b", count_o);
            @(posedge clk);
            $display("The counter current value is: %b", count_o);
            @(posedge clk);
            $display("The counter current value is: %b", count_o);
            @(posedge clk);
            $display("The counter current value is: %b", count_o);
            @(posedge clk);
            $display("The counter current value is: %b", count_o);
            @(posedge clk);
            $display("The counter current value is: %b", count_o);
            load_i = 1'b0;
            $display("Setting the Load selector to be low: %b", load_i);
            repeat(8) begin
                @(posedge clk);
            end
            $display("The counter current value is: %b", count_o);
            @(posedge clk);
            @(posedge clk);
    endtask

    initial clk = 1'b0;
    always begin
        clk = 1'b0;
        #5;
        clk = 1'b1;
        #5;
    end

    //Stimulus
    initial begin
        reset = 1'b0;
        load_i = 1'b0;
        // count_o = 4'b0;

        repeat(3) begin
            @(posedge clk);
        end
        $display("Loading values for reset, load_i and counter: %b %b %b", reset, load_i, count_o);
        repeat(3) begin
            @(posedge clk);
        end

        for (int i = 0; i<=7 ; i++) begin
            loadAndCount(i);
        end

        $display("The value on counter is: %b", count_o);
        $finish;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_Counter);
    end



endmodule
