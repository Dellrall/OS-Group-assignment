#!/bin/bash
export PS1='\n\[\033[01;31m\]\u@\H:\[\033[02;36m\] \w \$\[\033[00m\] '

title="Equipment Maintenance Menu"
a="A_Add New Computer Lab Equipment Details"
s="S_Search Equipment by Serial Number"
u="U_Update an Equipmement Details"
d="D_Delete an Equipmement Details"
m="M_Sort Equipment by Model"
t="T_Sort Equipment by Status"
p="P_Sort Equipment by Type"
select="Please select a choice: "
selection=($a $s $u $d $m $t $p)

echo -e "$title\n"

echo $a
echo $s
echo $u
echo $d
echo $m
echo $t
echo -e "$p\n"

echo $select
