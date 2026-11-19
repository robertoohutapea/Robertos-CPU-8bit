`timescale 1ns/1ps

module data_memory (
    input wire clk,
    input wire reset,

    input wire write_enable,
    input wire [7:0] address,
    input wire [7:0] write_data,

    output wire [7:0] read_data
);

    // 256 locations, each 8 bits wide
    reg [7:0] memory [0:255];

    // Tracks whether each memory location contains valid data
    reg [255:0] valid;

    // Synchronous reset and memory write
    always @(posedge clk) begin
        if (reset) begin
            valid <= 256'b0;
        end
        else if (write_enable) begin
            memory[address] <= write_data;
            valid[address] <= 1'b1;
        end
    end

    // Asynchronous read with valid-bit checking
    assign read_data = valid[address]
                     ? memory[address]
                     : 8'd0;

endmodule
