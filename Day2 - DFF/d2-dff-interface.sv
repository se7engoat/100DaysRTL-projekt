module dff (
    input logic clk,
    input logic reset,

    input logic d_i,

    output logic q_norst_o,
    output logic q_syncrst_o,
    output logic q_asyncrst_o
)


//no reset asserted
always_ff @( posedge ) begin 
    q_norst_o <= d_i;       
end

//sync reset asserted
always_ff @( posedge clk ) begin 
    if (reset) begin
        q_syncrst_o <= 1'b0;
    end else begin
        q_syncrst_o <= 1'b1;
    end
end

//async reset asserted
always_ff @( posedge clk or reset ) begin 
    if (reset) begin
        q_asyncrst_o <= 1'b0;
    end else begin
        q_asyncrst_o <= 1'b1;
    end
end

endmodule