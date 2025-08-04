module top_60 #(parameter CLK_DIV_INT=5) (
    input clk,
    input reset,
    input pause,
    output [3:0] low_digit,
    output [2:0] high_digit,
    output [3:0] muxed_digits,
    output en_high_digit,
    output en_low_digit
);

    wire enable;

    // Clock divider for divide-by-5 enable signal
    clock_divider #(.CLK_DIV_INT(CLK_DIV_INT)) clkdiv_inst (
        .clk(clk),
        .reset(reset),
        .pause(pause),
        .rco_enable(enable)
    );

    timer_60 timer_inst (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .low_digit(low_digit),
        .high_digit(high_digit)
    );

    // Digit selector toggles every clock cycle for multiplexing
    reg sel_ctrl = 0;
    always @(posedge clk or posedge reset) begin
        if (reset)
            sel_ctrl <= 0;
        else
            sel_ctrl <= ~sel_ctrl;
    end

    wire [7:0] data_in = {1'b0, high_digit, low_digit};
    wire [1:0] data_en;
    wire [3:0] muxed_digits_wire;

    data_plexer_en #(.INPUT_WIDTH(4), .SEL(1)) mux_inst (
        .data_in(data_in),
        .sel_ctrl(sel_ctrl),
        .data_out(muxed_digits_wire),
        .data_en(data_en)
    );

    assign muxed_digits = muxed_digits_wire;
    assign en_low_digit = (sel_ctrl == 0) ? data_en[0] : 0;
    assign en_high_digit = (sel_ctrl == 1) ? data_en[1] : 0;

endmodule
