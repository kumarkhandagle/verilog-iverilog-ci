`timescale 1ns / 1ps

module tb_adder;

    // Testbench signals
    reg  [1:0] a, b;
    reg        cin;
    wire [1:0] sum;
    wire       cout;

    // Instantiate the DUT (Design Under Test)
    adder dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    // Self-checking variables
    reg [2:0] expected;

    initial begin
        $display("========================================");
        $display("     2-Bit Adder Testbench Started");
        $display("========================================");
        $display("Time |  a   b  cin | sum  cout | Expected | Result");
        $display("--------------------------------------------------");

        // Test Case 1: 0 + 0 + 0 = 0
        a = 2'b00; b = 2'b00; cin = 0; #10;
        expected = a + b + cin;
        check_result();

        // Test Case 2: 1 + 1 + 0 = 2
        a = 2'b01; b = 2'b01; cin = 0; #10;
        expected = a + b + cin;
        check_result();

        // Test Case 3: 3 + 3 + 0 = 6 (sum=2, cout=1)
        a = 2'b11; b = 2'b11; cin = 0; #10;
        expected = a + b + cin;
        check_result();

        // Test Case 4: 3 + 3 + 1 = 7 (sum=3, cout=1)
        a = 2'b11; b = 2'b11; cin = 1; #10;
        expected = a + b + cin;
        check_result();

        // Test Case 5: 2 + 1 + 1 = 4 (sum=0, cout=1)
        a = 2'b10; b = 2'b01; cin = 1; #10;
        expected = a + b + cin;
        check_result();

        // Test Case 6: Random values
        a = 2'b01; b = 2'b10; cin = 0; #10;
        expected = a + b + cin;
        check_result();

        $display("========================================");
        $display("          Testbench Completed");
        $display("========================================");
        $finish;
    end

    // Task to check and display result
    task check_result;
        begin
            if ({cout, sum} == expected) begin
                $display("%4t | %2b %2b  %b  |  %2b    %b   |   %3b    |  PASS", 
                         $time, a, b, cin, sum, cout, expected);
            end else begin
                $display("%4t | %2b %2b  %b  |  %2b    %b   |   %3b    |  FAIL", 
                         $time, a, b, cin, sum, cout, expected);
            end
        end
    endtask

    // Generate VCD file (optional - for waveform viewing)
    initial begin
        $dumpfile("adder_waveform.vcd");
        $dumpvars(0, tb_adder);
    end

endmodule