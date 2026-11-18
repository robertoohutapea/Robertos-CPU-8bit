
module register_file (
    input wire clk,
    input wire reset,

    input wire write_enable,
    input wire [1:0] write_addr,
    input wire [7:0] write_data,

    input wire [1:0] read_addr_a,
    input wire [1:0] read_addr_b,

    output wire [7:0] read_data_a,
    output wire [7:0] read_data_b
);

    // Four 8-bit registers
    reg [7:0] R0;
    reg [7:0] R1;
    reg [7:0] R2;
    reg [7:0] R3;

    // Synchronous reset and write
    always @(posedge clk) begin
        if (reset) begin
            R0 &lt;= 8'd0;
            R1 &lt;= 8'd0;
            R2 &lt;= 8'd0;
            R3 &lt;= 8'd0;
        end
        else if (write_enable) begin
            case (write_addr)
                2'b00: R0 &lt;= write_data;
                2'b01: R1 &lt;= write_data;
                2'b10: R2 &lt;= write_data;
                2'b11: R3 &lt;= write_data;
            endcase
        end
    end

    // Asynchronous read port A
    assign read_data_a =
        (read_addr_a == 2'b00) ? R0 :
        (read_addr_a == 2'b01) ? R1 :
        (read_addr_a == 2'b10) ? R2 : R3;

    // Asynchronous read port B
    assign read_data_b =
        (read_addr_b == 2'b00) ? R0 :
        (read_addr_b == 2'b01) ? R1 :
        (read_addr_b == 2'b10) ? R2 : R3;

endmodule
