`timescale 1ns/1ps

module instruction_memory_tb;

    reg [7:0] address;
    wire [15:0] instruction;

    integer errors;
    integer total_tests;

    instruction_memory uut (
        .address(address),
        .instruction(instruction)
    );

    initial begin

        errors = 0;
        total_tests = 0;

        address = 0;
        #1;
        total_tests = total_tests + 1;
        if (instruction !== 16'h800A) begin
            $display("FAIL: INST 0");
            errors = errors + 1;
        end
        else $display("PASS: INST 0");

        address = 1;
        #1;
        total_tests = total_tests + 1;
        if (instruction !== 16'h8405) begin
            $display("FAIL: INST 1");
            errors = errors + 1;
        end
        else $display("PASS: INST 1");

        address = 2;
        #1;
        total_tests = total_tests + 1;
        if (instruction !== 16'h1840) begin
            $display("FAIL: INST 2");
            errors = errors + 1;
        end
        else $display("PASS: INST 2");

        address = 3;
        #1;
        total_tests = total_tests + 1;
        if (instruction !== 16'hA810) begin
            $display("FAIL: INST 3");
            errors = errors + 1;
        end
        else $display("PASS: INST 3");

        address = 4;
        #1;
        total_tests = total_tests + 1;
        if (instruction !== 16'h9C10) begin
            $display("FAIL: INST 4");
            errors = errors + 1;
        end
        else $display("PASS: INST 4");

        address = 5;
        #1;
        total_tests = total_tests + 1;
        if (instruction !== 16'hF000) begin
            $display("FAIL: INST 5");
            errors = errors + 1;
        end
        else $display("PASS: INST 5");

        $display("--------------------------------");
        $display("INSTRUCTION MEMORY TEST REPORT");
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
