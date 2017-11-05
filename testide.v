`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:41:25 10/31/2017
// Design Name:   idec
// Module Name:   D:/eucl/mini/testide.v
// Project Name:  mini
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: idec
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testide;

	// Inputs
	reg [20:0] pm_cont;

	// Outputs
	wire [2:0] op1;
	wire [2:0] op2;
	wire [2:0] op3;
	wire [7:0] data;
	wire [3:0] opcode;

	// Instantiate the Unit Under Test (UUT)
	idec uut (
		.pm_cont(pm_cont), 
		.op1(op1), 
		.op2(op2), 
		.op3(op3), 
		.data(data), 
		.opcode(opcode)
	);

	initial begin
		// Initialize Inputs
		pm_cont = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		pm_cont=21'b010101000110000000010;
		// Add stimulus here
		#100;
		pm_cont=21'b010101000110000000010;
      
		#100;
		pm_cont=21'b010101000110000001010;
		// Add stimulus here
		#100;
		pm_cont=21'b010101000110000001010;
		// Add stimulus here
        
		// Add stimulus here

	end
      
endmodule

