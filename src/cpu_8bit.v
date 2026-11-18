`timescale 1ns/1ps

module cpu_8bit (
    input wire clk,
    input wire reset,

    output reg halted,
    output wire [7:0] pc
);

    // Instruction signals
    wire [15:0] instruction;
    wire [3:0] opcode;
    wire [1:0] rd;
    wire [1:0] ra;
    wire [1:0] rb;
    wire [7:0] immediate;

    // Control signals
    wire reg_write;
    wire alu_src_imm;
    wire mem_read;
    wire mem_write;
    wire mem_to_reg;
    wire imm_to_reg;
    wire pc_jump;
    wire halt_instruction;
    wire [2:0] alu_control;

    // Register File signals
    wire [7:0] read_data_a;
    wire [7:0] read_data_b;
    wire [1:0] register_read_addr_b;
    wire [7:0] writeback_data;

    // ALU signals
    wire [7:0] alu_b;
    wire [7:0] alu_result;
    wire alu_zero;

    // Data Memory signals
    wire [7:0] memory_read_data;

    // Program Counter controls
    wire pc_enable;
    wire pc_load;

    // --------------------------------
    // PROGRAM COUNTER
    // --------------------------------

    assign pc_enable = !halted && !halt_instruction;
    assign pc_load = pc_jump && !halted;

    program_counter pc_inst (
        .clk(clk),
        .reset(reset),
        .enable(pc_enable),
        .load(pc_load),
        .load_addr(immediate),
        .pc(pc)
    );

    // --------------------------------
    // INSTRUCTION MEMORY
    // --------------------------------

    instruction_memory instruction_memory_inst (
        .address(pc),
        .instruction(instruction)
    );

    // --------------------------------
    // INSTRUCTION DECODER
    // --------------------------------

    instruction_decoder decoder_inst (
        .instruction(instruction),
        .opcode(opcode),
        .rd(rd),
        .ra(ra),
        .rb(rb),
        .immediate(immediate)
    );

    // --------------------------------
    // CONTROL UNIT
    // --------------------------------

    control_unit control_inst (
        .opcode(opcode),
        .reg_write(reg_write),
        .alu_src_imm(alu_src_imm),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .imm_to_reg(imm_to_reg),
        .pc_jump(pc_jump),
        .halt(halt_instruction),
        .alu_control(alu_control)
    );

    // --------------------------------
    // REGISTER FILE
    // --------------------------------

    // STORE uses RD as its source register.
    assign register_read_addr_b =
        (opcode == 4'hA) ? rd : rb;

    register_file regfile_inst (
        .clk(clk),
        .reset(reset),
        .write_enable(reg_write && !halted),
        .write_addr(rd),
        .write_data(writeback_data),
        .read_addr_a(ra),
        .read_addr_b(register_read_addr_b),
        .read_data_a(read_data_a),
        .read_data_b(read_data_b)
    );

    // --------------------------------
    // ALU
    // --------------------------------

    assign alu_b = alu_src_imm ? immediate : read_data_b;

    alu_8bit alu_inst (
        .A(read_data_a),
        .B(alu_b),
        .opcode(alu_control),
        .result(alu_result),
        .zero(alu_zero)
    );

    // --------------------------------
    // DATA MEMORY
    // --------------------------------

    data_memory data_memory_inst (
        .clk(clk),
        .reset(reset),
        .write_enable(mem_write && !halted),
        .address(immediate),
        .write_data(read_data_b),
        .read_data(memory_read_data)
    );

    // --------------------------------
    // WRITE BACK MUX
    // --------------------------------

    assign writeback_data =
        imm_to_reg ? immediate :
        mem_to_reg ? memory_read_data :
        alu_result;

    // --------------------------------
    // HALT CONTROL
    // --------------------------------

    always @(posedge clk) begin
        if (reset) begin
            halted <= 1'b0;
        end
        else if (halt_instruction) begin
            halted <= 1'b1;
        end
    end

endmodule
