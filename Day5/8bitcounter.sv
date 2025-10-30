//module definition named 8bit_counter
module 8bit_counter (
    input logic clk,
    input logic reset,
    output logic [7:0] count
);

logic [7:0] next_count;
always_ff @(posedge clk or posedge reset) begin
    if (reset)
        count <= 8'h1; // Reset count to 1
    else
        count <= next_count; // Increment count
end

assign next_count = count + 8'h2;

endmodule