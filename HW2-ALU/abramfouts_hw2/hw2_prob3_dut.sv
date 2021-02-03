/////////////////////////////////////////////////////////////
// hw2_prob3_dut.sv - hw2 problem 3 modeling the given schematic with combinational logic statements
// 
// Author: 	Abram Fouts
// Date:	4/30/2020
//
// Description:
// ------------
// Connects register_file and the created ALU
/////////////////////////////////////////////////////////////

import ALU_REGFILE_defs::*; 
 
module hw2_prob3_dut ( 
 
 // register file interface  
input  logic [REGFILE_ADDR_WIDTH-1:0] 	Read_Addr_1, 	// read port addresses 
					Read_Addr_2,  
input  logic [REGFILE_ADDR_WIDTH-1:0] 	Write_Addr, 	// write port address  
input  logic 				Write_enable, 	// write enable (1 to write)  
input  logic [REGFILE_WIDTH-1:0]   	Write_data, 	// data to write into the register file    

// ALU interface.  Data to the ALU comes from the register file  
input  logic          			Carry_In, 	// Carry In  
input  aluop_t        			Opcode, 	// operation to perform  
output logic [ALU_OUTPUT_WIDTH-1:0]   	ALU_Out, 	// ALU result    

// system-wide signals  
input  logic         			Clock  		// system clock 
);

logic [REGFILE_WIDTH-1:0] Data_Out_1, Data_Out_2;

register_file UUT2 (
.Data_Out_1(Data_Out_1), 
.Data_Out_2(Data_Out_2),
.Data_In(Write_data),
.Read_Addr_1(Read_Addr_1), 
.Read_Addr_2(Read_Addr_2),		
.Write_Addr(Write_Addr),			
.Write_enable(Write_enable),			
.Clock(Clock)
);

hw2_prob3_alu ALU_INST (
.A_In(Data_Out_1[ALU_INPUT_WIDTH-1:0]),
.B_In(Data_Out_2[ALU_INPUT_WIDTH-1:0]),
.Carry_In(Carry_In),
.Opcode(Opcode),
.ALU_Out(ALU_Out)
);

endmodule
