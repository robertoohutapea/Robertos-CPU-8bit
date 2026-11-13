// New Verilog file


module register_file_tb;

reg clk;
reg reset;
reg write_enable;

reg [1:0] write_addr;
reg [7:0] write_data;

reg [1:0] read_addr_a;
reg [1:0] read_addr_b;

wire [7:0] read_data_a;
wire [7:0] read_data_b;

register_file uut (
    .clk(clk),
    .reset(reset),
    .write_enable(write_enable),
    .write_addr(write_addr),
    .write_data(write_data),
    .read_addr_a(read_addr_a),
    .read_addr_b(read_addr_b),
    .read_data_a(read_data_a),
    .read_data_b(read_data_b)
);

// Clock generator
initial clk = 0;
always #5 clk = ~clk;

initial begin

    reset = 1;
    write_enable = 0;
    write_addr = 0;
    write_data = 0;
    read_addr_a = 0;
    read_addr_b = 0;

    #10;
    reset = 0;

    // Write R0 = 10
    write_enable = 1;
    write_addr = 0;
    write_data = 8'd10;
    #10;

    // Write R1 = 5
    write_addr = 1;
    write_data = 8'd5;
    #10;

    // Write R2 = 165
    write_addr = 2;
    write_data = 8'd165;
    #10;

    // Write R3 = 255
    write_addr = 3;
    write_data = 8'd255;
    #10;

    write_enable = 0;

    // Read R0 and R1
    read_addr_a = 0;
    read_addr_b = 1;
    #1;

    $display("R0 = %d", read_data_a);
    $display("R1 = %d", read_data_b);

    // Read R2 and R3
    read_addr_a = 2;
    read_addr_b = 3;
    #1;

    $display("R2 = %d", read_data_a);
    $display("R3 = %d", read_data_b);

    $finish;

end

endmodule
