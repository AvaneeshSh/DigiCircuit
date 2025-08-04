module timer_60(
    input clk,
    input reset,
    input enable,      // This enable should already be divided clock (e.g., every 5 cycles)
    output reg [3:0] low_digit,
    output reg [2:0] high_digit
);

    reg low_load;
    reg high_load;
    reg high_enable;

    wire [3:0] low_count;
    wire [2:0] high_count;

    // Internal counters for low and high digits
    counter_nbit #(.WIDTH(4)) LD (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .data(4'b0000),
        .load(low_load),
        .up_down(1'b1),
        .count(low_count)
    );

    counter_nbit #(.WIDTH(3)) HD (
        .clk(clk),
        .reset(reset),
        .enable(high_enable),
        .data(3'b000),
        .load(high_load),
        .up_down(1'b1),
        .count(high_count)
    );

    // Combinational logic to control loading and enabling counters
    always @(*) begin
        low_load = 0;
        high_load = 0;
        high_enable = 0;

        if (enable) begin
            if (low_count == 9 && high_count == 5) begin
                // At 59 → reset both counters
                low_load = 1;
                high_load = 1;
            end else if (low_count == 9) begin
                // At 9 → reset low digit and enable high digit to increment
                low_load = 1;
                high_enable = 1;
            end
        end
    end

    // Update outputs synchronously
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            low_digit <= 0;
            high_digit <= 0;
        end else begin
            low_digit <= low_count;
            high_digit <= high_count;
        end
    end

endmodule
