.data 0x0000
.text 0x0000
#.text
start:
addi $a2, $a2, 1
main:
andi $t4, $t9, 1
bne $t4, $zero, switch
j exit
switch: 
addi $t7,$zero,1
 addi $t6,$zero,32767
 sll $t6,$t6,6
slow:
 addi $t7,$t7,1
 bne $t7,$t6,slow
andi $t4, $t9, 1
beq $t4, $zero, exit
andi $t0, $t9, 15
slti $a3, $t0, 2
beq $a3, $a2, case1
slti $a3, $t0, 4
beq $a3, $a2, case2
slti $a3, $t0, 6
beq $a3, $a2, case3
slti $a3, $t0, 8
beq $a3, $a2, case4
slti $a3, $t0, 10
beq $a3, $a2, case5
slti $a3, $t0, 12
beq $a3, $a2, case6
slti $a3, $t0, 14
beq $a3, $a2, case7
slti $a3, $t0, 16
beq $a3, $a2, case8
j switch
case1:
srl $a1, $t9, 4
andi $a1, $a1, 255
srl $a0, $t9, 12 #a0 x, a1 y
j switch
case2:
addu $t8, $a0, $a1
j switch
case3:
subu $t8, $a0, $a1
j switch
case4:
sllv $t8, $a0, $a1
j switch
case5:
srlv $t8, $a0, $a1
j switch
case6:
slt $t8, $a1, $a0
j switch
case7:
and $t8, $a0, $a1
j switch
case8:
xor $t8, $a0, $a1
j switch
exit:
j main