`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:55:22 10/31/2017
// Design Name:   eucl
// Module Name:   D:/eucl/mini/test.v
// Project Name:  mini
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: eucl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clock;
	reg [20:0] pm_cont;
	reg [3:0] p_c;

	// Outputs
	wire [7:0] dataout;
	wire [3:0] p_c_out ;

	// Bidirs
	// Instantiate the Unit Under Test (UUT)
	eucl uut (
		.clock(clock), 
		.pm_cont(pm_cont), 
		.dataout(dataout), 
		.p_c(p_c),.p_c_out(p_c_out)
	);
	initial begin
		// Initialize Inputs
		clock = 0;
		pm_cont=21'b010101000110000000010;
		p_c = 0;
		// Wait 100 ns for global reset to finish
		#100;
		clock=1;
		p_c = 0;
		pm_cont=21'b010101000110000000010;
		// Add stimulus here
		#100;
		clock=0;
		pm_cont=21'b010101000110000000010;
		p_c = p_c_out;
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000110000001010;
		// Add stimulus here
		#100;
		clock=0;
		pm_cont=21'b010101000110000001010;
		p_c = p_c_out;
        #100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000110000001010;
		// Add stimulus here
		#100;
		clock=0;
        p_c = p_c_out;
		pm_cont=21'b010101000110000001010;
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000110000000111;
		// Add stimulus here
		#100;
		clock=0;
		p_c = p_c_out;
		pm_cont=21'b010101000110000000111;
		// Add stimulus here
		#100;
		clock=1;
        p_c = p_c_out;
		pm_cont=21'b010101000110000000111; //1
		// Add stimulus here
		#100;
		clock=0;
		p_c = p_c_out;
		pm_cont=21'b010101000110000000111;  
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000110000000111;  //2
		// Add stimulus here
		#100;
		clock=0;
		p_c = p_c_out;
		pm_cont=21'b010101000110000000111;
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000110000000111;  //3
		// Add stimulus here
		#100;
		clock=0;
		p_c = p_c_out;
		pm_cont=21'b010101000110000000111;		
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000110000000111;  //4
		// Add stimulus here
		#100;
		clock=0;
		p_c = p_c_out;
		pm_cont=21'b010101000110000000111;		
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000110000000111;  //5
		// Add stimulus here
		#100;
		clock=0;
		p_c = p_c_out;
		pm_cont=21'b010101000110000000111;	
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000110000001010;  //6
		// Add stimulus here
		#100;
		clock=0;
        p_c = p_c_out;
		pm_cont=21'b010101000110000001010;		
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000110000001010;  
		// Add stimulus here
		#100;
		clock=0;
		p_c = p_c_out;
		pm_cont=21'b010101000110000001010;		
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000100000000010; 
		// Add stimulus here
		#100;
		clock=0;
		p_c = p_c_out;
		pm_cont=21'b010101000100000000010;
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000100000000010;
		// Add stimulus here
		#100;
		clock=0;
		pm_cont=21'b010101000100000000010;
		p_c = p_c_out;
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000100110110011;
		// Add stimulus here
		#100;
		clock=0;
		pm_cont=21'b010101000100110110011;
		p_c = p_c_out;
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000100110110011; //1
		// Add stimulus here
		#100;
		clock=0;
		pm_cont=21'b010101000100110110011;
		p_c = p_c_out;
		#100;
		clock=1;
    	p_c = p_c_out;
		pm_cont=21'b010101000100110110011;  //2
		// Add stimulus here
		#100;
		clock=0;
		pm_cont=21'b010101000100110110011;
		p_c = p_c_out;
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000100110110011;  //3
		// Add stimulus here
		#100;
		clock=0;
		pm_cont=21'b010101000100110110011; 
	    p_c = p_c_out;
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000100110110011;  //4
		// Add stimulus here
		#100;
		clock=0;
		pm_cont=21'b010101000100110110011;  
		p_c = p_c_out;
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000100110110011;  //5
		// Add stimulus here
		#100;
		clock=0;
		pm_cont=21'b010101000100110110011;  
		p_c = p_c_out;
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000100110110011;  //6
		// Add stimulus here
		#100;
		clock=0;
		pm_cont=21'b010101000100110110011;  
		p_c = p_c_out;
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000100110110011;  //7
		// Add stimulus here
		#100;
		clock=0;
		pm_cont=21'b010101000100110110011;  
		p_c = p_c_out;
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000000000001010;
		// Add stimulus here
		#100;
		clock=0;
		p_c = p_c_out;
		pm_cont=21'b010101000000000001010;
		#100;
		clock=1;
		p_c = p_c_out;
		pm_cont=21'b010101000000000001010;
		// Add stimulus here
		#100;
		clock=0;
		p_c = p_c_out;
		pm_cont=21'b010101000000000001010;
		
		
				
	

	end
      
initial
 begin
    $dumpfile("test2.vcd");
    $dumpvars(0,test);
 end
endmodule

