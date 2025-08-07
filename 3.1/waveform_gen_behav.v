module waveform_gen_behav(
    input clk,
    input enable,
    input sig_in,
    output reg sig_out
);

    // State declarations using parameters
    parameter S0 = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              S3 = 3'b011,
              S4 = 3'b100;

    reg [2:0] state;
    reg [2:0] next_state;

    // Sequential block: update state on clock edge
    always @(posedge clk) begin
        if (enable)
            state <= next_state;
    end

    // Combinational block: next-state logic
    always @(*) begin
        case (state)
            S0: next_state = sig_in ? S1 : S0;
            S1: next_state = sig_in ? S2 : S0;
            S2: next_state = sig_in ? S2 : S3;
            S3: next_state = sig_in ? S4 : S0;
            S4: next_state = sig_in ? S4 : S0;
            default: next_state = S0;
        endcase
    end

    // Combinational block: output logic (Moore)
    always @(*) begin
        case (state)
            S1,
            S3: sig_out = 1'b1;
            default: sig_out = 1'b0;
        endcase
    end

endmodule
