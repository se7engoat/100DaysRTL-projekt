//Design and verify a 4-bit linear feedback shift register 
//where the bit[0] of the register is driven by the XOR of 
//the LFSR register bit[1] and bit[3]

module LFSR(
    input logic clk,
    input logic reset,
    output logic[3:0] lfsr_o
);

    //these wires are defined to handle 
    //sequential and combinational hardware separately
    logic [3:0] current_lfsr_output;
    logic [3:0] next_lfsr_output;

    //this is a synchronous block that will run since the first clock count
    //this logic of an hardware will get synthasized and will exist separately
    always_ff @(posedge clk) begin
        if(reset)
            current_lfsr_output <= 4'b0001;
        else 
            current_lfsr_output <= next_lfsr_output;
    end 
 
    assign next_lfsr_output = {current_lfsr_output[2:0], (current_lfsr_output[3] ^ current_lfsr_output[1])};
    assign lfsr_o = current_lfsr_output;

endmodule
