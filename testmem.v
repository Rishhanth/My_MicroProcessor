`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:11:28 10/31/2017
// Design Name:   memory
// Module Name:   D:/eucl/mini/testmem.v
// Project Name:  mini
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testmem;

	// Inputs
	reg clock;
	reg enable;
	reg Write;
	reg [2:0] Address;
	reg [7:0] DataIn;

	// Outputs
	wire [7:0] DataOut;
	wire [7:0] R0;
	wire [7:0] R1;

	// Bidirs
	wire [7:0] R2;

	// Instantiate the Unit Under Test (UUT)
	memory uut (
		.clock(clock), 
		.enable(enable), 
		.Write(Write), 
		.Address(Address), 
		.DataIn(DataIn), 
		.DataOut(DataOut), 
		.R0(R0), 
		.R1(R1), 
		.R2(R2)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		enable = 0;
		Write = 0;
		Address = 0;
		DataIn = 0;

		// Wait 100 ns for global reset to finish
		#100;
      clock=1;
		enable = 1;
		Write = 1;
		DataIn = 8'b00001000;
		Address = 3'b000;
		// Add stimulus here
		#100;
		clock = 0;
		enable = 0;
		Write = 0;
		#100;
      clock=1;
		enable = 1;
		Write = 0;
		Address = 3'b000;
		#100;
		clock = 0;
		enable = 0;
		Write = 0;
	end
      
endmodule

