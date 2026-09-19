// tb.v
// Testbench for parameterized LUT

module tb;

  // DEPTH = 8, so sel needs 3 bits
  reg [2:0] t_sel;
  wire [7:0] t_dout;

  integer i;

  // Instantiate LUT with parameter override
  lut #(
    .WIDTH(8),
    .DEPTH(8)
  ) U1 (
    .sel  (t_sel),
    .dout (t_dout)
  );

  // Waveform dump configuration
  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, U1);
    end
  end

  // Test every valid address
  initial begin
    for (i = 0; i < 8; i = i + 1) begin
      t_sel = i;
      #5;

      if (t_dout !== (i * i))
        $display("ERROR: sel=%0d, expected=%0d, got=%0d",
                 i, i * i, t_dout);
      else
        $display("PASS: sel=%0d, dout=%0d", i, t_dout);
    end

    $finish;
  end

  initial
    $monitor($time, " sel=%b | dout=%b (%0d)", t_sel, t_dout, t_dout);

endmodule