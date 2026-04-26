`timescale 1ns/1ps

module adder (
    input [1:0] a,
    input [1:0] b,
    input cin,
    output [1:0] sum,
    output cout
);
    assign {cout, sum} = a + b + {2'b0, cin};
	
endmodule