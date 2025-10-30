module 8bitALU_tb ();

    logic [7:0] a_i;
    logic [7:0] b_i;
    logic [2:0] opcode;
    logic [7:0] alu_o;

    8bitALU 8BITALU (
        .a_i(a_i),
        .b_i(b_i),
        .opcode(opcode),
        .alu_o(alu_o),
    );

    //clock not needed coz combinational circuit
    //need to check only functional correctness
    //which does not need a clock
    
        
endmodule