`ifdef __ICARUS__
`timescale 1ns/1ps

module control_unit_tb;

    reg [3:0] opcode;

    wire reg_write;
    wire alu_src_imm;
    wire mem_read;
    wire mem_write;
    wire mem_to_reg;
    wire imm_to_reg;
    wire pc_jump;
    wire halt;
    wire [2:0] alu_control;

    integer errors;
    integer total_tests;

    control_unit uut (
        .opcode(opcode),
        .reg_write(reg_write),
        .alu_src_imm(alu_src_imm),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .imm_to_reg(imm_to_reg),
        .pc_jump(pc_jump),
        .halt(halt),
        .alu_control(alu_control)
    );

    task check_control;
        input [10:0] expected;
        input [200*8:1] test_name;

        begin
            total_tests = total_tests + 1;

            if ({
                reg_write,
                alu_src_imm,
                mem_read,
                mem_write,
                mem_to_reg,
                imm_to_reg,
                pc_jump,
                halt,
                alu_control
            } !== expected) begin

                $display("FAIL: %0s", test_name);
                $display("Expected: %b", expected);
                $display("Actual  : %b", {
                    reg_write,
                    alu_src_imm,
                    mem_read,
                    mem_write,
                    mem_to_reg,
                    imm_to_reg,
                    pc_jump,
                    halt,
                    alu_control
                });

                errors = errors + 1;
            end
            else begin
                $display("PASS: %0s", test_name);
            end
        end
    endtask

    initial begin

        errors = 0;
        total_tests = 0;

        // TEST 1: NOP
        opcode = 4'h0;
        #1;
        check_control(11'b00000000000, "NOP");

        // TEST 2: ADD
        opcode = 4'h1;
        #1;
        check_control(11'b10000000000, "ADD");

        // TEST 3: SUB
        opcode = 4'h2;
        #1;
        check_control(11'b10000000001, "SUB");

        // TEST 4: AND
        opcode = 4'h3;
        #1;
        check_control(11'b10000000010, "AND");

        // TEST 5: OR
        opcode = 4'h4;
        #1;
        check_control(11'b10000000011, "OR");

        // TEST 6: XOR
        opcode = 4'h5;
        #1;
        check_control(11'b10000000100, "XOR");

        // TEST 7: NOT
        opcode = 4'h6;
        #1;
        check_control(11'b10000000101, "NOT");

        // TEST 8: ADDI
        opcode = 4'h7;
        #1;
        check_control(11'b11000000000, "ADDI");

        // TEST 9: LDI
        opcode = 4'h8;
        #1;
        check_control(11'b10000100000, "LDI");

        // TEST 10: LOAD
        opcode = 4'h9;
        #1;
        check_control(11'b10101000000, "LOAD");

        // TEST 11: STORE
        opcode = 4'hA;
        #1;
        check_control(11'b00010000000, "STORE");

        // TEST 12: JMP
        opcode = 4'hB;
        #1;
        check_control(11'b00000010000, "JMP");

        // TEST 13: HALT
        opcode = 4'hF;
        #1;
        check_control(11'b00000001000, "HALT");

        // FINAL REPORT
        $display("--------------------------------");
        $display("CONTROL UNIT TEST REPORT");
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
