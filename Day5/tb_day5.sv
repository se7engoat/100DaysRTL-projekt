//testbench for 8 bit counter
module tb_8bitcounter();
    logic clk;
    logic reset;
    logic [7:0] count;

    8bit_counter dut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    always begin 
        clk = 1'b0;
        #5;
        clk = 1'b1;
        #5;
    end

    inital begin
        reset <= 1'b1;
        @(posedge clk);
        @(posedge clk);
        reset <= 1'b0;
        for (int i = 0; i < 50; i++) begin
            @(posedge clk);
        end
        $finish;
    end

endmodule   
