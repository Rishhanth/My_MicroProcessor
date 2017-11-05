`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:16:28 10/31/2017
// Design Name:   alu
// Module Name:   D:/eucl/mini/testalu.v
// Project Name:  mini
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testalu;

	// Inputs
	reg clock;
	reg enable;
	reg [7:0] a;
	reg [7:0] b;
	reg [2:0] control_bus;

	// Outputs
	wire [7:0] outp;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.clock(clock), 
		.enable(enable), 
		.a(a), 
		.b(b), 
		.outp(outp), 
		.control_bus(control_bus)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		enable = 0;
		a = 0;
		b = 0;
		control_bus = 0;

		// Wait 100 ns for global reset to finish
		#100;
		clock = 1;
		enable = 1;
		a=8'b00000001;
		b=8'b00000010;
		control_bus=3'b0000;
		#100;
		clock = 0;
		enable = 0;
		a=8'b00000001;
		b=8'b00000010;
		control_bus=3'b0000;
      
		// Add stimulus here

	end

	initial
 begin
    $dumpfile("test.vcd");
    $dumpvars(0,testalu);
 end
      
endmodule

