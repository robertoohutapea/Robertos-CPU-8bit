// New Verilog file



module register_file (
    input wire clk,
    input wire reset,

    // Write interface
    input wire write_enable,
    input wire [1:0] write_addr,
    input wire [7:0] write_data,

    // Read interface
    input wire [1:0] read_addr_a,
    input wire [1:0] read_addr_b,

    // Read outputs
    output wire [7:0] read_data_a,
    output wire [7:0] read_data_b
);

    // Four 8-bit registers: R0, R1, R2, R3
    reg [7:0] registers [0:3];

    // Synchronous reset and write operation
    always @(posedge clk) begin

        if (reset) begin
            registers[0] &lt;= 8'b00000000;
            registers[1] &lt;= 8'b00000000;
            registers[2] &lt;= 8'b00000000;
            registers[3] &lt;= 8'b00000000;
        end

        else if (write_enable) begin
            registers[write_addr] &lt;= write_data;
        end

    end

    // Asynchronous read port A
    assign read_data_a = registers[read_addr_a];

    // Asynchronous read port B
    assign read_data_b = registers[read_addr_b];

endmodule
