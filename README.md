#My 8-Bit Microprocessor

##SPECIFICATIONS:
6 x 8 internal registers
1024 x 8 RAM
21 Opcodes
4 bit Flag Register

##DECODING INSTRUCTIONS:
Each instruction consists of 32 bits.
It could be divided as:
Bits 31:22 RAM Address
Bits 21:14 Data (for immediate loading)
Bits 13:11 Input Operand 1 (register's address)
Bits 10:8 Input Operand 2
Bits 8:6 Output Operand
Bits 5:0 Opcode

##OPCODES:
1  00001 move
2  00010 load register (immediate data)
3  00011 add
4  00100 sub
5  00101 and
6  00110 or
7  00111 ls
8  01001 rs
9  01010 store
10 01011 compare flag set if op1 > op2
11 01100 Branch if overflow
12 01101 Branch if greater
13 01110 Branch if lesser
14 01111 Branch if zero (could be used as branch if equal)
15 10001 Branch if shifted out bit 
16 10011 multiply
17 10100 divide
18 10101 factorial
19 10110 load from memory
20 10111 Load memory (RAM) immediate
21 00000 EOP                                       

