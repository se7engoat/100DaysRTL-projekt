module 8bitALU(
    input logic [7:0] a_i,
    input logic [7:0] b_i,
    input logic [2:0] opcode,

    output logic [7:0] alu_o    
);

always_comb begin : ALU
    case (opcode)
        3'b000: alu_o = a_i + b_i;
        3'b001: alu_o = a_i - b_i;
        3'b010: alu_o = a_i << b_i;
        3'b011: alu_o = a_i >> b_i;
        3'b100: alu_o = a_i & b_i;
        3'b101: alu_o = a_i | b_i;
        3'b110: alu_o = ~(a_i ^ b_i);
        3'b111: alu_o = 3'b1 ? a_i == b_i : 3'b0;
    endcase
end

endmodule