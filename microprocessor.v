`timescale 1 ns / 1 ps
////////////////////////////////////////////////////////////
module exec_unit(clock,ld,write,en_alu,en_mem,addr,indata,outdata,f_select,flag_reg);
input [7:0] indata;
wire [7:0] DataIn;
input clock,ld,write,en_alu,en_mem;
input [2:0] addr;
reg [7:0] outdr;
reg set_zero,set_ovf,set_cmp;
output reg [3:0] flag_reg = 0;
reg [8:0] check=0;
output [7:0] outdata;
reg [7:0] Mem [0:5];
input [3:0] f_select;
assign outdata = outdr;
assign DataIn = ld ? indata : outdr; 
initial
begin
set_zero=0;
set_cmp=0;
set_ovf=0;
end
always @(posedge clock)
begin
if (en_mem)
    begin
		if (write) 
		Mem [addr] <= DataIn; // Write
		else 
        outdr <= Mem [addr];
    end
if (en_alu)
begin
if (set_zero)
begin
Mem [0] <= check [7:0];
if (check [7:0] == 0)
begin
flag_reg [0] <= 1; 
end
else 
begin
flag_reg [0] <= 0;
end
set_zero <= 0;
end
if (set_ovf)
begin
flag_reg [3] <= check [8];
set_ovf <= 0;
end
if (set_cmp)
begin
flag_reg [1] <= check [8];
set_cmp <= 0;
end
else
begin
case(f_select)
	4'b0000:
			begin  //add
			check  <= Mem [0]+Mem [1];
			//Mem [2] <= check [7:0];
			//flag_reg [3] <= check [8];
			set_ovf <= 1; 
			set_zero <= 1;
			end
	4'b0001: begin  //sub
			check  <= Mem [0]-Mem [1];
			//Mem [2] <= checxk [7:0];
		    flag_reg [3] <= check [8]; 
			set_zero <= 1;
			set_ovf <= 1;
			end
	4'b0010: begin  //and
			 check <= Mem [0]&Mem [1];
			 //Mem [2] <= check [7:0];
			 set_zero <= 1;
			 end
	4'b0011: begin     //or
	         check <= Mem [0]|Mem [1];
			 //Mem [2] <= check [7:0];
			 set_zero <= 1;
			 end
	4'b0100: begin     //ls
			 flag_reg [2] <= Mem [0] [7];
			 check <= Mem [0]<<1;
			 //Mem [2] <= check [7:0];
			 set_zero <= 1;
			end
	4'b0101: begin          //rs
			 flag_reg [2] <= Mem [0] [0];
			 check <= Mem [0]>>1;
			 //Mem [2] <= check [7:0];
			 set_zero <= 1;
			 end
	4'b0110: begin               //cmp
			 check  <= Mem [1]-Mem [0];
			 //flag_reg [1] <= check [8];
			 set_zero <= 1;
			 set_cmp <= 1;
			 end
	4'b0111: begin  //dec
			 check <= Mem [0] - 1;
			 flag_reg [3] <= check [8];
			 //Mem [2] <= check [7:0];
			 set_zero <= 1;
			 set_ovf <= 1;
			 end
	4'b1001: begin  //inc 
			 check <= Mem [0] + 1;
			 flag_reg [3] <= check [8];
			 //Mem [2] <= check [7:0];
			 set_zero <= 1;
			 set_ovf <= 1;
			 end
endcase
end
end 
end
    
endmodule

///////////////////////////////////////////////////////////////////
module idec(pm_cont,op1,op2,op3,data,opcode,ram_addr);
input [31:0] pm_cont;
output [2:0] op1,op2,op3;
output [7:0] data;
output [4:0] opcode;
output [9:0] ram_addr;
assign data = pm_cont [21:14];
assign op1 = pm_cont [13:11];
assign op2 = pm_cont [10:8];
assign op3 = pm_cont [7:5];
assign opcode = pm_cont [4:0];
assign ram_addr = pm_cont [31:22];
endmodule
//////////////////////////////////////////////////////////////
module eucl(clock,op1,op2,op3,data,opcode,dataout,p_c,p_c_out,en_ram,wram,str,ld_m);
input [7:0] p_c;
input [7:0] data;
input [2:0] op1,op2,op3;
input [4:0] opcode;
output [7:0] p_c_out;
wire [3:0] flag;
output reg en_ram,wram,str,ld_m;
reg [7:0] branch;
reg p_c_val,cint; 
input clock;
output [7:0] dataout;
reg ld,write,en_alu,en_mem;
reg [2:0] addr;
reg [3:0] control_bus;
reg [4:0] state = 5'b00000;
assign p_c_out = cint ? branch : p_c + p_c_val;
initial 
begin 
p_c_val = 0;
branch=0;
cint=0;
ld_m=0;
str=0;
ld=0;
write=0;
en_alu=0;
en_mem=0;
branch = 0;
wram=0;
en_ram=0;
end
exec_unit EU(.clock(clock),.ld(ld),.write(write),.en_alu(en_alu),.en_mem(en_mem),.addr(addr),.indata(data),.outdata(dataout),.f_select(control_bus),.flag_reg(flag));

always @(posedge clock)
begin

cint <=0;
ld<=0;
write<=0;
en_alu<=0;
en_mem <=0;
p_c_val<=0;
wram <= 0;
en_ram <= 0;
branch <= data;
str <= 0;
ld_m <= 0;

if (state==5'b01111) //PFCL
begin
state<=5'b00000;
p_c_val<=1;
end 

else if (state==5'b11111) //PFCL
begin
cint <= 1;
state <= 5'b00000;
end

else if(opcode==5'b00001) // move
begin
if (state==5'b00000)
begin
addr <= op1;
en_mem <= 1;
state <= 5'b00001;
end 
else if (state==5'b00001)
begin
addr <=op2;
en_mem <= 1;
write <= 1;
state <= 5'b01111;
end
end

else if (opcode==5'b00010) //load immediate
begin
if (state==5'b00000)
begin
addr <= op1;
ld <= 1;
en_mem <= 1;
write <= 1;
state <= 5'b01111;
end
end

else if (opcode==5'b00011) //add
begin
if (state==5'b00000)
begin
addr <= op1;
en_mem <= 1;
state <= 5'b00001;
end 
else if (state==5'b00001)
begin
addr <=3'b000;
en_mem <= 1;
write <= 1;
state <= 5'b00010;
end
else if (state==5'b00010)
begin
addr <= op2;
en_mem <= 1;
state <= 5'b00011;
end 
else if (state==5'b00011)
begin
addr <=3'b001;
en_mem <= 1;
write <= 1;
state <= 5'b00100;
end
else if (state==5'b00100)
begin
control_bus <= 4'b0000;
en_alu <= 1 ;
state <= 5'b00101;
end
else if (state==5'b00101)
begin
en_alu <=1;
state<=5'b00110;
end
else if (state==5'b00110)
begin
addr <= 3'b000 ;
en_mem <= 1;
state <= 5'b00111;
end
else if (state==5'b00111)
begin
addr <= op3;
en_mem <= 1;
write <= 1;
state <= 5'b01111;
end
end

else if (opcode==5'b00100) //sub
begin
if (state==5'b00000)
begin
addr <= op1;
en_mem <= 1;
state <= 5'b00001;
end 
else if (state==5'b00001)
begin
addr <=3'b000;
en_mem <= 1;
write <= 1;
state <= 5'b00010;
end
else if (state==5'b00010)
begin
addr <= op2;
en_mem <= 1;
state <= 5'b00011;
end 
else if (state==5'b00011)
begin
addr <=3'b001;
en_mem <= 1;
write <= 1;
state <= 5'b00100;
end
else if (state==5'b00100)
begin
control_bus <= 4'b0001;
en_alu <= 1 ;
state <= 5'b00101;
end
else if (state==5'b00101)
begin
en_alu <=1;
state<=5'b00110;
end
else if (state==5'b00110)
begin
addr <= 3'b000 ;
en_mem <= 1;
state <= 5'b00111;
end
else if (state==5'b00111)
begin
addr <= op3;
en_mem <= 1;
write <= 1;
state <= 5'b01111;
end
end

else if (opcode==5'b00101) //and
begin
if (state==5'b00000)
begin
addr <= op1;
en_mem <= 1;
state <= 5'b00001;
end 
else if (state==5'b00001)
begin
addr <=3'b000;
en_mem <= 1;
write <= 1;
state <= 5'b00010;
end
else if (state==5'b00010)
begin
addr <= op2;
en_mem <= 1;
state <= 5'b00011;
end 
else if (state==5'b00011)
begin
addr <=3'b001;
en_mem <= 1;
write <= 1;
state <= 5'b00100;
end
else if (state==5'b00100)
begin
control_bus <= 4'b0010;
en_alu <= 1 ;
state <= 5'b00101;
end
else if (state==5'b00101)
begin
en_alu <=1;
state<=5'b00110;
end
else if (state==5'b00110)
begin
addr <= 3'b000 ;
en_mem <= 1;
state <= 5'b00111;
end
else if (state==5'b00111)
begin
addr <= op3;
en_mem <= 1;
write <= 1;
state <= 5'b01111;
end
end

else if (opcode==5'b00110) //or
begin
if (state==5'b00000)
begin
addr <= op1;
en_mem <= 1;
state <= 5'b00001;
end 
else if (state==5'b00001)
begin
addr <=3'b000;
en_mem <= 1;
write <= 1;
state <= 5'b00010;
end
else if (state==5'b00010)
begin
addr <= op2;
en_mem <= 1;
state <= 5'b00011;
end 
else if (state==5'b00011)
begin
addr <=3'b001;
en_mem <= 1;
write <= 1;
state <= 5'b00100;
end
else if (state==5'b00100)
begin
control_bus <= 4'b0011;
en_alu <= 1 ;
state <= 5'b00101;
end
else if (state==5'b00101)
begin
en_alu <=1;
state<=5'b00110;
end
else if (state==5'b00110)
begin
addr <= 3'b000 ;
en_mem <= 1;
state <= 5'b00111;
end
else if (state==5'b00111)
begin
addr <= op3;
en_mem <= 1;
write <= 1;
state <= 5'b01111;
end
end

else if (opcode==5'b00111) //ls
begin
if (state==5'b00000)
begin
addr <= op1;
en_mem <= 1;
state <= 5'b00001;
end 
else if (state==5'b00001)
begin
addr <=3'b000;
en_mem <= 1;
write <= 1;
state <= 5'b00010;
end
else if (state==5'b00010)
begin
control_bus <= 4'b0100;
en_alu <= 1 ;
state <= 5'b00011;
end
else if (state==5'b00011)
begin
en_alu <=1;
state<=5'b00100;
end
else if (state==5'b00100)
begin
addr <= 3'b000 ;
en_mem <= 1;
state <= 5'b00101;
end
else if (state==5'b00101)
begin
addr <= op1;
en_mem <= 1;
write <= 1;
state <= 5'b01111;
end
end

else if (opcode==5'b01001) //rs
begin
if (state==5'b00000)
begin
addr <= op1;
en_mem <= 1;
state <= 5'b00001;
end 
else if (state==5'b00001)
begin
addr <=3'b000;
en_mem <= 1;
write <= 1;
state <= 5'b00010;
end
else if (state==5'b00010)
begin
control_bus <= 4'b0101;
en_alu <= 1 ;
state <= 5'b00011;
end
else if (state==5'b00011)
begin
en_alu <=1;
state<=5'b00100;
end
else if (state==5'b00100)
begin
addr <= 3'b000 ;
en_mem <= 1;
state <= 5'b00101;
end
else if (state==5'b00101)
begin
addr <= op1;
en_mem <= 1;
write <= 1;
state <= 5'b01111;
end
end

else if (opcode==5'b01010) //store
begin
if (state==5'b00000)
begin
addr <= op1;
en_mem <= 1;
state <= 5'b00001;
end
else if (state==1)
begin
en_ram <= 1;
wram <= 1;
str <= 1;
state <= 5'b01111;
end
end

else if (opcode==5'b01011) //compare flag set if op1 > op2
begin
if (state==5'b00000)
begin
addr <= op1;
en_mem <= 1;
state <= 5'b00001;
end 
else if (state==5'b00001)
begin
addr <=3'b000;
en_mem <= 1;
write <= 1;
state <= 5'b00010;
end
else if (state==5'b00010)
begin
addr <= op2;
en_mem <= 1;
state <= 5'b00011;
end 
else if (state==5'b00011)
begin
addr <=3'b001;
en_mem <= 1;
write <= 1;
state <= 5'b00100;
end
else if (state==5'b00100)
begin
control_bus <= 4'b0110;
en_alu <= 1 ;
state <= 5'b00101;
end
else if (state==5'b00101)
begin
en_alu <= 1 ;
state <=  5'b01111;
end
end

else if (opcode==5'b01100) //Branch if overflow
begin
if (state==5'b00000)
begin
if (flag [3])
state <= 5'b11111;
else
state <= 5'b01111;
end
end

else if (opcode==5'b01101) //Branch if greater
begin
if (state==5'b00000)
begin
if (flag [1])
state <= 5'b11111;
else
state <= 5'b01111;
end
end

else if (opcode==5'b01110) //Branch if lesser
begin
if (state==5'b00000)
begin
if (!(flag [1]) & !(flag [0]))
state <= 5'b11111;
else
state <= 5'b01111;
end
end

else if (opcode==5'b01111) //Branch if zero (could be used as branch if equal)
begin
if (state==5'b00000)
begin
if (flag [0])
state <= 5'b11111;
else
state <= 5'b01111;
end
end

else if (opcode==5'b10001) //Branch if shifted out bit 
begin
if (state==5'b00000)
begin
if (flag [2])
state <= 5'b11111;
else
state <= 5'b01111;
end
end

else if (opcode==5'b10010) //Jump
begin
if (state==5'b00000)
state <= 5'b11111;
end

else if (opcode==5'b10011) //load from memory
begin
if (state==5'b00000)
begin
en_ram <= 1;
ld_m <= 1;  
state <= 5'b00001;
end
else if (state==5'b00001)
begin
ld_m <= 1;
en_ram <= 1;
addr <= op1;
ld <= 1;
en_mem <= 1;
write <= 1;
state <= 5'b01111;
end
end

else if (opcode==5'b10100) // Load memory (RAM) immediate
begin
en_ram <= 1;
wram <= 1;
state <= 5'b01111;
end

else if (opcode==5'b10101) //Inc
begin
if (state==0)
begin
addr <= op1;
en_mem <= 1;
state <= 1;
end
else if (state==1)
begin
addr <= 3'b000;
en_mem <= 1;
write <= 1;
state <= 2;
end
else if (state==2)
begin
en_alu <= 1;
control_bus <= 4'b1001;
state <= 3;
end
else if (state==3)
begin
en_alu <= 1;
state <= 4;
end
else if (state==4)
begin
addr <= 3'b000;
en_mem <= 1;
state <= 5; 
end
else if (state==5)
begin
addr <= op1;
en_mem <= 1;
write <= 1;
state <= 5'b01111;
end
end

else if (opcode==5'b10110) //Dec
begin
if (state==0)
begin
addr <= op1;
en_mem <= 1;
state <= 1;
end
else if (state==1)
begin
addr <= 3'b000;
en_mem <= 1;
write <= 1;
state <= 2;
end
else if (state==2)
begin
en_alu <= 1;
control_bus <= 4'b0111;
state <= 3;
end
else if (state==3)
begin
en_alu <= 1;
state <= 4;
end
else if (state==4)
begin
addr <= 3'b000;
en_mem <= 1;
state <= 5; 
end
else if (state==5)
begin
addr <= op1;
en_mem <= 1;
write <= 1;
state <= 5'b01111;
end
end

end
endmodule
////////////////////////////////////////////////////////
module program_memory(p_c,instr);
input [7:0] p_c;
reg [31:0] p_m [0:255];
output [31:0] instr;
initial begin
p_m [0] = 32'b00000000000000001000000000010100;
p_m [1] = 32'b00000000010000001100000000010100;
p_m [2] = 32'b00000000000000000010000000010011;
p_m [3] = 32'b00000000010000000010100000010011;
p_m [4] = 32'b00000000000000000010010101000100;
p_m [5] = 32'b00000000100000000001000000001010;
p_m [6] = 32'b00000000110000000010000000001010;
p_m [7] = 32'b00000000000000000000000000000000;
end
assign instr = p_m [p_c];
endmodule
///////////////////////////////////////////////////////
module control_unit(clock,data_out);
input clock;
output [7:0] data_out;
wire [9:0] ram_ad;
reg [7:0] p_c = 0;
wire [7:0] pfcl,data,ram_out,ram_in,data_eucl;
wire [2:0] op1,op2,op3;
wire [4:0] opcode;
wire [31:0] instr;
wire en_ram,ram_w,str,ld_m;
assign ram_in = str ? data_out : data;  //store vs load immediate
assign data_eucl = ld_m ? ram_out : data; //load immediate reg vs load  
program_memory PM(.p_c(pfcl),.instr(instr));
idec IDE(.pm_cont(instr),.op1(op1),.op2(op2),.op3(op3),.data(data),.opcode(opcode),.ram_addr(ram_ad));
eucl EUCL(.clock(clock),.op1(op1),.op2(op2),.op3(op3),.data(data_eucl),.opcode(opcode),.dataout(data_out),.p_c(p_c),.p_c_out(pfcl),.en_ram(en_ram),.wram(ram_w),.str(str),.ld_m(ld_m));
main_memory RAM(.clock(clock),.enable(en_ram),.Write(ram_w),.Address(ram_ad),.DataIn(ram_in),.DataOut(ram_out));
always @(posedge clock)
begin
p_c <= pfcl;
end
endmodule
////////////////////////////////////////////////////////
module main_memory (clock,enable,Write, Address, DataIn, DataOut);
	input clock,Write,enable;
	input [7: 0] DataIn;
	input [9: 0] Address;
	output reg [7: 0] DataOut;
	reg [7: 0] Mem [0: 1023]; // 1024 x 8 memory
	always @ (posedge clock)
    begin
    if (enable)
    begin
		if (Write) 
		Mem [Address] <= DataIn; // Write
		else 
        DataOut <= Mem [Address];
    end
    end
endmodule
///////////////////////////////////////////////////
/* END OF CODE 
/////////////////////////////////////////////////////
SPECIFICATIONS:
6 x 8 internal registers
1024 x 8 RAM
21 Opcodes
4 bit Flag Register
/////////////////////////////////////////////////////
DECODING INSTRUCTIONS:
Each instruction consists of 32 bits.
It could be divided as:
Bits 31:22 RAM Address
Bits 21:14 Data (for immediate loading)
Bits 13:11 Input Operand 1 (register's address)
Bits 10:8 Input Operand 2
Bits 8:6 Output Operand
Bits 5:0 Opcode
//////////////////////////////////////////////////////
OPCODES:
1 00001  move
2 00010 load register (immediate data)
3 00011 add
4 00100 sub
5 00101 and
6 00110 or
7 00111 ls
8 01001 rs
9 01010 store
10 01011 compare flag set if op1 > op2
11 01100 Branch if overflow
12 01101 Branch if greater
13 01110 Branch if lesser
14 01111 Branch if zero (could be used as branch if equal)
15 10001 Branch if shifted out bit 
16 10010 Jump
17 10011 load from memory
18 10100 Load memory (RAM) immediate
19 10101 Inc 
20 10110 Dec 
21 00000 EOP                                       
//////////////////////////////////////////////////////
           END                                      */
//////////////////////////////////////////////////////
