`timescale 1ns / 1ps
module test_cu;

reg clock;
wire [7:0] data_out;

control_unit uut (.clock(clock),.data_out(data_out));
initial
 begin
    $dumpfile("test3.vcd");
    $dumpvars(0,test_cu);
 end
initial 
begin
clock=0;
#100;
end
always
#100 clock = !clock;  
endmodule