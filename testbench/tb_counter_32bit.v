module tb_counter_32bit;

    // Testbench signals
    reg clk;              // Clock signal
    reg reset;            // Reset signal
    reg enable;           // Enable signal
    /* verilator lint_off UNUSEDSIGNAL */
    wire [31:0] count;    // 32-bit count output
    wire overflow;        // Overflow flag output
    /* verilator lint_off UNUSEDSIGNAL */
    // Instantiate the 32-bit counter
    counter_32bit uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count),
        .overflow(overflow)
    );

    // Clock generation (50 MHz clock)
    always begin
        #5 clk <= ~clk; // Toggle clock every 5 time units
    end

    // Test procedure
    initial begin
        // Initialize the signals
        clk = 0;
        reset = 0;
        enable = 0;

        // Apply reset
        reset = 1; #10;  // Apply reset for 10 time units
        reset = 0; #10;  // Release reset

        // Enable the counter and run through values
        enable = 1; #10;
        // Observe counting

        // Run the counter for some cycles
        #200;

        // Disable the counter and observe it not counting
        enable = 0; #20;

        // Enable again and check overflow
        enable = 1; #10;

        // Let it reach overflow
        repeat (100000) #5;  // Run enough cycles to hit overflow

        // Finish the simulation
        $finish;
    end
    initial
    begin
            $dumpfile("counter.vcd");
            $dumpvars(0, decade_counter_tb);
    end
    initial
            #1400 $finish;

endmodule

