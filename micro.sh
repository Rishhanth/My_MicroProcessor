#usr/bin/bash
tput smul;
bold=$(tput bold);
tput setaf 6;
echo "8-BIT MICROPROCESSOR"
echo
echo Done by:
tput rmul;
tput setaf 0;
tput sgr0;
echo Rishhanth Maanav V EE16B036
echo Ram Ganesh EE16B034
echo
echo Which Program Do You Want To Run?
tput setaf 5;
echo "${bold}PROGRAM:"; 
read -r filename;
filename=$filename'.asm';
python assembler.py $filename
iverilog -o control_unit test_cu.v microprocessor.V
vvp control_unit
gtkwave test3.vcd&