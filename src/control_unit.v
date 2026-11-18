`timescale 1ns/1ps

module control_unit (
    input wire [3:0] opcode,

    output reg reg_write,
    output reg alu_src_imm,
    output reg mem_read,
    output reg mem_write,
    output reg mem_to_reg,
    output reg imm_to_reg,
    output reg pc_jump,
    output reg halt,

    output reg [2:0] alu_control
);

    always @(*) begin

        // Default control signals
        reg_write   = 1'b0;
        alu_src_imm = 1'b0;
        mem_read    = 1'b0;
        mem_write   = 1'b0;
        mem_to_reg  = 1'b0;
        imm_to_reg  = 1'b0;
        pc_jump     = 1'b0;
        halt        = 1'b0;
        alu_control = 3'b000;

        case (opcode)

            // ADD
            4'h1: begin
                reg_write = 1'b1;
                alu_control = 3'b000;
            end

            // SUB
            4'h2: begin
                reg_write = 1'b1;
                alu_control = 3'b001;
            end

            // AND
            4'h3: begin
                reg_write = 1'b1;
                alu_control = 3'b010;
            end

            // OR
            4'h4: begin
                reg_write = 1'b1;
                alu_control = 3'b011;
            end

            // XOR
            4'h5: begin
                reg_write = 1'b1;
                alu_control = 3'b100;
            end

            // NOT
            4'h6: begin
                reg_write = 1'b1;
                alu_control = 3'b101;
            end

            // ADDI
            4'h7: begin
                reg_write = 1'b1;
                alu_src_imm = 1'b1;
                alu_control = 3'b000;
            end

            // LDI
            4'h8: begin
                reg_write = 1'b1;
                imm_to_reg = 1'b1;
            end

            // LOAD
            4'h9: begin
                reg_write = 1'b1;
                mem_read = 1'b1;
                mem_to_reg = 1'b1;
            end

            // STORE
            4'hA: begin
                mem_write = 1'b1;
            end

            // JMP
            4'hB: begin
                pc_jump = 1'b1;
            end

            // HALT
            4'hF: begin
                halt = 1'b1;
            end

            // NOP / Undefined
            default: begin
                // Keep default control signals
            end

        endcase
    end

endmodule
