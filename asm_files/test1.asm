.data 
.text 
#.text.data 
start:
 addi $a2, $a2, 1
main:
andi $t4, $t9, 1
bne $t4, $zero, switch
 j exit
switch:
 addi $t7,$zero,1
 addi $t6,$zero,32767
 sll $t6,$t6,9
slow:
 addi $t7,$t7,1
 bne $t7,$t6,slow
andi $t4, $t9, 1
 beq $t4, $zero, exit
 andi $a0, $t9, 15
 slti $a1, $a0, 2
 beq $a1, $a2, case1
 slti $a1, $a0, 4
 beq $a1, $a2, case2
 slti $a1, $a0, 6
 beq $a1, $a2, case3
 slti $a1, $a0, 8
 beq $a1, $a2, case4
 slti $a1, $a0, 10
 beq $a1, $a2, case5
 slti $a1, $a0, 12
 beq $a1, $a2, case6
 slti $a1, $a0, 14
 beq $a1, $a2, case7
 j switch
 
case1:
 lui $24,21845 
 addi $24,$24,21845
 addi $t7,$zero,1
 addi $t6,$zero,32767
 sll $t6,$t6,9
slow2:
 addi $t7,$t7,1
 bne $t7,$t6,slow2
 nor $t8,$t8,$0
 j switch
case2:
 srl $t8, $t9, 4
 j switch
case3:
 addi $t8, $t8, 1
 j switch
case4:
 sub $t8, $t8, $a2
 j switch
case5:
 sll $t8, $t8, 1
 j switch
case6:
 srl $t8, $t8, 1
 j switch
case7:
 sra $t8, $t8, 1
 j switch
exit:
 j main