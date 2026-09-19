// tb.v

module tb;

    reg [3:0] t_a;
    reg [3:0] t_b;
    reg  t_op;

    wire [3:0] t_result;
    reg [3:0] exp_result;

    integer errors =0;
    integer total_tests = 0;
    integer i,j,k;

    //Instantiate DUT
    alu DUT (
        .a(t_a),
        .b(t_b),
        .op(t_op),
        .result(t_result)
    );
    
    // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    for (k = 0; k < 2; k = k + 1) begin
      for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin

          t_a  = i;
          t_b  = j;
          t_op = k;

          exp_result = (t_op == 1'b0) ? (t_a + t_b) : (t_a - t_b);
          #5;

          total_tests = total_tests+1;
          if (t_result !== exp_result) begin
            $display("FAILED at time %0t: op=%b a=%d b=%d | got result=%d expected=%d",
                     $time, t_op, t_a, t_b, t_result, exp_result);
            errors = errors + 1;
          end
        end
      end
    end
  

//explicit test: a,b fixed op toggled
t_a = 4'd5;
t_b = 4'd3;
t_op = 1'b0;
#5;

t_op = 1'b1;
exp_result = 4'd2;
#5;

total_tests = total_tests+1;

if (t_result !== exp_result) begin
      $display("FAIL at time %0t (Sensitivity Test): op=%b a=%d b=%d | got result=%d expected=%d",
               $time, t_op, t_a, t_b, t_result, exp_result);
      errors = errors + 1;
    end

// Summary output
    $write("TEST RESULT: ");
    if (errors == 0) begin
      $display("PASSED %0d out of %0d tests.", total_tests - errors, total_tests);
    end else begin
      $display("FAILED! %0d out of %0d tests passed (%0d errors).",
               total_tests - errors, total_tests, errors);
    end

    $finish;
  end

endmodule