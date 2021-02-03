module SR_latch (
	input logic S_N, R_N,	// S and R inputs to the latch.  Asserted low
	output logic Q, Q_N		// Q and Q bar outputs from the latch
);

	timeunit 1ns/1ns;

	nand #2 n1(Q, Q_N, S_N);	
	nand #2 n2(Q_N, Q, R_N);

endmodule: SR_latch


module JK_flip_flop (
	input logic Clk,		// clock					
	input logic J, K,		// J and K inputs to the master latch
	output logic Q, Q_N		// Q and Q bar outputs from the slave latch
);
	timeunit 1ns/1ns;
	
	logic jNAND, kNAND, mQ, mQ_N; 	//jNAND is the gate for J in, kNAND is the gate for k in
									//mQ is master Q out, mQ_N is master Q not out 
	
	logic sS_N, sR_N;				//Slack SR inputs (the NAND gates)
	
	assign #2 jNAND = ~(J & Clk & Q_N);	//Master nand
	assign #2 kNAND = ~(K & Clk & Q);	//Master nand
	assign #2 sS_N = ~(~Clk & mQ);		//slave nand
	assign #2 sR_N = ~(~Clk & mQ_N);	//slave nand
	
	//SR instantiation
	SR_latch master(
	.S_N(jNAND),
	.R_N(kNAND),
	.Q(mQ),
	.Q_N(mQ_N)
	);
	
	SR_latch slave(
	.S_N(sS_N),
	.R_N(sR_N),
	.Q(Q),
	.Q_N(Q_N)
	);

endmodule: JK_flip_flop


module sync_counter (
	input logic clock,			// clock
	input logic count_enable,	// enable counting when asserted high
	output logic [3:0]	Q		// counter output
);

	timeunit 1ns/1ns;

	logic [2:0] AND_OUT;
	logic [3:0] Q_N;

	//JK instantiation
	JK_flip_flop JK1 (
	.Clk(clock),
	.J(count_enable),
	.K(count_enable),
	.Q(Q[0]),
	.Q_N(Q_N[0])
	);
	
	JK_flip_flop JK2 (
	.Clk(clock),
	.J(AND_OUT[0]),
	.K(AND_OUT[0]),
	.Q(Q[1]),
	.Q_N(Q_N[1])
	);
	
	JK_flip_flop JK3 (
	.Clk(clock),
	.J(AND_OUT[1]),
	.K(AND_OUT[1]),
	.Q(Q[2]),
	.Q_N(Q_N[2])
	);
	
	JK_flip_flop JK4 (
	.Clk(clock),
	.J(AND_OUT[2]),
	.K(AND_OUT[2]),
	.Q(Q[3]),
	.Q_N(Q_N[3])
	);
	
	//Combinational logic 
	always_comb begin
		AND_OUT[0] = Q[1] & count_enable;	//first AND gate
		AND_OUT[1] = AND_OUT[0] & Q[2];		//second AND gate
		AND_OUT[2] = AND_OUT[1] & Q[3];		//Third AND gate

	end
	
endmodule: sync_counter