`timescale 1ns/1ps

module tb;

    // Testbench signals
    reg  [1:0] a, b;
    reg        cin;
    wire [1:0] sum;
    wire       cout;

    // Instantiate the DUT
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

        // Test cases
        a = 2'b00; b = 2'b00; cin = 0; #10; expected = a + b + {2'b0, cin}; check_result();
        a = 2'b01; b = 2'b01; cin = 0; #10; expected = a + b + {2'b0, cin}; check_result();
        a = 2'b11; b = 2'b11; cin = 0; #10; expected = a + b + {2'b0, cin}; check_result();
        a = 2'b11; b = 2'b11; cin = 1; #10; expected = a + b + {2'b0, cin}; check_result();
        a = 2'b10; b = 2'b01; cin = 1; #10; expected = a + b + {2'b0, cin}; check_result();
        a = 2'b01; b = 2'b10; cin = 0; #10; expected = a + b + {2'b0, cin}; check_result();

        $display("========================================");
        $display("          Testbench Completed");
        $display("========================================");
        $finish;
    end

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

    // Generate VCD (optional)
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
    end

endmodule
