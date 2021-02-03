// Test bench for Generic N-Bits Adder design module
//
// Author:  Rishitosh Sawant (risawant@pdx.edu)
//
// This module is the test bench for the N-bit Carry Lookahead Adder
// that is part of the ECE 351 Homework #1 release
////////////////////////////////////////////////////////////////////

module test(ain, bin, cin, sum, cout);

	timeunit 1ns/1ns;
	
	parameter nBITS = 4;
	parameter DELAY = 100;
	input [nBITS - 1 : 0] sum;
	input cout;
	 
	output [nBITS - 1 : 0] ain, bin;
	output cin;

	logic [nBITS - 1 : 0] ain, bin, sum;
	logic cin, cout;

	// test variables
	logic [nBITS : 0] exp_value;
	int i, j, test_count;
	bit error;

	initial begin
		error       = 0;
		test_count  = 0;
		cin 	    = 0;
		repeat(2) begin
			for(i = 0; i < (1 << nBITS); i++) begin
			ain = i;
			for(j = 0; j < (1 << nBITS); j++) begin
			test_count++;
			bin = j;
			exp_value = ain + bin + cin;
			#DELAY;
			if({cout, sum} !== exp_value) begin
			$display("For inputs: ain = %b, bin = %b, cin = %b :: Actual outputs: cout = %1b, sum = %b :: Expected outputs: cout = %1b, sum = %b", ain, bin, cin, cout, sum, exp_value[nBITS], exp_value[nBITS-1:0]);
			error = 1;
			end // end for if block
			end // end for j for loop
			end // end for i for loop
			cin = ~cin;
		end // end for repeat block

		if(error === 0) 
			$display("***Congratulations, No errors found after %d tests***", test_count);
		else
			$display("***Sorry, errors found in your code ***");
	end // end for initial block


endmodule