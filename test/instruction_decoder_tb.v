`ifndef SYNTHESIS
`timescale 1ns/1ps

module instruction_decoder_tb;

    reg [15:0] instruction;

    wire [3:0] opcode;
    wire [1:0] rd;
    wire [1:0] ra;
    wire [1:0] rb;
    wire [7:0] immediate;

    integer errors;
    integer total_tests;

    instruction_decoder uut (
        .instruction(instruction),
        .opcode(opcode),
        .rd(rd),
        .ra(ra),
        .rb(rb),
        .immediate(immediate)
    );

    initial begin

        errors = 0;
        total_tests = 0;

        // TEST 1: ADD R2, R0, R1
        instruction = 16'h1840;
        #1;

        total_tests = total_tests + 1;

        if (opcode !== 4'h1 ||
            rd !== 2'd2 ||
            ra !== 2'd0 ||
            rb !== 2'd1) begin

            $display("FAIL: DECODE ADD");
            errors = errors + 1;
        end
        else
            $display("PASS: DECODE ADD");

        // TEST 2: STORE R2, 0x10
        instruction = 16'hA810;
        #1;

        total_tests = total_tests + 1;

        if (opcode !== 4'hA ||
            rd !== 2'd2 ||
            immediate !== 8'h10) begin

            $display("FAIL: DECODE STORE");
            errors = errors + 1;
        end
        else
            $display("PASS: DECODE STORE");

        // TEST 3: LOAD R3, 0x10
        instruction = 16'h9C10;
        #1;

        total_tests = total_tests + 1;

        if (opcode !== 4'h9 ||
            rd !== 2'd3 ||
            immediate !== 8'h10) begin

            $display("FAIL: DECODE LOAD");
            errors = errors + 1;
        end
        else
            $display("PASS: DECODE LOAD");

        // TEST 4: HALT
        instruction = 16'hF000;
        #1;

        total_tests = total_tests + 1;

        if (opcode !== 4'hF) begin
            $display("FAIL: DECODE HALT");
            errors = errors + 1;
        end
        else
            $display("PASS: DECODE HALT");

        // FINAL REPORT
        $display("--------------------------------");
        $display("INSTRUCTION DECODER TEST REPORT");
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
