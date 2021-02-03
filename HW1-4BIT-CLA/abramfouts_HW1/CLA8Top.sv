/////////////////////////////////
// Author: 	Abram Fouts
// Email:	abfouts@pdx.edu
// Date:	4/16/2020
// Description:	This is a 8 bit carry lookahead adder, 
//		modeled by two 4 bit CLA
//		with gate delays of 2ns, 2ns, and 3ns for AND, OR, XOR respectively
/////////////////////////////////	

module CLA8Top;  
	parameter nBITS = 8;  
	logic [nBITS - 1 : 0] ain, bin, sum;  
	logic cin, cout; 
 
	//interconnects
	wire c4, c8;

	assign cout = c8;
 // instantiate your 8 bit CLA design module here 
  	CLA4bit UUT1(
		.in1(ain[3:0]),
		.in2(bin[3:0]),
		.cin(cin),
		.cout(c4),
		.sum(sum[3:0])
		); 

 	CLA4bit UUT2(
		.in1(ain[7:4]),
		.in2(bin[7:4]),
		.cin(c4),
		.cout(c8),
		.sum(sum[7:4])
		); 

 // instantiate the test bench module as follows  
	test #(8) TB(.*); 
endmodule 
 
// 4 bit CLA
module CLA4bit(in1, in2, cin, cout, sum);
timeunit 1ns/1ns;

input logic [3:0] in1;
input logic [3:0] in2;
input logic cin;
output logic cout;
output logic [3:0] sum;

wire [3:0] p,g, carry;
wire c4;

// C4 = g3 + p3g2 + p3p2g1 + p3p2p1g0 + p3p2p1p0c0

assign #3 p = in1 ^ in2; //XOR both inputs for propagate value, one XOR 3ns delay
assign #2 g = in1 & in2; //AND both inputs for generate value, one AND 3ns delay

assign carry[0] = cin;
assign #4 carry[1] = g[0] + (p[0] & carry[0]);								//2 Gates (1 OR and 1 AND)
assign #6 carry[2] = g[1] + (g[0] & p[1]) + (p[1] & p[0] & carry[0]);					//3 Gates (1 OR and 2 AND)
assign #8 carry[3] = g[2] + (g[1] & p[2]) + (g[0] & p[1] & p[2]) + (p[2] & p[1] & p[0] & carry[0]);	//4 Gates (1 OR and 3 AND)			

assign #10 c4 = g[3] + (g[2] & p[3]) + (g[1] & p[2] & p[3]) + (g[0] & p[1] & p[2] & p[3]) + (p[3] & p[2] & p[1] & p[0] & carry[0]);	//13 Gates (1 OR, 4 AND) 
assign #3 sum = p ^ carry;	//IN1 XOR IN2 XOR CARRY
assign cout = c4;  	//C4

endmodule