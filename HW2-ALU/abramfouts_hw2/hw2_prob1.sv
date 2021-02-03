/////////////////////////////////////////////////////////////
// hw2_prob1.sv - hw2 problem 1 modeling the given schematic with assign statements
// 
// Author: 	Abram Fouts
// Date:	4/30/2020
//
// Description:
// ------------
// A four input circuit that has two and gates, 2 inverters and an or gate
/////////////////////////////////////////////////////////////

module hw2_prob1(
	input logic A, B, C, D,
	output logic Y
);

timeunit 1ns/1ns;

wire AND1, OR1;

assign OR1 = A | D;		//ORS A and D
assign AND1 = B & C & ~D;	//ANDS B C and not D
assign Y = ~OR1 & AND1;		//ANDS not ORS value and the previous AND

endmodule
