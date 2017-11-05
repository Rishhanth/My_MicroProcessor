`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:19:25 10/31/2017
// Design Name:   exec_unit
// Module Name:   D:/eucl/mini/testexec.v
// Project Name:  mini
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: exec_unit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testexec;

	// Inputs
	reg ld;
	reg write;
	reg en_alu;
	reg en_mem;
	reg [2:0] addr;
	reg [7:0] indata;
	reg [2:0] f_select;

	// Outputs
	wire [7:0] outdata;
	// Instantiate the Unit Under Test (UUT)
	exec_unit uut ( 
		.ld(ld), 
		.write(write), 
		.en_alu(en_alu), 
		.en_mem(en_mem), 
		.addr(addr), 
		.indata(indata),
		.outdata(outdata), 
		.f_select(f_select)
		);

	initial begin
		// Initialize Inputs
		ld = 0;
		write = 0;
		en_alu = 0;
		en_mem = 0;
		addr = 0;
		indata = 0;
		f_select = 0;

		// Wait 100 ns for global reset to finish
		#100;
		ld = 1;
		write = 1;
		en_alu = 0;
		en_mem = 1;
		addr = 3'b000;
		indata = 8'b00000010;
		f_select = 0;
		#100;
		ld = 0;
		write = 0;
		en_alu = 0;
		en_mem = 0;
		addr = 4'b0000;
		indata = 8'b00000010;
		f_select = 0;
		#100;
		ld = 1;
		write = 1;
		en_alu = 0;
		en_mem = 1;
		addr = 3'b001;
		indata = 8'b00000011;
		f_select = 0;
		#100;
		ld = 0;
		write = 0;
		en_alu = 0;
		en_mem = 0;
		addr = 4'b0000;
		indata = 8'b00000010;
		f_select = 0;
		#100;
		ld = 0;
		write = 0;
		en_alu = 1;
		en_mem = 0;
		addr = 4'b0010;
		indata = 8'b00000010;
		f_select = 3'b000;
		#100;
		ld = 0;
		write = 0;
		en_alu = 0;
		en_mem = 0;
		addr = 4'b0010;
		indata = 8'b00000010;
		f_select = 0;
		#100;
		ld = 0;
		write = 0;
		en_alu = 0;
		en_mem = 1;
		addr = 4'b0010;
		indata = 8'b00000010;
		f_select = 3'b000;
		#100;
		ld = 0;
		write = 0;
		en_alu = 0;
		en_mem = 0;
		addr = 4'b0010;
		indata = 8'b00000010;
		f_select = 3'b000;
		#100;
		en_mem=1;
		addr=4'b0010;
		#100;
		en_alu=0;
		en_mem=0;
		
		
		
		
        
		// Add stimulus here

	end
	initial
 begin
    $dumpfile("test2.vcd");
    $dumpvars(0,testexec);
 end
      

endmodule

