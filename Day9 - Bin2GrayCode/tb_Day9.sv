// Simple testbench for Bin2Gray
module tb_Bin2Gray;
    parameter VEC_W = 4;

    // DUT signals
    logic [VEC_W-1:0] bin_i;
    logic [VEC_W-1:0] gray_o;

    // Instantiate DUT (module name inside file is Bin2Gray)
    Bin2Gray #(.VEC_W(VEC_W)) dut (
        .bin_i(bin_i),
        .gray_o(gray_o)
    );

    // syntax for a function: 
    // function automatic return_type function_name (arguments);
    function automatic logic [VEC_W-1:0] bin2gray_f(logic [VEC_W-1:0] bin);

        logic [VEC_W-1:0] gray;
        gray[VEC_W-1] = bin[VEC_W-1];
        for (int i = VEC_W-2; i >= 0; i--) begin
            gray[i] = bin[i+1] ^ bin[i];
        end
        return gray;
    endfunction

    initial begin
        // Sweep all inputs and compare
        for (int i = 0; i < (1<<VEC_W); i++) begin
            bin_i = i;
            #1; // allow combinational logic to settle
            if (gray_o !== bin2gray_f(bin_i)) begin
                $display("ERROR: bin=%b expected=%b got=%b", bin_i, bin2gray_f(bin_i), gray_o);
                $fatal(1);
            end else begin
                $display("OK:    bin=%b gray=%b", bin_i, gray_o);
            end
        end
        $display("All tests passed");
        $finish;
    end

endmodule