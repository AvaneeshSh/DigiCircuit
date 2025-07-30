/* JKff.v
* Simple JK flip-flop with the following features:
* - positive edge triggered,
* - write enabled (active high),
* - asynchronous reset (active low).
*/

module JKff(
    input clk,
    input J, K,
    input enable,
    input reset,
    output reg Q
);

// Initialize Q to 0 for simulation
initial begin
    Q = 1'b0;
end

// Activate on clk rising edge or reset falling edge
// Update Q only if enabled and not in reset
always @(posedge clk or negedge reset)
begin
    if (reset == 1'b0)
        Q <= 1'b0;
    else if (enable == 1'b1)
    begin
        case ({J, K})
            2'b00: Q <= Q;     // Hold
            2'b01: Q <= 1'b0;  // Reset
            2'b10: Q <= 1'b1;  // Set
            2'b11: Q <= ~Q;    // Toggle
        endcase
    end
end

endmodule // JKff

