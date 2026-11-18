`timescale 1ns/1ps

module instruction_memory (
    input wire [7:0] address,
    output reg [15:0] instruction
);

    always @(*) begin
        case (address)

            // Demo program
            8'd0: instruction = 16'h800A; // LDI R0, 10
            8'd1: instruction = 16'h8405; // LDI R1, 5
            8'd2: instruction = 16'h1840; // ADD R2, R0, R1
            8'd3: instruction = 16'hA810; // STORE R2, 0x10
            8'd4: instruction = 16'h9C10; // LOAD R3, 0x10
            8'd5: instruction = 16'hF000; // HALT

            // Default NOP
            default: instruction = 16'h0000;

        endcase
    end

endmodule
