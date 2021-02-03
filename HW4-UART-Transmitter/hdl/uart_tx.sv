//////////////////////////////////////////////////////////////
// uart_tx.sv - UART Transmitter (starter code)
//
// Author:	<Your name> (<Your email address>) 
// Date:	<date>
//
// Description:
// ------------
// Serializes a data packet, adds the start and stop bits and transmits the
// data packed on bit at a time on the tx signal.
//
// Original code by Pong Chu from his book FPGA Prototyping w/ SystemVerilog, Wiley 2018
////////////////////////////////////////////////////////////////
module uart_tx
#(
	parameter	DBIT = 8,     // # data bits
				SB_TICK = 16  // # 16 ticks for 1 stop bit
 )
(
	input  logic clk, reset,		// system clock and reset (reset asserted high)
	input  logic tx_start, s_tick,	// tx_start tells the transmitter to transmit
									// a serial data packet
	input  logic [7:0] din,			// parallel data in
    output logic tx_done_tick,		// packet transmission done pulse
	output logic tx					// serial transmit line
);

// fsm state type 
typedef enum logic[1:0] {idle, start, data, stop} state_type;

// signal declaration
state_type state_reg, state_next;	// state registers
logic [3:0] s_reg, s_next;			// counts s_ticks for oversampling
logic [2:0] n_reg, n_next;			// counts data bits
logic [7:0] b_reg, b_next;			// serializes the parallel data
logic tx_reg, tx_next;				// generates tx serial data out


// FSMD state & data registers
always_ff @(posedge clk, posedge reset) begin: seq_block
	// ADD YOUR CODE HERE
end: seq_block


// FSMD next-state logic & functional units
always_comb begin: next_state_logic
	// set initial values so you don't have to include every signal in every case item
	// ADD YOUR CODE HERE
	
	// generate next state
	case (state_reg)
		idle: begin: wait_for_start_signal
			tx_next = 1'b1;
			if (tx_start) begin
				// start packet transmission
				state_next = start;
				s_next = 0;
				b_next = din;
            end
		end: wait_for_start_signal	
		
		start: begin: transmit_start_bit
			tx_next = 1'b0;		// set tx low indicating start bit
            if (s_tick)
				if (s_reg == 15) begin
					state_next = data;
					s_next = 0;
					n_next = 0;
               end
               else
					s_next = s_reg + 1;
         end: transmit_start_bit 
		 
         data: begin: transmit_data_bits
			tx_next = b_reg[0];		// set tx to the current data bit
			
			// ADD YOUR CODE HERE

		end: transmit_data_bits
		
		stop: begin: transmit_stop_bit
			tx_next = 1'b1;

			// ADD YOUR CODE HERE
	endcase
end: next_state_logic

// output tx data
assign tx = tx_reg;

endmodule: uart_tx