# My 8-Bit Microprocessor

# SPECIFICATIONS:
1) 6 x 8 internal registers.
2) 1024 x 8 RAM.
3) 21 Opcodes.
4) 4 bit Flag Register.

# DECODING INSTRUCTIONS:
## Each instruction consists of 32 bits.

### It could be divided as:

1) Bits 31:22 RAM Address .
2) Bits 21:14 Data (for immediate loading) .
3) Bits 13:11 Input Operand 1 (register's address) .
4) Bits 10:8 Input Operand 2 . 
5) Bits 8:6 Output Operand .
6) Bits 5:0 Opcode .

# OPCODES:
1)  00001 move
2)  00010 load register (immediate data)
3)  00011 add
4)  00100 sub
5)  00101 bitwise and
6)  00110 bitwise or
7)  00111 left shift
8)  01001 right shift
9)  01010 store
10) 01011 compare flag set if op1 > op2
11) 01100 branch if overflow
12) 01101 branch if greater
13) 01110 branch if lesser
14) 01111 branch if zero (could be used as branch if equal)
15) 10001 branch if shifted out bit 
16) 10010 jump
17) 10011 load from memory
18) 10100 load memory (RAM) immediate
19) 10101 Inc
20) 10110 Dec
21) 00000 EOP                                       

