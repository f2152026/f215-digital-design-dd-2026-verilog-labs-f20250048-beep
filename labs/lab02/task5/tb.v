module tb;

  reg  [3:0] t_a;
  reg  [3:0] t_b;
  reg        t_op;
  wire [3:0] t_result;

  integer a;
  integer b;
  integer op;
  integer errors;
  integer total;
  integer expected;

  alu U1 (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
  );

  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, U1);
    end
  end

  initial begin
    errors = 0;
    total = 0;

    // Test both operations for every pair of 4-bit inputs
    for (a = 0; a < 16; a = a + 1) begin
      for (b = 0; b < 16; b = b + 1) begin
        for (op = 0; op < 2; op = op + 1) begin

          t_a = a;
          t_b = b;
          t_op = op;

          #1;

          if (op == 0)
            expected = (a + b) & 15;
          else
            expected = (a - b) & 15;

          total = total + 1;

          if (t_result !== expected) begin
            $display("FAIL: a=%0d b=%0d op=%0d | got=%0d expected=%0d",
                     a, b, op, t_result, expected);
            errors = errors + 1;
          end

        end
      end
    end

    $display("----------------------------------------");
    $display("SUMMARY: %0d/%0d tests passed, %0d errors",
             total - errors, total, errors);
    $display("----------------------------------------");

    $finish;
  end

endmodule