module tb_oneHot #(
    BIN_W = 4,
    ONE_HOT_W = 16
) (
    logic [BIN_W-1:0]bin_i;
    logic [ONE_HOT_W-1:0]one_hot_o;
    logic [ONE_HOT_W-1:0]expected    
);

    OneHot dut (
        .bin_i(bin_i),
        .one_hot_o(one_hot_o)
    );
    
    initial begin
        $display("Binary | One-Hot Output | Expected | Status");
        $display("-------|-----------------|----------|--------");

        //Test all possible 16 cases
        for (int i = 0; i<16 ; i++) begin
            bin_i = i;
            expected = 1 << i;
            #4;
            $display("  %4b  |  %16b  |  %16b  |  %s  ", bin_i, one_hot_o, expected, (one_hot_o == expected) ? "TRUE" : "FALSE");

        end

        $display("\nTest completed!");
        $finish;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_oneHot);
    end

endmodule