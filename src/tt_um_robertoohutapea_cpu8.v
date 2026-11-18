`timescale 1ns/1ps

module tt_um_robertoohutapea_cpu8 (
    input wire [7:0] ui_in,
    output wire [7:0] uo_out,

    input wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,

    input wire ena,
    input wire clk,
    input wire rst_n
);

    wire cpu_halted;
    wire [7:0] cpu_pc;
    wire cpu_reset;

    assign cpu_reset = ~rst_n;

    cpu_8bit cpu_inst (
        .clk(clk),
        .reset(cpu_reset),
        .halted(cpu_halted),
        .pc(cpu_pc)
    );

    assign uo_out = cpu_pc;

    assign uio_out = {
        7'b0000000,
        cpu_halted
    };

    assign uio_oe = 8'b00000001;

endmodule
