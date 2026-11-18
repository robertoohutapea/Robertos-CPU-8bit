`timescale 1ns/1ps

module instruction_decoder (
    input wire [15:0] instruction,

    output wire [3:0] opcode,
    output wire [1:0] rd,
    output wire [1:0] ra,
    output wire [1:0] rb,
    output wire [7:0] immediate
);

    assign opcode    = instruction[15:12];
    assign rd        = instruction[11:10];
    assign ra        = instruction[9:8];
    assign rb        = instruction[7:6];
    assign immediate = instruction[7:0];

endmodule
