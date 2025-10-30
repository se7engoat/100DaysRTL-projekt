module Bin2Gray #(
    parameter VEC_W = 4;
)(
    logic [VEC_W-1] bin_i,
    logic [VEC_W-1] gray_o
);

    Bin2Gray dut (
        .bin_i(bin_i),
        .gray_o(gray_o)
    );


    function automatic int bin2gray(int bin, int gray);
        for (int i = VEC_W - 2; i>=0 ; i-- ) begin
            gray[i] = bin[i+1] ^ bin[i];
        end
    endfunction


    always_comb begin
        bin2gray(bin)
    end

    
endmodule