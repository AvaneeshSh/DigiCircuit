`timescale 1ns/1ns

module ssd_driver_tb (
    output wire [6:0] ssd_out
);
    reg [3:0] binary_in;
    reg enable;

    // Instantiate the Unit Under Test (UUT)
    ssd_driver UUT (
        .enable(enable),
        .binary_in(binary_in),
        .ssd_out(ssd_out)
    );

    initial begin
        enable = 1'b1;
        binary_in = 4'h0;
        
        // Loop through all values 0x0 to 0xF
        repeat (16) begin
            #10 binary_in = binary_in + 1;
        end

        // Test with enable = 0 (all segments should be off)
        #10 enable = 1'b0;
        binary_in = 4'hA; // Doesn't matter what the input is
        #10;
    end
endmodule
