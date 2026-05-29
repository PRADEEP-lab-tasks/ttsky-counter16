/*
 * Copyright (c) 2026 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_counter16 (
    input  wire [7:0] ui_in,    // Dedicated inputs (can be used for enable, etc.)
    output wire [7:0] uo_out,   // Dedicated outputs (counter lower 8 bits)
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path
    input  wire       ena,      // always 1 when powered
    input  wire       clk,      // clock
    input  wire       rst_n     // active-low reset
);

    // 16-bit counter register
    reg [15:0] counter;

    // Optional: use ui_in[0] as enable
    wire en = ui_in[0];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            counter <= 16'b0;
        else if (en)
            counter <= counter + 1'b1;
    end

    // Map lower 8 bits of counter to outputs
    assign uo_out  = counter[7:0];

    // Tie off unused IOs
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // Prevent unused warnings
    wire _unused = &{ui_in[7:1], uio_in, ena, 1'b0};

endmodule
