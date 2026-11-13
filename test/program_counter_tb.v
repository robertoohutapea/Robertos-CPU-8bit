
`timescale 1ns/1ps

module program_counter_tb;

    reg clk;
    reg reset;
    reg enable;
    reg load;
    reg [7:0] load_addr;

    wire [7:0] pc;

    program_counter uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .load(load),
        .load_addr(load_addr),
        .pc(pc)
    );

    // Clock generator
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin

        reset = 1;
        enable = 0;
        load = 0;
        load_addr = 0;

        // Test RESET
        #12;
        if (pc !== 8'd0)
            $display("FAIL: RESET");
        else
            $display("PASS: RESET");

        reset = 0;
        enable = 1;

        // Test INCREMENT
        #10;
        if (pc !== 8'd1)
            $display("FAIL: INCREMENT 1");
        else
            $display("PASS: INCREMENT 1");

        #10;
        if (pc !== 8'd2)
            $display("FAIL: INCREMENT 2");
        else
            $display("PASS: INCREMENT 2");

        // Test HOLD
        enable = 0;
        #10;
        if (pc !== 8'd2)
            $display("FAIL: HOLD");
        else
            $display("PASS: HOLD");

        // Test LOAD
        load = 1;
        load_addr = 8'd20;
        #10;
        if (pc !== 8'd20)
            $display("FAIL: LOAD");
        else
            $display("PASS: LOAD");

        // Test INCREMENT AFTER LOAD
        load = 0;
        enable = 1;
        #10;
        if (pc !== 8'd21)
            $display("FAIL: INCREMENT AFTER LOAD");
        else
            $display("PASS: INCREMENT AFTER LOAD");

        $display("PROGRAM COUNTER TEST COMPLETED");

        $finish;
    end

endmodule
