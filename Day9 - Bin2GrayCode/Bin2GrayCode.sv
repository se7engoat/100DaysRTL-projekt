module Bin2Gray #(
    parameter VEC_W = 4
)(
    input  logic [VEC_W-1:0] bin_i,
    output logic [VEC_W-1:0] gray_o
);

    always_comb begin
        gray_o[VEC_W-1] = bin_i[VEC_W-1];
        for ( int i = VEC_W - 2; i>=0 ; i-- ) begin
            gray_o[i] = bin_i[i+1] ^ bin_i[i];
        end
    end

endmodule