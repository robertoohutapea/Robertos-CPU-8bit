// New Verilog file


module alu_8bit_tb;

reg [7:0] A;
reg [7:0] B;
reg [2:0] opcode;

wire [7:0] result;
wire zero;

alu_8bit uut (
    .A(A),
    .B(B),
    .opcode(opcode),
    .result(result),
    .zero(zero)
);

initial begin

    // Test ADD
    A = 10;
    B = 5;
    opcode = 3'b000;
    #10;
    $display("ADD: %d", result);

    // Test SUB
    opcode = 3'b001;
    #10;
    $display("SUB: %d", result);

    // Test AND
    opcode = 3'b010;
    #10;
    $display("AND: %d", result);

    // Test OR
    opcode = 3'b011;
    #10;
    $display("OR: %d", result);

    // Test XOR
    opcode = 3'b100;
    #10;
    $display("XOR: %d", result);

    // Test NOT
    opcode = 3'b101;
    #10;
    $display("NOT: %d", result);

    $finish;

end

endmodule
