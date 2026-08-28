// dut.v
// Wrapper module: pick exactly ONE of the three implementations below by
// leaving it uncommented, with the other two commented out. Compile and
// run tb.v, then switch to a different implementation and repeat -- this
// lets you compare rca.v, cla4.v, and cla4_dataflow.v using the exact same
// testbench and stimulus each time.

// dut.v
// Wrapper module for the three 4-bit adder implementations.

module dut(
    input  [3:0] a,
    input  [3:0] b,
    input        cin,
    output [3:0] sum,
    output       cout
);

    // OPTION 1: Delayed ripple-carry adder
    rca U_IMPL (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    // OPTION 2: Gate-level carry-lookahead adder
    // cla4 U_IMPL (
    //     .a(a),
    //     .b(b),
    //     .cin(cin),
    //     .sum(sum),
    //     .cout(cout)
    // );

    // OPTION 3: Dataflow carry-lookahead adder
    // cla4_dataflow U_IMPL (
    //     .a(a),
    //     .b(b),
    //     .cin(cin),
    //     .sum(sum),
    //     .cout(cout)
    // );

endmodule
