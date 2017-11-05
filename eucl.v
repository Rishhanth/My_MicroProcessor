`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////
/*module memory (clock,enable,Write, Address, DataIn, DataOut,R0,R1,R2);
	input Write,clock,enable;
	input [7: 0] DataIn;
	input [2: 0] Address;
	output [7: 0] DataOut;
	reg [7: 0] DataOut;
	reg [7: 0] Mem [0: 5]; // 6 x 8 memory
    output [7:0] R0,R1;
	input [7:0] R2;
    assign R0=Mem [0];
    assign R1 = Mem [1];
	always @ (posedge clock)
    begin
	 Mem [2] <= R2;
    if (enable)
    begin
		if (Write) 
		Mem [Address] <= DataIn; // Write
		else 
        DataOut <= Mem [Address];
    end
    end
	endmodule */

//////////////////////////////////////////////////////////////
/*module alu(enable,a, b, outp, control_bus);
input [7:0] a;
input enable;
input [7:0] b;
input [2:0] control_bus;
output reg [7:0] outp;
integer i;
always @ (*)
begin
if(enable)
begin
case(control_bus)
	3'b000: outp <=  a+b;
	3'b001: outp <= a-b;
	3'b010: outp <= a&b;
	3'b011: outp <= a|b;
	3'b100: outp <= a<<1;
	3'b101: outp <= a>>1;
endcase
end 
end
endmodule
*/
////////////////////////////////////////////////////////////
module exec_unit(ld,write,en_alu,en_mem,addr,indata,outdata,f_select);
input [7:0] indata;
wire [7:0] DataIn;
input clock,ld,write,en_alu,en_mem;
input [2:0] addr;
reg [7:0] outdr;
output [7:0] outdata;
reg [7:0] Mem [0:5];
input [2:0] f_select;
assign outdata = outdr;
assign DataIn = ld ? indata : outdr; 
//memory mem1(.clock(clock),.enable(en_mem),.Write(write),.Address(addr),.DataIn(indata),.DataOut(outdata),.R0(a),.R1(b),.R2(c));
//alu alu1(.enable(en_alu),.a(a),.b(b),.outp(c),.control_bus(f_select));
always @(*)
begin
if (en_mem)
    begin
		if (write) 
		Mem [addr] <= DataIn; // Write
		else 
        outdr <= Mem [addr];
    end
if(en_alu)
begin
case(f_select)
	3'b000: Mem [2] <= Mem [0]+Mem [1];
	3'b001: Mem [2] <= Mem [0]-Mem [1];
	3'b010: Mem [2] <= Mem [0]&Mem [1];
	3'b011: Mem [2] <= Mem [0]|Mem [1];
	3'b100: Mem [2] <= Mem [0]<<1;
	3'b101: Mem [2] <= Mem [0]>>1;
endcase
end 
end
    
//assign DataIn = ld ? indata : outdata; 
endmodule

////////////////////////////////////////////////////////////
module idec(pm_cont,op1,op2,op3,data,opcode);
input [20:0] pm_cont;
output [2:0] op1,op2,op3;
output [7:0] data;
output [3:0] opcode;
assign data = pm_cont [20:13];
assign op1 = pm_cont [12:10];
assign op2 = pm_cont [9:7];
assign op3 = pm_cont [6:4];
assign opcode = pm_cont [3:0];
endmodule

//////////////////////////////////////////////////////////////
module eucl(clock,pm_cont,dataout,p_c,p_c_out);
input [3:0] p_c;
output [3:0] p_c_out;
reg [3:0] p_c_val;
input [20:0] pm_cont;
input clock;
output [7:0] dataout;
reg ld,write,en_alu,en_mem;
reg [2:0] addr,control_bus;
wire [7:0] data;
wire [2:0] op1,op2,op3;
wire [3:0] opcode;
reg [3:0] state =4'b0000;
assign p_c_out = p_c_val;

idec IDE(.pm_cont(pm_cont),.op1(op1),.op2(op2),.op3(op3),.data(data),.opcode(opcode));
exec_unit EU(.ld(ld),.write(write),.en_alu(en_alu),.en_mem(en_mem),.addr(addr),.indata(data),.outdata(dataout),.f_select(control_bus));

always @(posedge clock)
begin

ld<=0;
write<=0;
en_alu<=0;
en_mem <=0;
p_c_val <= p_c;

if(opcode==4'b0001) // move
begin
if (state==4'b0000)
begin
addr <= op1;
en_mem <= 1;
state <= 4'b0001;
end 
else if (state==4'b0001)
begin
addr <=op2;
en_mem <= 1;
write <= 1;
state <= 4'b0000;
p_c_val <= p_c + 1;
end
end

else if (opcode==4'b0010) //load
begin
if (state==4'b0000)
begin
addr <= op1;
ld <= 1;
en_mem <= 1;
write <= 1;
state <= 4'b0000;
p_c_val <= p_c + 1;
end
end

else if (opcode==4'b0011) //add
begin
if (state==4'b0000)
begin
addr <= op1;
en_mem <= 1;
state <= 4'b0001;
end 
else if (state==4'b0001)
begin
addr <=3'b000;
en_mem <= 1;
write <= 1;
state <= 4'b0010;
end
else if (state==4'b0010)
begin
addr <= op2;
en_mem <= 1;
state <= 4'b0011;
end 
else if (state==4'b0011)
begin
addr <=3'b001;
en_mem <= 1;
write <= 1;
state <= 4'b0100;
end
else if (state==4'b0100)
begin
control_bus <= 3'b000;
en_alu <= 1 ;
state <= 4'b101;
end
else if (state==4'b0101)
begin
addr <= 3'b010 ;
en_mem <= 1;
state <= 4'b0110;
end
else if (state==4'b0110)
begin
addr <= op3;
en_mem <= 1;
write <= 1;
state <= 4'b0000;
p_c_val <= p_c + 1;
end
end

else if (opcode==4'b0100) //sub
begin
if (state==4'b0000)
begin
addr <= op1;
en_mem <= 1;
state <= 4'b0001;
end 
else if (state==4'b0001)
begin
addr <=3'b000;
en_mem <= 1;
write <= 1;
state <= 4'b0010;
end
else if (state==4'b0010)
begin
addr <= op2;
en_mem <= 1;
state <= 4'b0011;
end 
else if (state==4'b0011)
begin
addr <=3'b001;
en_mem <= 1;
write <= 1;
state <= 4'b0100;
end
else if (state==4'b0100)
begin
control_bus <= 3'b001;
en_alu <= 1 ;
state <= 4'b101;
end
else if (state==4'b0101)
begin
addr <= 3'b010 ;
en_mem <= 1;
state <= 4'b0110;
end
else if (state==4'b0110)
begin
addr <= op3;
en_mem <= 1;
write <= 1;
state <= 4'b0000;
p_c_val <= p_c +1;
end
end

else if (opcode==4'b0101) //and
begin
if (state==4'b0000)
begin
addr <= op1;
en_mem <= 1;
state <= 4'b0001;
end 
else if (state==4'b0001)
begin
addr <=3'b000;
en_mem <= 1;
write <= 1;
state <= 4'b0010;
end
else if (state==4'b0010)
begin
addr <= op2;
en_mem <= 1;
state <= 4'b0011;
end 
else if (state==4'b0011)
begin
addr <=3'b001;
en_mem <= 1;
write <= 1;
state <= 4'b0100;
end
else if (state==4'b0100)
begin
control_bus <= 3'b010;
en_alu <= 1 ;
state <= 4'b101;
end
else if (state==4'b0101)
begin
addr <= 3'b010 ;
en_mem <= 1;
state <= 4'b0110;
end
else if (state==4'b0110)
begin
addr <= op3;
en_mem <= 1;
write <= 1;
state <= 4'b0000;
p_c_val <= p_c+1;
end
end

else if (opcode==4'b0110) //or
begin
if (state==4'b0000)
begin
addr <= op1;
en_mem <= 1;
state <= 4'b0001;
end 
else if (state==4'b0001)
begin
addr <=3'b000;
en_mem <= 1;
write <= 1;
state <= 4'b0010;
end
else if (state==4'b0010)
begin
addr <= op2;
en_mem <= 1;
state <= 4'b0011;
end 
else if (state==4'b0011)
begin
addr <=3'b001;
en_mem <= 1;
write <= 1;
state <= 4'b0100;
end
else if (state==4'b0100)
begin
control_bus <= 3'b011;
en_alu <= 1 ;
state <= 4'b101;
end
else if (state==4'b0101)
begin
addr <= 3'b010 ;
en_mem <= 1;
state <= 4'b0110;
end
else if (state==4'b0110)
begin
addr <= op3;
en_mem <= 1;
write <= 1;
state <= 4'b0000;
p_c_val <= p_c + 1;
end
end

else if (opcode==4'b0111) //ls
begin
if (state==4'b0000)
begin
addr <= op1;
en_mem <= 1;
state <= 4'b0001;
end 
else if (state==4'b0001)
begin
addr <=3'b000;
en_mem <= 1;
write <= 1;
state <= 4'b0010;
end
else if (state==4'b0010)
begin
control_bus <= 3'b100;
en_alu <= 1 ;
state <= 4'b0011;
end
else if (state==4'b0011)
begin
addr <= 3'b010 ;
en_mem <= 1;
state <= 4'b0100;
end
else if (state==4'b0100)
begin
addr <= op1;
en_mem <= 1;
write <= 1;
state <= 4'b0000;
p_c_val <= p_c + 1;
end
end

else if (opcode==4'b1001) //rs
begin
if (state==4'b0000)
begin
addr <= op1;
en_mem <= 1;
state <= 4'b0001;
end 
else if (state==4'b0001)
begin
addr <=3'b000;
en_mem <= 1;
write <= 1;
state <= 4'b0010;
end
else if (state==4'b0010)
begin
control_bus <= 3'b101;
en_alu <= 1 ;
state <= 4'b0011;
end
else if (state==4'b0011)
begin
addr <= 3'b010 ;
en_mem <= 1;
state <= 4'b0100;
end
else if (state==4'b0100)
begin
addr <= op1;
en_mem <= 1;
write <= 1;
state <= 4'b0000;
p_c_val <= p_c + 1;
end
end

else if (opcode==4'b1010) //store
begin
if (state==4'b0000)
begin
addr <= op1;
en_mem <= 1;
state <= 4'b0000;
p_c_val <= p_c + 1;
end
end

end
endmodule

///////////////////////////////////////////////////////////////////