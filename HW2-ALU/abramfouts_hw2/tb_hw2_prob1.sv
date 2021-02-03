/////////////////////////////////////////////////////////////
// tb_hw2_prob1.sv - TEST BENCH FOR hw2 problem 1 modeling the given schematic with assign statements
// 
// Author: 	Abram Fouts
// Date:	4/30/2020
//
// Description:
// ------------
// A four input circuit that has two and gates, 2 inverters and an or gate
/////////////////////////////////////////////////////////////
timeunit 1ns/1ns;

module tb_hw2_prob1();
logic A, B, C, D, Y;
int i;

hw2_prob1 DUT(
.A(A),
.B(B),
.C(C),
.D(D),
.Y(Y)
);

initial begin
	A = 0;
	B = 0;
	C = 0;
	D = 0;
	Y = 0;

	$monitor("A = %b, B = %b, C = %b, D = %b, Y = %b\t", A, B, C, D, Y, "time = ",$time);	//Monitor setup

	for(i = 0; i < 2 ** 4; i = i + 1) begin					//For loop to loop 2 ^ 4 times
		#5 {A, B, C, D} += 1;						//5ns delay on all the values concatinated and added 1
	end
end

endmodule
