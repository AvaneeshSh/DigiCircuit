`timescale 1ns/1ns

/* data_plexer_en_3x1x4_tb.v
*    Tests a 4-bit data x 3-channel multiplexer and enable module.
*/

module data_plexer_en_3x1x4_tb (
    output wire [3:0] data_out,
    output wire [3:0] data_en
);

    // Define 'data' to be 4-bit x 3 channels vector
    wire [11:0] data;            // 4-bit data x 3 channels = 12

    // Simulation signals
    reg clk;
    reg [1:0] cnt;

    // 3:1 mux x 4bits inputs
    reg [3:0] dig2 = 4'h2;
    reg [3:0] dig1 = 4'h1;
    reg [3:0] dig0 = 4'h0;

    assign data = {dig2, dig1, dig0};

    // Clock generator: 10 ns period, 50% duty cycle
    initial clk = 0;
    always #5 clk = ~clk;

    // Synchronous 2-bit counter: 00 to 01 to 10 to 00 ...
    always @(posedge clk) begin
        if (cnt == 2'b10)
            cnt <= 2'b00;
        else
            cnt <= cnt + 1;
    end

    // Instantiate the UUT
    data_plexer_en #(.INPUT_WIDTH(4), .SEL(2)) UUT (
        .data_in(data),
        .sel_ctrl(cnt),
        .data_out(data_out),
        .data_en(data_en)
    );

    // Simulation stimulus
    initial begin
        cnt = 0; // Initialize counter

        #85;
        dig0 = 4'hA;
        dig1 = 4'hB;
        dig2 = 4'hC;

        #80;
        dig0 = 4'h5;
        dig1 = 4'h6;
        dig2 = 4'h7;

        #40;
        $stop;
    end

endmodule

