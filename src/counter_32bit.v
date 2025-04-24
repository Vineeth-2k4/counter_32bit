module counter_32bit (
    input clk,            // Clock input
    input reset,          // Reset input (active high)
    input enable,         // Enable input (active high)
    output reg [31:0] count,  // 32-bit count output
    output reg overflow   // Overflow flag output
);

    // On each rising edge of clock
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // If reset is high, reset the count to 0 and overflow to 0
            count <= 32'b0;
            overflow <= 0;
        end else if (enable) begin
            // If enable is high, increment the count
            if (count == 32'b11111111111111111111111111111111) begin
                // If count reaches the maximum 32-bit value (overflow condition)
                count <= 32'b0;  // Wrap around to 0
                overflow <= 1;    // Set the overflow flag
            end else begin
                count <= count + 1;  // Increment the count
                overflow <= 0;        // No overflow
            end
        end
    end

endmodule

