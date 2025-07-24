module logic_gen_tb (
    output wire [3:0] out1,
    output wire [3:0] out2,
    output wire [7:0] out3
);
    reg [3:0] A4, B4;
    reg [7:0] A8, B8;
    reg [1:0] func;
    wire [3:0] structural_out, behavioral_out_4;
    wire [7:0] behavioral_out_8;

    // Instantiate structural 4-bit logic
    logic_gen_structural uut1 (
        .A(A4),
        .B(B4),
        .logic_func(func),
        .logic_out(structural_out)
    );

    // Instantiate behavioral 4-bit logic
    logic_gen_behavioral #(4) uut2 (
        .A(A4),
        .B(B4),
        .logic_func(func),
        .logic_out(behavioral_out_4)
    );

    // Instantiate behavioral 8-bit logic
    logic_gen_behavioral #(8) uut3 (
        .A(A8),
        .B(B8),
        .logic_func(func),
        .logic_out(behavioral_out_8)
    );

    assign out1 = structural_out;
    assign out2 = behavioral_out_4;
    assign out3 = behavioral_out_8;

    initial begin
        $display("Starting testbench...");
        
        // 4-bit test case: 0110, 1100
        A4 = 4'b0110; B4 = 4'b1100;
        A8 = 8'b01101100; B8 = 8'b11001110;

        // Loop through all 4 logic functions
        for (func = 0; func < 4; func = func + 1) begin
            #10;
        end

        // Extra test case: A4 = 1010, B4 = 0101 | A8 = 10101010, B8 = 01010101
        A4 = 4'b1010; B4 = 4'b0101;
        A8 = 8'b10101010; B8 = 8'b01010101;

        for (func = 0; func < 4; func = func + 1) begin
            #10;
        end

        $finish;
    end
endmodule

