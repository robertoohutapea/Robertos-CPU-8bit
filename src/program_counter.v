
module program_counter (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire load,
    input wire [7:0] load_addr,
    output reg [7:0] pc
);

    always @(posedge clk) begin

        // Priority 1: RESET
        if (reset) begin
            pc <= 8'd0;
        end

        // Priority 2: LOAD
        else if (load) begin
            pc <= load_addr;
        end

        // Priority 3: INCREMENT
        else if (enable) begin
            pc <= pc + 8'd1;
        end

        // Priority 4: HOLD
        // No assignment means PC retains its value

    end

endmodule
