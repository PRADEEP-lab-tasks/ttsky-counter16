<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

# Project Information

## How it works
This design implements a simple 16-bit counter with an enable input. When the enable signal is high, the counter increments on each clock cycle. The lower 8 bits of the counter are mapped to the output pins, allowing external observation of the count value. The design is written in Verilog and synthesized using the Sky130 PDK.

## How to test
1. Provide a clock signal to the `clk` input.
2. Set the `enable` input high to allow counting.
3. Observe the outputs `uo[0]` through `uo[7]` which represent the least significant 8 bits of the counter.
4. Verify that the outputs increment correctly with each clock cycle when enable is active, and remain constant when enable is low.

## Additional notes
- The design uses a synchronous reset to initialize the counter.
- Pin mapping is defined in `info.yaml`.
