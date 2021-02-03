
/////////////////////////////////////////////////////////////
// hw2_prob2.sv - hw2 problem 2 modeling the given schematic with combinational logic statements
// 
// Author: 	Abram Fouts
// Date:	4/30/2020
//
// Description:
// ------------
// 5 inputs into 2 AND gates, then NOR'd and passing through a tri state buffer
/////////////////////////////////////////////////////////////

module hw2_prob2(
input logic x_in1, x_in2, x_in3, x_in4, x_in5, en,
output tri y_out
);

logic NOR;			//Our NOR variable

assign y_out = en ? ~NOR:1'bz;	//Ternary, if enabled assign NOR (acutally not NOR because NOR was only OR'd up until here), else assign Z

always_comb
	begin
	NOR = (x_in1 & x_in2) | (x_in3 & x_in4 & x_in5);	//OR's the and results
	end
endmodule
