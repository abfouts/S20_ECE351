
/////////////////////////////////////////////////////////////
// hw3_prob2.sv - hw3 problem 2 finite state machine car wash
// 
// Author: 	Abram Fouts
// Date:	5/23/2020
//
// Description:
// ------------
// finite state machine (moore) car wash
/////////////////////////////////////////////////////////////

module carwash_fsm (  
input logic  clk, CLR,  	// clock and reset signal.  CLR is asserted high           
				// to reset the FSM  
input logic   TOKEN,  	 	// customer inserted a token.  Asserted high  
input logic   START,   		// customer pressed the START button.  Asserted high  
input logic   T1DONE,  		// spray time has expired.  Asserted high  
input logic   T2DONE, 	 	// rinse time (after soap) has expired.  Asserted           
				// high 
 
output logic  CLRT1,  		// clear the spray timer.  Assert high  
output logic  CLRT2,   		// clear the rinse timer. Assert high  
output logic  SOAP,   		// apply soap.  Assert high  
output logic  SPRAY   		// turn on the spray.  Assert high 
);

enum logic [4:0] {
	S0 = 5'b00001,
	S1 = 5'b00010,
	S2 = 5'b00100,
	S3 = 5'b01000,
	S4 = 5'b10000
} state = S1, nextstate = S1;

always_ff@(posedge clk) begin
	if(CLR)
		state <= S0;
	else	
		state <= nextstate;
end

always_comb begin
case(state)
	S0: begin
		CLRT1 	= 0;			//Output values
		CLRT2 	= 0;
		SOAP 	= 0;
		SPRAY 	= 0;
		if(TOKEN)			//Token asserted set next state
			nextstate = S1;
		else
			nextstate = S0;
	end

	S1: begin
		CLRT1 = 1;			//Output values	
		if(~TOKEN & START)		//Start without another token
			nextstate = S4;
		else if(TOKEN * ~START)		//A second token for deluxe
			nextstate = S2;
		else
			nextstate = S1;
	end

	S2: begin
		SPRAY = 1;			//Output values
		CLRT2 = 1;
		CLRT1 = 0;

		if(T1DONE)			//T1DONE asserted move to next state
			nextstate = S3;
		else
			nextstate = S2;
	end

	S3: begin
		SPRAY 	= 0;			//Output values	
		CLRT2	= 0;
		SOAP 	= 1;
		CLRT1	= 1;

		if(T2DONE)			//T2DONE asserted move to next state
			nextstate = S4;
		else
			nextstate = S3;
	end

	S4: begin
		SPRAY 	= 1;			//OUTPUT values
		CLRT2	= 0;
		SOAP 	= 0;
		CLRT1	= 0;

		if(T1DONE)			//T1DONE asserted move back to initial state
			nextstate = S0;
		else
			nextstate = S4;
	end
endcase
end

endmodule
