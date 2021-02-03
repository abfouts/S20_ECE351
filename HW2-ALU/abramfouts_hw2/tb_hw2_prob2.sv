/////////////////////////////////////////////////////////////
// tb_hw2_prob2.sv - TEST BENCH hw2 problem 2 modeling the given schematic with combinational logic statements
// 
// Author: 	Abram Fouts
// Date:	4/30/2020
//
// Description:
// ------------
// 5 inputs into 2 AND gates, then NOR'd and passing through a tri state buffer
/////////////////////////////////////////////////////////////

timeunit 1ns/1ns;

module tb_hw2_prob2();
logic x_in1, x_in2, x_in3, x_in4, x_in5, y_out, en;	//Port connections for the instantiation
integer i;					//Counter for doing 2^5 iterations testing all cases 

hw2_prob2 DUT(
.x_in1(x_in1),
.x_in2(x_in2),
.x_in3(x_in3),
.x_in4(x_in4),
.x_in5(x_in5),
.en(en),
.y_out(y_out)
);

initial begin
	en = 0;	//initialized en to 0
	repeat(2) begin	//repeats this section twice
	//Initialization
	x_in1 = 0;
	x_in2 = 0;
	x_in3 = 0;
	x_in4 = 0;
	x_in5 = 0;	
	
	$monitor("x_in1 = %b, x_in2 = %b, x_in3 = %b, x_in4 = %b, x_in5 = %b, y_out = %b, en = %b\t", x_in1, x_in2, x_in3, x_in4, x_in5, y_out, en, "time = ",$time);	//Monitor setup
	for(i = 0; i < 2**5; i = i + 1) begin
		#5 {x_in1, x_in2, x_in3, x_in4, x_in5} += 1;
	end
	en = 1;	//Finished the iteration with en = 0;
	end
end
endmodule
