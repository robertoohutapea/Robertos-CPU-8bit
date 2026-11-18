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

        // ADD
        opcode = 4'h1;
        #1;
        check_control(11'b10000000000, "ADD");

        // SUB
        opcode = 4'h2;
        #1;
        check_control(11'b10000000001, "SUB");

        // ADDI
        opcode = 4'h7;
        #1;
        check_control(11'b11000000000, "ADDI");

        // LDI
        opcode = 4'h8;
        #1;
        check_control(11'b10000100000, "LDI");

        // LOAD
        opcode = 4'h9;
        #1;
        check_control(11'b10100100000, "LOAD");

        // STORE
        opcode = 4'hA;
        #1;
        check_control(11'b00010000000, "STORE");

        // JMP
        opcode = 4'hB;
        #1;
        check_control(11'b00000010000, "JMP");

        // HALT
        opcode = 4'hF;
        #1;
        check_control(11'b00000001000, "HALT");

        // NOP
        opcode = 4'h0;
        #1;
        check_control(11'b00000000000, "NOP");

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
