import numpy as np 
def opcode(char):
    if (char=="mov"):  
        opcd=str('00001')
    elif (char=="ldr"):
        opcd=str('00010')
    elif (char=="add"):
        opcd=str('00011')
    elif (char=="sub"):
        opcd=str('00100')
    elif (char=="and"):
        opcd=str('00101')
    elif (char=="or" ):
        opcd=str('00110')
    elif (char=="ls" ):
        opcd=str('00111')
    elif (char=="rs" ):
        opcd=str('01001')
    elif (char=="str"):
        opcd=str('01010')
    elif (char=="cmp"):
        opcd=str('01011')
    elif (char=="BIO"):
        opcd=str('01100')
    elif (char=="BIG"):
        opcd=str('01101')
    elif (char=="BIL"):
        opcd=str('01110')
    elif (char=="BEQ"):
        opcd=str('01111')
    elif (char=="BIS"):
        opcd=str('10001') 
    elif (char=="mul"):
        opcd=str('10011')
    elif (char=="div"):
        opcd=str('10100')
    elif (char=="fac"):
        opcd=str('10101')
    elif (char=="ldm"):
        opcd=str('10110')
    elif (char=="sti"):
        opcd=str('10111')
    elif (char=="inc"):
        opcd=str('11000')
    elif (char=="dec"):
        opcd=str('11001')
    elif (char=="EOP"):
        opcd=str('00000')
