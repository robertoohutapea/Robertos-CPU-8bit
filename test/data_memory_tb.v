`ifdef __ICARUS__
`timescale 1ns/1ps

module data_memory_tb;

    reg clk;
    reg reset;
    reg write_enable;

    reg [7:0] address;
    reg [7:0] write_data;

    wire [7:0] read_data;

    integer errors;
    integer total_tests;

    data_memory uut (
        .clk(clk),
        .reset(reset),
        .write_enable(write_enable),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin

        errors = 0;
        total_tests = 0;

        reset = 1;
        write_enable = 0;
        address = 0;
        write_data = 0;

        // RESET
        #10;
        reset = 0;

        // TEST 1: WRITE
        write_enable = 1;
        address = 8'h10;
        write_data = 8'd165;

        #10;

        // TEST 2: READ
        write_enable = 0;
        address = 8'h10;

        #1;
        total_tests = total_tests + 1;

        if (read_data !== 8'd165) begin
            $display("FAIL: MEMORY READ");
            errors = errors + 1;
        end
        else begin
            $display("PASS: MEMORY READ");
        end

        // TEST 3: WRITE PROTECTION
        write_enable = 0;
        address = 8'h10;
        write_data = 8'd99;

        #10;

        #1;
        total_tests = total_tests + 1;

        if (read_data !== 8'd165) begin
            $display("FAIL: MEMORY WRITE PROTECTION");
            errors = errors + 1;
        end
        else begin
            $display("PASS: MEMORY WRITE PROTECTION");
        end

        // TEST 4: RESET MEMORY
        reset = 1;

        @(posedge clk);
        #1;

        reset = 0;
        address = 8'h10;
        #1;

        total_tests = total_tests + 1;

        if (read_data !== 8'd0) begin
            $display("FAIL: MEMORY RESET");
            errors = errors + 1;
        end
        else begin
            $display("PASS: MEMORY RESET");
        end

        $display("--------------------------------");
        $display("DATA MEMORY TEST REPORT");
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
