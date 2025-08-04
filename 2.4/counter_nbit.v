module counter_nbit #(parameter WIDTH = 4)(
    input clk,
    input reset,
    input enable,
    input [WIDTH-1:0] data,
    input load,
    input up_down,
    output reg [WIDTH-1:0] count
);

always @(posedge clk or posedge reset) begin
    if (reset)
        count <= 0;
    else if (load)
        count <= data;
    else if (enable)
        count <= up_down ? (count + 1'b1) : (count - 1'b1);
end

endmodule
