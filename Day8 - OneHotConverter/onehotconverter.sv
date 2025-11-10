//Design and verify a parameterized binary to one-hot converter

module OneHot #(
    parameter BIN_W       = 4,
    parameter ONE_HOT_W   = 16
)(
    input logic [BIN_W-1:0] bin_i,
    output logic [ONE_HOT_W-1:0] one_hot_o
);


    // input is only gonna be 4 bit wide, encoding 16 states
    // output is going to be 16 bit wide, because 16 states need 16 different ones
    // bin_i = 0000 -> one_hot_o = 0000000000000001
    // bin_i = 0001 -> one_hot_o = 0000000000000010
    // so for every consecutive input binary, the one hot is shifted input number
    // of times to the left

    parameter initial_one_hot = 16'b0000000000000001; 
    
    always_comb begin
        assign one_hot_o = initial_one_hot << bin_i;
    end


endmodule