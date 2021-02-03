/////////////////////////////////////////////////////////////
// hw2_prob3_alu.sv - hw2 problem 3 modeling the given schematic with combinational logic statements
// 
// Author: 	Abram Fouts
// Date:	4/30/2020
//
// Description:
// ------------
// 8 Bit ALU
/////////////////////////////////////////////////////////////
import ALU_REGFILE_defs::*; 
 
module hw2_prob3_alu (
	input logic [ALU_INPUT_WIDTH-1:0]  	A_In, B_In, 	// A and B operands  
	input logic         			Carry_In, 	// Carry In  
	input aluop_t  				Opcode, 	// operation to perform  
	output logic [ALU_OUTPUT_WIDTH-1:0]  	ALU_Out 	// ALU result(extended by 1 bit               
								// to preserve Carry_Out from                
								// Sum/Diff) 
); 

always_comb begin
	case (Opcode)
	ADD_OP:		ALU_Out = A_In + B_In + Carry_In;
	SUB_OP:		ALU_Out = A_In + ~B_In + Carry_In;
	SUBA_OP:	ALU_Out = B_In + ~A_In + ~Carry_In;	
	ORAB_OP:	ALU_Out = {1'b0, A_In | B_In};
	ANDAB_OP:	ALU_Out = {1'b0, A_In & B_In};
	NOTAB_OP:	ALU_Out = {1'b0, ~(A_In) & B_In};
	EXOR_OP:	ALU_Out = {1'b0, A_In ^ B_In};
	EXNOR_OP:	ALU_Out = {1'b0, A_In ~^ B_In};
	endcase
end	//always comb

endmodule
