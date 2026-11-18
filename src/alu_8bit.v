
module alu_8bit (
    input wire [7:0] A,
    input wire [7:0] B,
    input wire [2:0] opcode,
    output reg [7:0] result,
    output wire zero
);

    always @(*) begin
        case (opcode)

            // Arithmetic Operations
            3'b000: result = A + B; 

            3'b001: result = A - B;

            // Logical Operations
            3'b010: result = A & B;

            3'b011: result = A | B;

            3'b100: result = A ^ B;

            3'b101: result = ~A;

            // Undefined Opcode
            default: result = 8'd0;

        endcase
    end

    // Zero Flag
    assign zero = (result == 8'd0);

endmodule
