simulate:
    iverilog -o sim.out src/counter_32bit.v testbench/tb_counter_32bit.v
    vvp sim.out
    gtkwave waveform.vcd &
