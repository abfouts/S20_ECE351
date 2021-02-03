/////////////////////////////////////////////////////////////
// hw3_prob1.sv - hw3 problem 1 shift register
// 
// Author: 	Abram Fouts
// Date:	5/23/2020
//
// Description:
// ------------
// Serial Shift register with reset
/////////////////////////////////////////////////////////////

module hw3_prob1(
input 	logic [3:0] 	serial_in,
input 	logic 		CLK,
input 	logic 		CLR,
input	logic		shift,
output 	logic [3:0] 	OUT
);

always_ff @(posedge CLK) begin
	if(CLR)				//Clear is asserted, reset to 0000
		OUT <= 4'b0000;
	else begin
		if(shift) begin				//Shift and no Clear, shift right while taking the LSB of input
			OUT[0] <= OUT[1];
			OUT[1] <= OUT[2];
			OUT[2] <= OUT[3];
			OUT[3] <= serial_in[0];		//Some other controller needs to shift input to not get the same value over and over
		end else begin				//No shift no clear: Keep the values the same, this is so we don't infer a latch.
			OUT[0] <= OUT[0];
			OUT[1] <= OUT[1];
			OUT[2] <= OUT[2];
			OUT[3] <= OUT[3];
		end
	end
end

endmodule
