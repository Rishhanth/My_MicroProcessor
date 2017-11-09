ldr 4,R2
mov R2,R4
fact: dec R2
BEQ end
mov R2,R3
mov R4,R5
//Add
branch: dec R3
BEQ fact
add R4,R5,R4
JMP branch
end: str 10,R4 
EOP  //Rishhanth 