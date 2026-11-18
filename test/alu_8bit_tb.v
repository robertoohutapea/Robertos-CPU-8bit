
`timescale 1ns/1ps

module alu_8bit_tb;

    reg [7:0] A;
    reg [7:0] B;
    reg [2:0] opcode;

    wire [7:0] result;
    wire zero;

    integer errors;
    integer total_tests;

    alu_8bit uut (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(result),
        .zero(zero)
    );

    task check_result;
        input [7:0] expected;
        input expected_zero;
        input [200*8:1] test_name;

        begin
            total_tests = total_tests + 1;

            if (result !== expected || zero !== expected_zero) begin
                $display(
                    "FAIL: %0s | Expected=%0d Actual=%0d Zero=%b",
                    test_name, expected, result, zero
                );
                errors = errors + 1;
            end
            else begin
                $display(
                    "PASS: %0s | Result=%0d Zero=%b",
                    test_name, result, zero
                );
            end
        end
    endtask

    initial begin

        errors = 0;
        total_tests = 0;

        // TEST 1: ADD
        A = 8'd10;
        B = 8'd5;
        opcode = 3'b000;
        #10;
        check_result(8'd15, 1'b0, "ADD");

        // TEST 2: SUB
        A = 8'd10;
        B = 8'd5;
        opcode = 3'b001;
        #10;
        check_result(8'd5, 1'b0, "SUB");

        // TEST 3: AND
        A = 8'b11110000;
        B = 8'b10101010;
        opcode = 3'b010;
        #10;
        check_result(8'b10100000, 1'b0, "AND");

        // TEST 4: OR
        A = 8'b11110000;
        B = 8'b00001111;
        opcode = 3'b011;
        #10;
        check_result(8'b11111111, 1'b0, "OR");

        // TEST 5: XOR
        A = 8'b11110000;
        B = 8'b10101010;
        opcode = 3'b100;
        #10;
        check_result(8'b01011010, 1'b0, "XOR");

        // TEST 6: NOT
        A = 8'b11110000;
        B = 8'd0;
        opcode = 3'b101;
        #10;
        check_result(8'b00001111, 1'b0, "NOT");

        // TEST 7: ZERO FLAG
        A = 8'd10;
        B = 8'd10;
        opcode = 3'b001;
        #10;
        check_result(8'd0, 1'b1, "ZERO FLAG");

        // TEST 8: ADD OVERFLOW
        A = 8'd255;
        B = 8'd1;
        opcode = 3'b000;
        #10;
        check_result(8'd0, 1'b1, "ADD OVERFLOW");

        // TEST 9: SUB UNDERFLOW
        A = 8'd0;
        B = 8'd1;
        opcode = 3'b001;
        #10;
        check_result(8'd255, 1'b0, "SUB UNDERFLOW");

        // TEST 10: INVALID OPCODE
        A = 8'd10;
        B = 8'd5;
        opcode = 3'b110;
        #10;
        check_result(8'd0, 1'b1, "INVALID OPCODE");

        // FINAL REPORT
        $display("--------------------------------");
        $display("ALU 8-BIT TEST REPORT");
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
