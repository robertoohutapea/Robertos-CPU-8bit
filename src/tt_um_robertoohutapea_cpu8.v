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

    // --------------------------------
    // CPU SIGNALS
    // --------------------------------

    wire cpu_halted;
    wire [7:0] cpu_pc;

    wire cpu_reset;

    // External reset is active-low
    assign cpu_reset = ~rst_n;

    // --------------------------------
    // CPU CORE
    // --------------------------------

    cpu_8bit cpu_inst (
        .clk(clk),
        .reset(cpu_reset),
        .enable(ena),

        .halted(cpu_halted),
        .pc(cpu_pc)
    );

    // --------------------------------
    // OUTPUT INTERFACE
    // --------------------------------

    // Program Counter on output pins
    assign uo_out = cpu_pc;

    // HALT status on bidirectional pin 0
    assign uio_out = {
        7'b0000000,
        cpu_halted
    };

    // Only bidirectional pin 0 is driven
    assign uio_oe = 8'b00000001;

    // ui_in and uio_in are reserved for
    // future external CPU control/debug features.

endmodule
