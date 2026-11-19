`ifndef SYNTHESIS
`timescale 1ns/1ps

module register_file_tb;

    reg clk;
    reg reset;
    reg write_enable;

    reg [1:0] write_addr;
    reg [7:0] write_data;

    reg [1:0] read_addr_a;
    reg [1:0] read_addr_b;

    wire [7:0] read_data_a;
    wire [7:0] read_data_b;

    integer errors;
    integer total_tests;

    register_file uut (
        .clk(clk),
        .reset(reset),
        .write_enable(write_enable),
        .write_addr(write_addr),
        .write_data(write_data),
        .read_addr_a(read_addr_a),
        .read_addr_b(read_addr_b),
        .read_data_a(read_data_a),
        .read_data_b(read_data_b)
    );

    // Clock generator
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin

        errors = 0;
        total_tests = 0;

        reset = 1;
        write_enable = 0;
        write_addr = 0;
        write_data = 0;
        read_addr_a = 0;
        read_addr_b = 0;

        // TEST 1: RESET
        #10;
        reset = 0;

        read_addr_a = 0;
        read_addr_b = 1;
        #1;

        total_tests = total_tests + 1;

        if (read_data_a !== 8'd0 ||
            read_data_b !== 8'd0) begin
            $display("FAIL: RESET");
            errors = errors + 1;
        end
        else begin
            $display("PASS: RESET");
        end

        // WRITE R0 = 10
        write_enable = 1;
        write_addr = 0;
        write_data = 8'd10;
        #10;

        // WRITE R1 = 5
        write_addr = 1;
        write_data = 8'd5;
        #10;

        // WRITE R2 = 165
        write_addr = 2;
        write_data = 8'd165;
        #10;

        // WRITE R3 = 255
        write_addr = 3;
        write_data = 8'd255;
        #10;

        write_enable = 0;

        // TEST 2: READ R0
        read_addr_a = 0;
        #1;
        total_tests = total_tests + 1;

        if (read_data_a !== 8'd10) begin
            $display("FAIL: R0 | Expected=10 Actual=%0d",
                     read_data_a);
            errors = errors + 1;
        end
        else
            $display("PASS: R0 = %0d", read_data_a);

        // TEST 3: READ R1
        read_addr_a = 1;
        #1;
        total_tests = total_tests + 1;

        if (read_data_a !== 8'd5) begin
            $display("FAIL: R1 | Expected=5 Actual=%0d",
                     read_data_a);
            errors = errors + 1;
        end
        else
            $display("PASS: R1 = %0d", read_data_a);

        // TEST 4: READ R2
        read_addr_a = 2;
        #1;
        total_tests = total_tests + 1;

        if (read_data_a !== 8'd165) begin
            $display("FAIL: R2 | Expected=165 Actual=%0d",
                     read_data_a);
            errors = errors + 1;
        end
        else
            $display("PASS: R2 = %0d", read_data_a);

        // TEST 5: READ R3
        read_addr_a = 3;
        #1;
        total_tests = total_tests + 1;

        if (read_data_a !== 8'd255) begin
            $display("FAIL: R3 | Expected=255 Actual=%0d",
                     read_data_a);
            errors = errors + 1;
        end
        else
            $display("PASS: R3 = %0d", read_data_a);

        // TEST 6: DUAL READ
        read_addr_a = 0;
        read_addr_b = 3;
        #1;
        total_tests = total_tests + 1;

        if (read_data_a !== 8'd10 ||
            read_data_b !== 8'd255) begin
            $display("FAIL: DUAL READ");
            errors = errors + 1;
        end
        else
            $display("PASS: DUAL READ");

        // TEST 7: WRITE PROTECTION
        write_enable = 0;
        write_addr = 0;
        write_data = 8'd99;
        #10;

        read_addr_a = 0;
        #1;
        total_tests = total_tests + 1;

        if (read_data_a !== 8'd10) begin
            $display("FAIL: WRITE PROTECTION");
            errors = errors + 1;
        end
        else
            $display("PASS: WRITE PROTECTION");

        // FINAL REPORT
        $display("--------------------------------");
        $display("REGISTER FILE TEST REPORT");
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
`endif // SYNTHESIS
