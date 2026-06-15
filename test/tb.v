`default_nettype none
`timescale 1ns / 1ps

/* Testbench for tt_um_counter16
   Instantiates the module and provides convenient wires
   for cocotb or waveform viewing.
*/
module tb ();

  // Dump signals to FST file
  initial begin
    $dumpfile("tb.fst");
    $dumpvars(0, tb);
    #1;
  end

  // Inputs and outputs
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Instantiate the counter module
  tt_um_counter16 user_project (
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif
      .ui_in  (ui_in),
      .uo_out (uo_out),
      .uio_in (uio_in),
      .uio_out(uio_out),
      .uio_oe (uio_oe),
      .ena    (ena),
      .clk    (clk),
      .rst_n  (rst_n)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100 MHz clock
  end

  // Stimulus
  initial begin
    // Initialize
    ena    = 1;
    ui_in  = 8'b00000001; // enable = ui_in[0]
    uio_in = 8'b0;

    // Apply reset
    rst_n = 0; #20;
    rst_n = 1;

    // Run counter for some cycles
    #200;

    // Disable counting
    ui_in[0] = 0; #50;

    // Re-enable counting
    ui_in[0] = 1; #100;
    
    $finish;
  end

endmodule
