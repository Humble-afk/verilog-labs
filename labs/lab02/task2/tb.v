// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
    parameter WIDTH = 8;
    parameter DEPTH = 8;
  

  // TODO: instantiate DUT here

  reg [$clog2(DEPTH)-1:0] t_sel;

  wire [WIDTH-1:0] t_dout;

  integer k;

  lut #(
    .WIDTH(WIDTH),
    .DEPTH(DEPTH)
    )
  DUT (
  .sel  (t_sel),
  .dout (t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // TODO: apply different input combinations

    t_sel = 0;

    for(k=0; k<DEPTH; k++) begin
      t_sel = k;
      #5;

    end
    $finish;

  end

  initial
    $monitor($time, " sel=%d | t_dout=%d", t_sel,t_dout); // change as required

endmodule
