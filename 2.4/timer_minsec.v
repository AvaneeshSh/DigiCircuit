module timer_minsec(
    input clk,
    input reset,
    input enable,
    input up_down,
    output [3:0] sec_low_digit,
    output [2:0] sec_high_digit,
    output [3:0] min_low_digit
);

    // Internal control signals
    reg sec_low_load = 0;
    reg sec_high_load = 0;
    reg min_low_load = 0;
    reg sec_high_enable = 0;
    reg min_low_enable = 0;

    // Rollover/load values for counting up and down
    integer sec_low_data_up = 4'b0000;
    integer sec_high_data_up = 3'b000;
    integer min_low_data_up = 4'b0000;

    integer sec_low_data_down = 4'b1001;    // 9
    integer sec_high_data_down = 3'b0101;   // 5
    integer min_low_data_down = 4'b1001;    // 9

    // Data inputs to counters depend on up_down and load signals
    wire [3:0] sec_low_data = up_down ? sec_low_data_up : sec_low_data_down;
    wire [2:0] sec_high_data = up_down ? sec_high_data_up : sec_high_data_down;
    wire [3:0] min_low_data = up_down ? min_low_data_up : min_low_data_down;

    // Counter outputs
    wire [3:0] low_count;
    wire [2:0] high_count;
    wire [3:0] min_count;

    // Counters instantiated with dynamic data inputs
    counter_nbit #(.WIDTH(4)) sec_low_counter (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .data(sec_low_data),
        .load(sec_low_load & enable),
        .up_down(up_down),
        .count(low_count)
    );

    counter_nbit #(.WIDTH(3)) sec_high_counter (
        .clk(clk),
        .reset(reset),
        .enable(sec_high_enable & enable),
        .data(sec_high_data),
        .load(sec_high_load & enable),
        .up_down(up_down),
        .count(high_count)
    );

    counter_nbit #(.WIDTH(4)) min_low_counter (
        .clk(clk),
        .reset(reset),
        .enable(min_low_enable & enable),
        .data(min_low_data),
        .load(min_low_load & enable),
        .up_down(up_down),
        .count(min_count)
    );

    // Counting and rollover logic
    always @(*) begin
        sec_low_load = 0;
        sec_high_load = 0;
        min_low_load = 0;
        sec_high_enable = 0;
        min_low_enable = 0;

        if (enable) begin
            if (up_down) begin
                // Count up
                if (low_count == 9) begin
                    sec_low_load = 1;
                    sec_high_enable = 1;

                    if (high_count == 5) begin
                        sec_high_load = 1;
                        min_low_enable = 1;

                        if (min_count == 9) begin
                            min_low_load = 1;
                        end
                    end
                end
            end else begin
                // Count down
                if (low_count == 0) begin
                    sec_low_load = 1;
                    sec_high_enable = 1;

                    if (high_count == 0) begin
                        sec_high_load = 1;
                        min_low_enable = 1;

                        if (min_count == 0) begin
                            min_low_load = 1;
                        end
                    end
                end
            end
        end
    end

    // Output assignments
    assign sec_low_digit = low_count;
    assign sec_high_digit = high_count;
    assign min_low_digit = min_count;

endmodule
