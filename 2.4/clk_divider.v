module clock_divider #(parameter CLK_DIV_INT = 10)(
    input clk,
    input reset,
    input pause,
    output reg rco_enable
);

localparam WIDTH = $clog2(CLK_DIV_INT);

wire [WIDTH-1:0] count;

counter_nbit #(.WIDTH(WIDTH)) cntr (
    .clk(clk),
    .reset(reset),
    .enable(~pause),
    .data((2**WIDTH) - CLK_DIV_INT),
    .load(rco_enable),
    .up_down(1'b1),
    .count(count)
);

initial rco_enable = 0;

always @(count) begin
    if (count == (2**WIDTH) - 1)
        rco_enable = 1'b1;
    else
        rco_enable = 1'b0;
end

endmodule
