`ifdef __ICARUS__
`timescale 1ns/1ps

module program_counter_tb;

    reg clk;
    reg reset;
    reg enable;
    reg load;
    reg [7:0] load_addr;

    wire [7:0] pc;

    integer errors;
    integer total_tests;

    program_counter uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .load(load),
        .load_addr(load_addr),
        .pc(pc)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    task check_pc;
        input [7:0] expected;
        input [200*8:1] test_name;
        begin
            total_tests = total_tests + 1;

            if (pc !== expected) begin
                $display(
                    "FAIL: %0s | Expected=%0d Actual=%0d",
                    test_name, expected, pc
                );
                errors = errors + 1;
            end
            else begin
                $display(
                    "PASS: %0s | PC=%0d",
                    test_name, pc
                );
            end
        end
    endtask

    initial begin

        errors = 0;
        total_tests = 0;

        reset = 1;
        enable = 0;
        load = 0;
        load_addr = 0;

        // TEST 1: RESET
        @(posedge clk);
        #1;
        check_pc(8'd0, "RESET");

        // TEST 2: INCREMENT 1
        @(negedge clk);
        reset = 0;
        enable = 1;

        @(posedge clk);
        #1;
        check_pc(8'd1, "INCREMENT 1");

        // TEST 3: INCREMENT 2
        @(posedge clk);
        #1;
        check_pc(8'd2, "INCREMENT 2");

        // TEST 4: HOLD
        @(negedge clk);
        enable = 0;

        @(posedge clk);
        #1;
        check_pc(8'd2, "HOLD");

        // TEST 5: LOAD
        @(negedge clk);
        load = 1;
        load_addr = 8'd20;

        @(posedge clk);
        #1;
        check_pc(8'd20, "LOAD");

        // TEST 6: INCREMENT AFTER LOAD
        @(negedge clk);
        load = 0;
        enable = 1;

        @(posedge clk);
        #1;
        check_pc(8'd21, "INCREMENT AFTER LOAD");

        // TEST 7: LOAD PRIORITY OVER ENABLE
        @(negedge clk);
        load = 1;
        enable = 1;
        load_addr = 8'd64;

        @(posedge clk);
        #1;
        check_pc(8'd64, "LOAD PRIORITY");

        // TEST 8: RESET PRIORITY OVER LOAD
        @(negedge clk);
        reset = 1;
        load = 1;
        enable = 1;
        load_addr = 8'd100;

        @(posedge clk);
        #1;
        check_pc(8'd0, "RESET PRIORITY");

        // TEST 9: LOAD MAXIMUM VALUE
        @(negedge clk);
        reset = 0;
        load = 1;
        enable = 0;
        load_addr = 8'd255;

        @(posedge clk);
        #1;
        check_pc(8'd255, "LOAD 255");

        // TEST 10: OVERFLOW
        @(negedge clk);
        load = 0;
        enable = 1;

        @(posedge clk);
        #1;
        check_pc(8'd0, "OVERFLOW 255 TO 0");

        // FINAL REPORT
        $display("--------------------------------");
        $display("PROGRAM COUNTER TEST REPORT");
        $display("Total Tests  : %0d", total_tests);
        $display("Passed Tests : %0d", total_tests-errors);
        $display("Failed Tests : %0d", errors);
        $display("--------------------------------");

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TEST FAILED");

        $finish;

    end

endmodule
`endif // __ICARUS__
