
/* counter_nbit_updown-project.v
*      Avaneesh Sharma
*      2025-08-01
*      189190
*/

module counter_nbit_updown #(parameter WIDTH = 4)(
    input clk,
    input enable,
    input [WIDTH-1:0] data,
    input load,
    input up_down,
    output reg[WIDTH-1:0] count
);

// Initialize the counter to 0
initial count = 0;

// Always block triggered on the rising edge of the clock
always @ (posedge clk) begin
    if (load) begin
        count <= data;
    end
    else if (enable) begin
        count <= up_down ? (count + 1'b1) : (count - 1'b1);
    end
end

endmodule // counter_nbit_updown
