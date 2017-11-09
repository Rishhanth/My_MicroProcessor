import numpy as np 
import sys

def inst_gen(p_line,bline):
   
    char = p_line[0]
    if len(p_line) > 1:
        opds=p_line[1]
        decd=opds.split(',')
    ram_ad=str('0000000000')
    data=str('00000000')
    op1=str('000')
    op2=str('000')
    op3=str('000')
        
    if (char=="mov"):
        opcd=str('00001')
        op1=decd[0].strip().split('R')[1]
        op2=decd[1].strip().split('R')[1]
        op1=str('{0:03b}'.format(int(op1)))
        op2=str('{0:03b}'.format(int(op2)))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="ldr"):
        opcd=str('00010')
        data=str('{0:08b}'.format(int(decd[0].strip())))
        op1=decd[1].strip().split('R')[1]
        op1=str('{0:03b}'.format(int(op1)))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="add"):
        opcd=str('00011')
        op1=decd[0].strip().split('R')[1]
        op2=decd[1].strip().split('R')[1]
        op3=decd[2].strip().split('R')[1]
        op1=str('{0:03b}'.format(int(op1)))
        op2=str('{0:03b}'.format(int(op2)))
        op3=str('{0:03b}'.format(int(op3)))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="sub"):
        opcd=str('00100')
        op1=decd[0].strip().split('R')[1]
        op2=decd[1].strip().split('R')[1]
        op3=decd[2].strip().split('R')[1]
        op1=str('{0:03b}'.format(int(op1)))
        op2=str('{0:03b}'.format(int(op2)))
        op3=str('{0:03b}'.format(int(op3)))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="and"):
        opcd=str('00101')
        op1=decd[0].strip().split('R')[1]
        op2=decd[1].strip().split('R')[1]
        op3=decd[2].strip().split('R')[1]
        op1=str('{0:03b}'.format(int(op1)))
        op2=str('{0:03b}'.format(int(op2)))
        op3=str('{0:03b}'.format(int(op3)))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="or" ):
        opcd=str('00110')
        op1=decd[0].strip().split('R')[1]
        op2=decd[1].strip().split('R')[1]
        op3=decd[2].strip().split('R')[1]
        op1=str('{0:03b}'.format(int(op1)))
        op2=str('{0:03b}'.format(int(op2)))
        op3=str('{0:03b}'.format(int(op3)))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="ls" ):
        opcd=str('00111')
        op1=decd[0].strip().split('R')[1]
        op1=str('{0:03b}'.format(int(op1)))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="rs" ):
        opcd=str('01001')
        op1=decd[0].strip().split('R')[1]
        op1=str('{0:03b}'.format(int(op1)))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="str"):
        opcd=str('01010')
        ram_ad=str('{0:010b}'.format(int(decd[0].strip())))
        op1=decd[1].strip().split('R')[1]
        op1=str('{0:03b}'.format(int(op1)))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="cmp"):
        opcd=str('01011')
        op1=decd[0].strip().split('R')[1]
        op2=decd[1].strip().split('R')[1]
        op1=str('{0:03b}'.format(int(op1)))
        op2=str('{0:03b}'.format(int(op2)))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="BIO"):
        opcd=str('01100')
        data=str('{0:08b}'.format(int(bline[str(decd[0].strip())])))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="BIG"):
        opcd=str('01101')
        data=str('{0:08b}'.format(int(bline[str(decd[0].strip())])))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="BIL"):
        opcd=str('01110')
        data=str('{0:08b}'.format(int(bline[str(decd[0].strip())])))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="BEQ"):
        opcd=str('01111')
        data=str('{0:08b}'.format(int(bline[str(decd[0].strip())])))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="BIS"):
        opcd=str('10001')
        data=str('{0:08b}'.format(int(bline[str(decd[0].strip())])))
        instr=ram_ad+data+op1+op2+op3+opcd 
    elif (char=="JMP"):
        opcd=str('10010')
        data=str('{0:08b}'.format(int(bline[str(decd[0].strip())])))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="ldm"):
        opcd=str('10011')
        ram_ad=str('{0:010b}'.format(int(decd[0].strip())))
        op1=decd[1].strip().split('R')[1]
        op1=str('{0:03b}'.format(int(op1)))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="sti"):
        opcd=str('10100')
        ram_ad=str('{0:010b}'.format(int(decd[0].strip())))
        data=str('{0:08b}'.format(int(decd[1].strip())))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="inc"):
        opcd=str('10101')
        op1=decd[0].strip().split('R')[1]
        op1=str('{0:03b}'.format(int(op1)))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="dec"):
        opcd=str('10110')
        op1=decd[0].strip().split('R')[1]
        op1=str('{0:03b}'.format(int(op1)))
        instr=ram_ad+data+op1+op2+op3+opcd
    elif (char=="EOP"):
        opcd=str('00000')
        instr=ram_ad+data+op1+op2+op3+opcd
    else:
        print("Invalid Operation")
    return (instr)

def assemble(filein):
    fileout='prog.dat'
    f=open(filein,'r')
    g=open(fileout,'w')
    lines=f.readlines()
    b=[]
    for a in lines:
        b.append(a.rstrip('\n'))
    program_lines=[]
    for line in b:
        pr_lin=line.split("//")[0].strip()  
        if pr_lin:
            program_lines.append(pr_lin)
    branch_lines={}
    code=[]
    instr=[]
    for i,l in enumerate(program_lines):
        line=l.split(':')
        b=line[0].strip()
        if len(line) > 1:
            a=line[0].strip()
            branch_lines[a]=i
            b=line[1].strip()
        code.append(b.split(' ',1))
    for c in code:
            instr.append(inst_gen(c,branch_lines))
    for idx,lines in enumerate(instr):
            if (idx != len(lines)-1):
                g.write(lines + "\n")
            else:
                g.write(lines)                

file1=sys.argv[1]
assemble(file1)