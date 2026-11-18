`timescale 1ns/1ps

module program_counter (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire load,
    input wire [7:0] load_addr,
    output reg [7:0] pc
);

    always @(posedge clk) begin
        if (reset) begin
            pc <= 8'd0;
        end
        else if (load) begin
            pc <= load_addr;
        end
        else if (enable) begin
            pc <= pc + 8'd1;
        end
    end

endmodule
