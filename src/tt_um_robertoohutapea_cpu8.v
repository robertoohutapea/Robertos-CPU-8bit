
`default_nettype none
`timescale 1ns/1ps

module tt_um_robertoohutapea_cpu8 (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,

    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,

    input  wire ena,
    input  wire clk,
    input  wire rst_n
);

    wire cpu_halted;
    wire [7:0] cpu_pc;

    // Convert active-low external reset
    // to active-high CPU reset
    wire cpu_reset = ~rst_n;

    // CPU core
    cpu_8bit cpu_inst (
        .clk(clk),
        .reset(cpu_reset),
        .halted(cpu_halted),
        .pc(cpu_pc)
    );

    // Show Program Counter on dedicated outputs
    assign uo_out = cpu_pc;

    // Show HALT status on bidirectional pin 0
    assign uio_out = {7'b0000000, cpu_halted};
    assign uio_oe  = 8'b00000001;

    // Unused input pins and enable signal
    wire unused_signals = &{
        ena,
        ui_in,
        uio_in,
        1'b0
    };

endmodule

`default_nettype wire
