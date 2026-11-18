
`timescale 1ns/1ps

module program_counter_tb;

    // Input signals
    reg clk;
    reg reset;
    reg enable;
    reg load;
    reg [7:0] load_addr;

    // Output signal
    wire [7:0] pc;

    // Error counter
    integer errors;

    // Instantiate Program Counter
    program_counter uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .load(load),
        .load_addr(load_addr),
        .pc(pc)
    );

    // Clock generator: 10 ns period
    initial clk = 0;
    always #5 clk = ~clk;

    // Main test sequence
    initial begin

        errors = 0;

        // Initial conditions
        reset = 1;
        enable = 0;
        load = 0;
        load_addr = 8'd0;

        // TEST 1: RESET
        #12;
        if (pc !== 8'd0) begin
            $display("FAIL: RESET | Expected=0, Actual=%0d", pc);
            errors = errors + 1;
        end
        else begin
            $display("PASS: RESET");
        end

        // TEST 2: INCREMENT 1
        reset = 0;
        enable = 1;

        #10;
        if (pc !== 8'd1) begin
            $display("FAIL: INCREMENT 1 | Expected=1, Actual=%0d", pc);
            errors = errors + 1;
        end
        else begin
            $display("PASS: INCREMENT 1");
        end

        // TEST 3: INCREMENT 2
        #10;
        if (pc !== 8'd2) begin
            $display("FAIL: INCREMENT 2 | Expected=2, Actual=%0d", pc);
            errors = errors + 1;
        end
        else begin
            $display("PASS: INCREMENT 2");
        end

        // TEST 4: HOLD
        enable = 0;

        #10;
        if (pc !== 8'd2) begin
            $display("FAIL: HOLD | Expected=2, Actual=%0d", pc);
            errors = errors + 1;
        end
        else begin
            $display("PASS: HOLD");
        end

        // TEST 5: LOAD
        load = 1;
        load_addr = 8'd20;

        #10;
        if (pc !== 8'd20) begin
            $display("FAIL: LOAD | Expected=20, Actual=%0d", pc);
            errors = errors + 1;
        end
        else begin
            $display("PASS: LOAD");
        end

        // TEST 6: INCREMENT AFTER LOAD
        load = 0;
        enable = 1;

        #10;
        if (pc !== 8'd21) begin
            $display("FAIL: INCREMENT AFTER LOAD | Expected=21, Actual=%0d", pc);
            errors = errors + 1;
        end
        else begin
            $display("PASS: INCREMENT AFTER LOAD");
        end

        // FINAL TEST REPORT
        $display("--------------------------------");
        $display("PROGRAM COUNTER TEST REPORT");
        $display("Total Tests : 6");
        $display("Failed Tests: %0d", errors);
        $display("Passed Tests: %0d", 6 - errors);
        $display("--------------------------------");

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TEST FAILED");

        $display("PROGRAM COUNTER TEST COMPLETED");

        $finish;
    end

endmodule
