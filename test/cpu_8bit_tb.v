`ifndef SYNTHESIS
`timescale 1ns/1ps

module cpu_8bit_tb;

    reg clk;
    reg reset;

    wire halted;
    wire [7:0] pc;

    integer errors;
    integer total_tests;

    // CPU instantiation
    cpu_8bit uut (
        .clk(clk),
        .reset(reset),
        .halted(halted),
        .pc(pc)
    );

    // Clock generator: 10 ns period
    initial clk = 0;
    always #5 clk = ~clk;

    // VCD waveform generation
    initial begin
        $dumpfile("cpu_8bit.vcd");
        $dumpvars(0, cpu_8bit_tb);
    end

    // Test result checker
    task check_value;
        input [7:0] actual;
        input [7:0] expected;
        input [200*8:1] test_name;
        begin
            total_tests = total_tests + 1;

            if (actual !== expected) begin
                $display(
                    "FAIL: %0s | Expected=%0d Actual=%0d",
                    test_name, expected, actual
                );
                errors = errors + 1;
            end
            else begin
                $display(
                    "PASS: %0s | Value=%0d",
                    test_name, actual
                );
            end
        end
    endtask

    initial begin

        errors = 0;
        total_tests = 0;

        reset = 1;

        // Apply synchronous reset
        @(posedge clk);
        #1;
        reset = 0;

        // Execute demo program
        repeat (8) begin
            @(posedge clk);
        end

        #1;

        // TEST 1: R0 = 10
        check_value(
            uut.regfile_inst.R0,
            8'd10,
            "CPU LDI R0"
        );

        // TEST 2: R1 = 5
        check_value(
            uut.regfile_inst.R1,
            8'd5,
            "CPU LDI R1"
        );

        // TEST 3: R2 = 15
        check_value(
            uut.regfile_inst.R2,
            8'd15,
            "CPU ADD"
        );

        // TEST 4: MEMORY[0x10] = 15
        check_value(
            uut.data_memory_inst.memory[8'h10],
            8'd15,
            "CPU STORE"
        );

        // TEST 5: R3 = 15
        check_value(
            uut.regfile_inst.R3,
            8'd15,
            "CPU LOAD"
        );

        // TEST 6: HALTED
        total_tests = total_tests + 1;

        if (halted !== 1'b1) begin
            $display("FAIL: CPU HALT");
            errors = errors + 1;
        end
        else begin
            $display("PASS: CPU HALT");
        end

        // FINAL REPORT
        $display("--------------------------------");
        $display("CPU 8-BIT INTEGRATION REPORT");
        $display("Total Tests  : %0d", total_tests);
        $display("Passed Tests : %0d", total_tests-errors);
        $display("Failed Tests : %0d", errors);
        $display("--------------------------------");

        if (errors == 0)
            $display("CPU ALL TESTS PASSED");
        else
            $display("CPU TEST FAILED");

        $finish;

    end

endmodule
`endif // SYNTHESIS
