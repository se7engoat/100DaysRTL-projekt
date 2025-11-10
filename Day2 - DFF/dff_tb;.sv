module dff_tb();
    logic  clk;
    logic reset;
    logic d_i;
    logic q_norst_o;
    logic q_syncrst_o;
    logic q_asyncrst_o;

dff1 dff(
    .clk(clk),
    .reset(reset),
    .d_i(d_i),
    .q_norst_o(q_norst_o),
    .q_syncrst_o(q_syncrst_o),
    .q_asyncrst_o(q_asyncrst_o)
);

// clock generation
always begin
    clk = 1'b1;
    #5 ;
    clk = 1'b0;
    #5;
end

// stimulus
initial begin
    reset = 1'b1;
    d_i = 1'b0;
    @(posedge clk);
    d_i = 1'b1;
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    d_i = 1'b0;
    @(posedge clk);
    d_i = 1'b1;
    $finish();
    

end

endmodule