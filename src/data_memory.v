`timescale 1ns/1ps

module data_memory (
    input wire clk,
    input wire reset,

    input wire write_enable,
    input wire [7:0] address,
    input wire [7:0] write_data,

    output wire [7:0] read_data
);

    reg [7:0] memory [0:255];
    integer i;

    // Synchronous reset and write
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 256; i = i + 1) begin
                memory[i] <= 8'd0;
            end
        end
        else if (write_enable) begin
            memory[address] <= write_data;
        end
    end

    // Asynchronous read
    assign read_data = memory[address];

endmodule
