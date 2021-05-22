.data
.str: .asciiz	"9834876DCFB05CB167A5C24953EBA58C"
string	: .space 1024
temp	: .space 1024
rec	: .word 0x00
.text 
start:
	j main
ROTR:                                   # @ROTR
	addiu $29, $29, -24
	addu	$1,$zero,$5
	addu	$2,$zero,$4
	sw	$4, 20($29)
	sw	$5, 16($29)
	lw	$4, 20($29)
	lw	$5, 16($29)
	srlv	$4, $4, $5
	sw	$4, 12($29)
	lw	$4, 16($29)
	addiu	$5, $zero, 32
	subu	$4, $5, $4
	sw	$4, 8($29)
	lw	$4, 20($29)
	lw	$5, 8($29)
	sllv	$4, $4, $5
	lw	$5, 12($29)
	or	$4, $5, $4
	sw	$4, 12($29)
	lw	$4, 12($29)
	sw	$2, 4($29)              # 4-byte Folded Spill
	addu	$2,$zero,$4
	sw	$1, 0($29)              # 4-byte Folded Spill
	addiu	$29, $29, 24
	jr	$ra
	nop
func_end0:
	addiu	$29, $29, -24
	addu	$1,$zero,$5
	addu	$2,$zero,$4
	sw	$4, 20($29)
	sw	$5, 16($29)
	lw	$4, 20($29)
	lw	$5, 16($29)
	srlv	$4, $4, $5
	sw	$4, 12($29)
	lw	$4, 12($29)
	sw	$2, 8($29)              # 4-byte Folded Spill
	addu	$2,$zero,$4
	sw	$1, 4($29)              # 4-byte Folded Spill
	addiu	$29, $29, 24
	jr	$ra
	nop
	
CHX:                                    # @CHX
	addiu	$29, $29, -32
	addu	$1,$zero,$6
	addu	$2,$zero,$5
	addu	$3,$zero,$4
	sw	$4, 28($29)
	sw	$5, 24($29)
	sw	$6, 20($29)
	lw	$4, 28($29)
	lw	$5, 24($29)
	and	$4, $4, $5
	sw	$4, 16($29)
	lw	$4, 28($29)
	nor	$4, $4, $0
	lw	$5, 20($29)
	and	$4, $4, $5
	sw	$4, 12($29)
	lw	$4, 12($29)
	lw	$5, 16($29)
	xor	$4, $5, $4
	sw	$4, 16($29)
	lw	$4, 16($29)
	sw	$2, 8($29)              # 4-byte Folded Spill
	addu	$2,$zero,$4
	sw	$1, 4($29)              # 4-byte Folded Spill
	sw	$3, 0($29)              # 4-byte Folded Spill
	addiu	$29, $29, 32
	jr	$ra
	nop
	
MAJ:                                    # @MAJ
	addiu	$29, $29, -32
	addu	$1,$zero,$6
	addu	$2,$zero,$5
	addu	$3,$zero,$4
	sw	$4, 28($29)
	sw	$5, 24($29)
	sw	$6, 20($29)
	lw	$4, 28($29)
	lw	$5, 24($29)
	and	$4, $4, $5
	sw	$4, 16($29)
	lw	$4, 28($29)
	lw	$5, 20($29)
	and	$4, $4, $5
	sw	$4, 12($29)
	lw	$4, 12($29)
	lw	$5, 16($29)
	xor	$4, $5, $4
	sw	$4, 16($29)
	lw	$4, 24($29)
	lw	$5, 20($29)
	and	$4, $4, $5
	sw	$4, 12($29)
	lw	$4, 12($29)
	lw	$5, 16($29)
	xor	$4, $5, $4
	sw	$4, 16($29)
	lw	$4, 16($29)
	sw	$2, 8($29)              # 4-byte Folded Spill
	addu	$2,$zero,$4
	sw	$1, 4($29)              # 4-byte Folded Spill
	sw	$3, 0($29)              # 4-byte Folded Spill
	addiu	$29, $29, 32
	jr	$ra
	nop
gene:
	lui $t1,4097
	addiu $t5,$25,0
	lui $1,4097
	ori $t2,$1,1057
	LOOP3:
		addi $t7, $zero, 10
		div $t5, $t7
		mfhi $t6
		addi $t6, $t6, 48

        mfhi	$26
        mflo	$27
        or    $23,$t6,$zero  #paramater 1
	addiu   $22,$t2,0     #paramater 0 2
    	addiu 	$19,$zero,4
    	div 	$22,$19
    	mflo 	$18
    	mfhi	$20
    	mult 	$18,$19
    	mflo	$18
	lw	$28, 0($18)
    	addiu 	$19,$zero,8
	mult	$20,$19
    	mflo	$20	
    	addiu	$21,$zero,255	#init 14
    	sllv 	$21,$21,$20
    	nor	$21,$21,$zero	#14  11110000111111111
    	and	$21,$28,$21	#14  0101000010101010
    	sllv 	$22,$23,$20	
    	or	$22,$22,$21
    	sw	$22,0($18)	#paramater 2
        or $t6,$23,$zero #paramater 1
        mthi	$26
        mtlo	$27

		addi $t2, $t2, 1
		mflo $t5
		bgtz $t5, LOOP3
	lui $1,4097
	ori $t6,$1,1057
	REVERSE:
	addi $t2, $t2, -1
    	addiu 	$12,$zero,4
    	div 	$t2,$12
    	mflo 	$11
    	mfhi	$13
    	mult 	$11,$12
    	mflo	$11
	lw	$11, 0($11)
    	addiu 	$12,$zero,8
	mult	$13,$12
    	mflo	$13
    	srlv 	$1,$11,$13
    	andi 	$t7,$1,255
		
        mfhi	$26
        mflo	$27
        or    $23,$t7,$zero  #paramater 1
	addiu   $22,$t1,0     #paramater 0 2
    	addiu 	$19,$zero,4
    	div 	$22,$19
    	mflo 	$18
    	mfhi	$20
    	mult 	$18,$19
    	mflo	$18
	lw	$28, 0($18)
    	addiu 	$19,$zero,8
	mult	$20,$19
    	mflo	$20	
    	addiu	$21,$zero,255	#init 14
    	sllv 	$21,$21,$20
    	nor	$21,$21,$zero	#14  11110000111111111
    	and	$21,$28,$21	#14  0101000010101010
    	sllv 	$22,$23,$20	
    	or	$22,$22,$21
    	sw	$22,0($18)	#paramater 2
        or $t7,$23,$zero #paramater 1
        mthi	$26
        mtlo	$27
        
		addi $t1, $t1, 1
		bne $t6, $t2, REVERSE
	j main

main:                                   # @main
	addiu	$29, $29, -192
	sw	$ra, 188($29)           # 4-byte Folded Spill
	sw	$30, 184($29)           # 4-byte Folded Spill
	addu	$30,$zero,$29
	sw	$zero, 180($30)
	lui $1,4097
	sw	$1, 176($30)
	lw	$1, 176($30)
	sw	$1, 172($30)
	sw	$zero, 168($30)
	j	BB4_1
	nop
BB4_1:                                 # =>This Inner Loop Header: Depth=1
	lw	$1, 176($30)
	lw	$2, 168($30)
	addu	$1, $1, $2

    	addiu 	$12,$zero,4
    	div 	$1,$12
    	mflo 	$11
    	mfhi	$13
    	mult 	$11,$12
    	mflo	$11
	lw	$11, 0($11)
    	addiu 	$12,$zero,8
	mult	$13,$12
    	mflo	$13
    	srlv 	$1,$11,$13
    	andi 	$1,$1,255

	beq	$1,$zero, BB4_4
	nop
	j	BB4_3
	nop
BB4_3:                                 #   in Loop: Header=BB4_1 Depth=1
	lw	$1, 168($30)
	addiu	$1, $1, 1
	sw	$1, 168($30)
	j	BB4_1
	nop
BB4_4:
	lw	$1, 172($30)
	sw	$1, 164($30)
	sw	$zero, 96($30)
	j	BB4_5
	nop
BB4_5:                                 # =>This Inner Loop Header: Depth=1
	lw	$1, 96($30)
	slti	$1, $1, 64
	beq	$1,$zero, BB4_9
	nop
	j	BB4_7
	nop
BB4_7:                                 #   in Loop: Header=BB4_5 Depth=1
	lw	$1, 96($30)
	addiu	$2, $30, 100
	addu	$1, $2, $1
	addiu	$2, $zero, 0
	
        mfhi	$26
        mflo	$27
	    addiu   $1,$1,0
    	addiu 	$12,$zero,4
    	div 	$1,$12
    	mflo 	$11
    	mfhi	$13
    	mult 	$11,$12
    	mflo	$11
	    lw	$15, 0($11)
    	addiu 	$12,$zero,8
	    mult	$13,$12
    	mflo	$13
    	addiu	$14,$zero,24
    	sub	$13,$14,$13	#13 1->24 2->16  	
    	addiu	$14,$zero,255	#init 14
    	sllv 	$14,$14,$13
    	nor	$14,$14,$zero	#14  11110000111111111
    	and	$14,$15,$14	#14  0101000010101010
    	sllv 	$1,$zero,$13	#paramater zero
    	or	$1,$1,$14
    	sw	$1,0($11)	#paramater 1
        mthi	$26
        mtlo	$27
	
	sw	$2, 32($30)             # 4-byte Folded Spill
	j	BB4_8
	nop
BB4_8:                                 #   in Loop: Header=BB4_5 Depth=1
	lw	$1, 96($30)
	addiu	$1, $1, 1
	sw	$1, 96($30)
	j	BB4_5
	nop
BB4_9:
	sw $zero, 92($30)
sw $zero, 88($30)
sw $zero, 84($30)
sw $zero, 80($30)
lui $1, 27145
ori $1,  $1, 0xe667
sw $1, 48($30)
lui $1, 0xbb67
ori $1,  $1, 0xae85
sw $1, 52($30)
lui $1, 15470
addiu $2, $zero,30000
addiu $2, $2,32322
or $1,  $1,  $2
sw $1, 56($30)
lui $1, 0xa54f
ori $1,  $1, 0xf53a
sw $1, 60($30)
lui $1, 20750
ori $1,  $1, 21119
sw $1, 64($30)
lui $1, 0x9b05
ori $1,  $1, 26764
sw $1, 68($30)
lui $1, 8067
ori $1,  $1, 0xd9ab
sw $1, 72($30)
lui $1, 23520
ori $1,  $1, 0xcd19
sw $1, 76($30)
sw $zero, 84($30)
lw $1, 168($30)
sw $1, 80($30)
lw $1, 80($30)
sltiu $1,  $1, 56
beq $1, $zero, BB4_12
	nop
	j	BB4_11
	nop
BB4_11:
	addiu	$1, $zero, 64
	sw	$1, 92($30)
	j	BB4_13
	nop
BB4_12:
	addiu	$1, $zero, 128
	sw	$1, 92($30)
	j	BB4_13
	nop
BB4_13:
	sw	$zero, 44($30)
	j	BB4_14
	nop
BB4_14:                                # =>This Inner Loop Header: Depth=1
	lw	$1, 44($30)
	lw	$2, 80($30)
	sltu	$1, $1, $2
	beq	$1,$zero, BB4_18
	nop
	j	BB4_16
	nop
BB4_16:                                #   in Loop: Header=BB4_14 Depth=1
	lw	$1, 84($30)
	sll	$1, $1, 6
	lw	$2, 44($30)
	addu	$1, $1, $2
	sw	$1, 40($30)
	lw	$1, 164($30)
	lw	$2, 40($30)
	addu	$1, $1, $2
	
    	addiu 	$12,$zero,4
    	div 	$1,$12
    	mflo 	$11
    	mfhi	$13
    	mult 	$11,$12
    	mflo	$11
	lw	$11, 0($11)
    	addiu 	$12,$zero,8
	mult	$13,$12
    	mflo	$13
    	srlv 	$1,$11,$13
    	andi 	$1,$1,255
    	
	lw	$2, 44($30)
	addiu	$3, $30, 100
	addu	$2, $3, $2
	

        #s1b	$1, 0($2)
        mfhi	$26
        mflo	$27
        or    $23,$1,$zero  #paramater 1
	addiu   $22,$2,0     #paramater 0 2
    	addiu 	$19,$zero,4
    	div 	$22,$19
    	mflo 	$18
    	mfhi	$20
    	mult 	$18,$19
    	mflo	$18
	lw	$28, 0($18)
    	addiu 	$19,$zero,8
	mult	$20,$19
    	mflo	$20	
    	addiu	$21,$zero,255	#init 14
    	sllv 	$21,$21,$20
    	nor	$21,$21,$zero	#14  11110000111111111
    	and	$21,$28,$21	#14  0101000010101010
    	sllv 	$22,$23,$20	
    	or	$22,$22,$21
    	sw	$22,0($18)	#paramater 2
        or $1,$23,$zero #paramater 1
        mthi	$26
        mtlo	$27

	j	BB4_17
	nop
BB4_17:                                #   in Loop: Header=BB4_14 Depth=1
	lw	$1, 44($30)
	addiu	$1, $1, 1
	sw	$1, 44($30)
	j	BB4_14
	nop
BB4_18:
	lw	$1, 80($30)
	addiu	$2, $30, 100
	addu	$1, $2, $1
	addiu	$3, $zero, 128
        mfhi	$26
        mflo	$27
        or    $23,$3,$zero  #paramater 1
	addiu   $22,$1,0     #paramater 0 2
    	addiu 	$19,$zero,4
    	div 	$22,$19
    	mflo 	$18
    	mfhi	$20
    	mult 	$18,$19
    	mflo	$18
	lw	$28, 0($18)
    	addiu 	$19,$zero,8
	mult	$20,$19
    	mflo	$20
    	addiu	$21,$zero,255	#init 14
    	sllv 	$21,$21,$20
    	nor	$21,$21,$zero	#14  11110000111111111
    	and	$21,$28,$21	#14  0101000010101010
    	sllv 	$22,$23,$20	
    	or	$22,$22,$21
    	sw	$22,0($18)	#paramater 2
        or $3,$23,$zero #paramater 1
        mthi	$26
        mtlo	$27

	lw	$1, 168($30)
	sll	$1, $1, 3
	sw	$1, 36($30)

        addiu   $1,$30,39
    	addiu 	$12,$zero,4
    	div 	$1,$12
    	mflo 	$11
    	mfhi	$13
    	mult 	$11,$12
    	mflo	$11
	    lw	$11, 0($11)
    	addiu 	$12,$zero,8
	    mult	$13,$12
    	mflo	$13
    	srlv 	$1,$11,$13
    	andi 	$1,$1,255

	lw	$3, 92($30)
	addu	$3, $2, $3
        mfhi	$26
        mflo	$27
        or    $23,$1,$zero  #paramater 1
	addi   $22,$3,-4     #paramater 0 2
    	addiu 	$19,$zero,4
    	div 	$22,$19
    	mflo 	$18
    	mfhi	$20
    	mult 	$18,$19
    	mflo	$18
	lw	$28, 0($18)
    	addiu 	$19,$zero,8
	mult	$20,$19
    	mflo	$20
    	addiu	$21,$zero,255	#init 14
    	sllv 	$21,$21,$20
    	nor	$21,$21,$zero	#14  11110000111111111
    	and	$21,$28,$21	#14  0101000010101010
    	sllv 	$22,$23,$20	
    	or	$22,$22,$21
    	sw	$22,0($18)
        or $1,$23,$zero #paramater 1
        mthi	$26
        mtlo	$27

	lhu	$1, 38($30)
	lw	$3, 92($30)
	addu	$3, $2, $3
	#s1b	$1, -3($3)

        mfhi	$26
        mflo	$27
        or    $23,$1,$zero  #paramater 1
	addi   $22,$3,-3     #paramater 0 2
    	addiu 	$19,$zero,4
    	div 	$22,$19
    	mflo 	$18
    	mfhi	$20
    	mult 	$18,$19
    	mflo	$18
	lw	$28, 0($18)
    	addiu 	$19,$zero,8
	mult	$20,$19
    	mflo	$20
    	addiu	$21,$zero,255	#init 14
    	sllv 	$21,$21,$20
    	nor	$21,$21,$zero	#14  11110000111111111
    	and	$21,$28,$21	#14  0101000010101010
    	sllv 	$22,$23,$20	
    	or	$22,$22,$21
    	sw	$22,0($18)
        or $1,$23,$zero #paramater 1
        mthi	$26
        mtlo	$27

	lw	$1, 36($30)
	srl	$1, $1, 8
	lw	$3, 92($30)
	addu	$3, $2, $3
        mfhi	$26
        mflo	$27
        or    $23,$1,$zero  #paramater 1
	addi   $22,$3,-2     #paramater 0 2
    	addiu 	$19,$zero,4
    	div 	$22,$19
    	mflo 	$18
    	mfhi	$20
    	mult 	$18,$19
    	mflo	$18
	lw	$28, 0($18)
    	addiu 	$19,$zero,8
	mult	$20,$19
    	mflo	$20
    	addiu	$21,$zero,255	#init 14
    	sllv 	$21,$21,$20
    	nor	$21,$21,$zero	#14  11110000111111111
    	and	$21,$28,$21	#14  0101000010101010
    	sllv 	$22,$23,$20	
    	or	$22,$22,$21
    	sw	$22,0($18)
        or $1,$23,$zero #paramater 1
        mthi	$26
        mtlo	$27

	lw	$1, 36($30)
	lw	$3, 92($30)
	addu	$2, $2, $3
        mfhi	$26
        mflo	$27
        or    $23,$1,$zero  #paramater 1
	addi   $22,$2,-1     #paramater 0 2
    	addiu 	$19,$zero,4
    	div 	$22,$19
    	mflo 	$18
    	mfhi	$20
    	mult 	$18,$19
    	mflo	$18
	lw	$28, 0($18)
    	addiu 	$19,$zero,8
	mult	$20,$19
    	mflo	$20
    	addiu	$21,$zero,255	#init 14
    	sllv 	$21,$21,$20
    	nor	$21,$21,$zero	#14  11110000111111111
    	and	$21,$28,$21	#14  0101000010101010
    	sllv 	$22,$23,$20	
    	or	$22,$22,$21
    	sw	$22,0($18)
        or $1,$23,$zero #paramater 1
        mthi	$26
        mtlo	$27
	sw	$zero, 88($30)
	j	BB4_19
	nop
BB4_19:                                # =>This Inner Loop Header: Depth=1
	lw	$1, 88($30)
	lw	$2, 84($30)
	sltu	$1, $1, $2
	beq	$1,$zero, BB4_23
	nop
	j	BB4_21
	nop
BB4_21:                                #   in Loop: Header=BB4_19 Depth=1
	lw	$4, 164($30)
	addiu	$5, $30, 48
	jal	ztransform
	nop
	lw	$4, 164($30)
	addiu	$4, $4, 64
	sw	$4, 164($30)
	sw	$2, 28($30)             # 4-byte Folded Spill
	j	BB4_22
	nop
BB4_22:                                #   in Loop: Header=BB4_19 Depth=1
	lw	$1, 88($30)
	addiu	$1, $1, 1
	sw	$1, 88($30)
	j	BB4_19
	nop
BB4_23:
	addiu	$1, $30, 100
	sw	$1, 164($30)
	lw	$1, 92($30)
	srl	$1, $1, 6
	sw	$1, 84($30)
	sw	$zero, 88($30)
	j	BB4_24
	nop
BB4_24:                                # =>This Inner Loop Header: Depth=1
	lw	$1, 88($30)
	lw	$2, 84($30)
	sltu	$1, $1, $2
	beq	$1,$zero, BB4_28
	nop
	j	BB4_26
	nop
BB4_26:                                #   in Loop: Header=BB4_24 Depth=1
	lw	$4, 164($30)
	addiu	$5, $30, 48
	jal	ztransform
	nop
	lw	$4, 164($30)
	addiu	$4, $4, 64
	sw	$4, 164($30)
	sw	$2, 24($30)             # 4-byte Folded Spill
	j	BB4_27
	nop
BB4_27:                                #   in Loop: Header=BB4_24 Depth=1
	lw	$1, 88($30)
	addiu	$1, $1, 1
	sw	$1, 88($30)
	j	BB4_24
	nop
BB4_28:
	lw	$4, 48($30)
	lw	$24, 48($30)
	#li $v0,1
	#syscall
	j gene
	j func_end5
func_end4:
          nop                              # -- End function
ztransform:                             # @ztransform
	addiu	$29, $29, -648
	sw	$ra, 644($29)           # 4-byte Folded Spill
	sw	$30, 640($29)           # 4-byte Folded Spill
	addu	$30,$zero,$29
	addu	$1,$zero,$5
	addu	$2,$zero,$4
	sw $4, 636($30)
sw $4, 636($30)
sw $5, 632($30)
lui $4, 17034
ori $4,  $4, 12184
sw $4, 376($30)
lui $4, 28983
ori $4,  $4, 17553
sw $4, 380($30)
lui $4, 0xb5c0
addiu $4,  $4, 0xfbcf
sw $4, 384($30)
lui $4, 0xe9b5
ori $4,  $4, 0xdba5
sw $4, 388($30)
lui $4, 14678
ori $4,  $4, 0xc25b
sw $4, 392($30)
lui $4, 23025
ori $4,  $4, 4593
sw $4, 396($30)
lui $4, 0x923f
ori $4,  $4, 0x82a4
sw $4, 400($30)
lui $4, 0xab1c
ori $4,  $4, 24277
sw $4, 404($30)
lui $4, 0xd807
ori $4,  $4, 0xaa98
sw $4, 408($30)
lui $4, 4739
ori $4,  $4, 23297
sw $4, 412($30)
lui $4, 9265
ori $4,  $4, 0x85be
sw $4, 416($30)
lui $4, 21772
ori $4,  $4, 32195
sw $4, 420($30)
lui $4, 29374
ori $4,  $4, 23924
sw $4, 424($30)
lui $4, 0x80de
ori $4,  $4, 0xb1fe
sw $4, 428($30)
lui $4, 0x9bdc
ori $4,  $4, 1703
sw $4, 432($30)
lui $4, 0xc19b
ori $4,  $4, 0xf174
sw $4, 436($30)
lui $4, 0xe49b
ori $4,  $4, 27073
sw $4, 440($30)
lui $4, 0xefbe
ori $4,  $4, 18310
sw $4, 444($30)
lui $4, 4033
ori $4,  $4, 0x9dc6
sw $4, 448($30)
lui $4, 9228
ori $4,  $4, 0xa1cc
sw $4, 452($30)
lui $4, 11753
ori $4,  $4, 11375
sw $4, 456($30)
lui $4, 19060
ori $4,  $4, 0x84aa
sw $4, 460($30)
lui $4, 23728
ori $4,  $4, 0xa9dc
sw $4, 464($30)
lui $4, 30457
ori $4,  $4, 0x88da
sw $4, 468($30)
lui $4, 0x983e
ori $4,  $4, 20818
sw $4, 472($30)
lui $4, 0xa831
ori $4,  $4, 0xc66d
sw $4, 476($30)
lui $4, 0xb003
ori $4,  $4, 10184
sw $4, 480($30)
lui $4, 0xbf59
ori $4,  $4, 32711
sw $4, 484($30)
lui $4, 0xc6e0
ori $4,  $4, 3059
sw $4, 488($30)
lui $4, 0xd5a7
ori $4,  $4, 0x9147
sw $4, 492($30)
lui $4, 1738
ori $4,  $4, 25425
sw $4, 496($30)
lui $4, 5161
ori $4,  $4, 10599
sw $4, 500($30)
lui $4, 10167
ori $4,  $4, 2693
sw $4, 504($30)
lui $4, 11803
ori $4,  $4, 8504
sw $4, 508($30)
lui $4, 19756
ori $4,  $4, 28156
sw $4, 512($30)
lui $4, 21304
ori $4,  $4, 3347
sw $4, 516($30)
lui $4, 25866
ori $4,  $4, 29524
sw $4, 520($30)
lui $4, 30314
ori $4,  $4, 2747
sw $4, 524($30)
lui $4, 0x81c2
ori $4,  $4, 0xc92e
sw $4, 528($30)
lui $4, 0x9272
ori $4,  $4, 11397
sw $4, 532($30)
lui $4, 0xa2bf
ori $4,  $4, 0xe8a1
sw $4, 536($30)
lui $4, 0xa81a
ori $4,  $4, 26187
sw $4, 540($30)
lui $4, 0xc24b
ori $4,  $4, 0x8b70
sw $4, 544($30)
lui $4, 0xc76c
ori $4,  $4, 20899
sw $4, 548($30)
lui $4, 0xd192
ori $4,  $4, 0xe819
sw $4, 552($30)
lui $4, 0xd699
ori $4,  $4, 1572
sw $4, 556($30)
lui $4, 0xf40e
ori $4,  $4, 13701
sw $4, 560($30)
lui $4, 4202
ori $4,  $4, 0xa070
sw $4, 564($30)
lui $4, 6564
ori $4,  $4, 0xc116
sw $4, 568($30)
lui $4, 7735
ori $4,  $4, 27656
sw $4, 572($30)
lui $4, 10056
ori $4,  $4, 30540
sw $4, 576($30)
lui $4, 13488
ori $4,  $4, 0xbcb5
sw $4, 580($30)
lui $4, 14620
ori $4,  $4, 3251
sw $4, 584($30)
lui $4, 20184
ori $4,  $4, 0xaa4a
sw $4, 588($30)
lui $4, 23452
ori $4,  $4, 0xca4f
sw $4, 592($30)
lui $4, 26670
ori $4,  $4, 28659
sw $4, 596($30)
lui $4, 29839
ori $4,  $4, 0x82ee
sw $4, 600($30)
lui $4, 30885
ori $4,  $4, 25455
sw $4, 604($30)
lui $4, 0x84c8
ori $4,  $4, 30740
sw $4, 608($30)
lui $4, 0x8cc7
ori $4,  $4, 520
sw $4, 612($30)
lui $4, 0x90be
ori $4,  $4, 0xfffa
sw $4, 616($30)
lui $4, 0xa450
ori $4,  $4, 27883
sw $4, 620($30)
lui $4, 0xbef9
ori $4,  $4, 0xa3f7
sw $4, 624($30)
lui $4, 0xc671
ori $4,  $4, 30962
sw $4, 628($30)
sw $zero, 76($30)
sw $zero, 72($30)
sw $zero, 76($30)
	sw	$1, 68($30)             # 4-byte Folded Spill
	sw	$2, 64($30)             # 4-byte Folded Spill
	j	BB5_1
	nop
BB5_1:                                 # =>This Inner Loop Header: Depth=1
	lw	$1, 76($30)
	slti	$1, $1, 16
	beq	$1,$zero, BB5_5
	nop
	j	BB5_3
	nop
BB5_3:                                 #   in Loop: Header=BB5_1 Depth=1
	lw	$1, 636($30)
	lw	$2, 72($30)
	addu	$1, $1, $2

        addiu   $1,$1,0
    	addiu 	$12,$zero,4
    	div 	$1,$12
    	mflo 	$11
    	mfhi	$13
    	mult 	$11,$12
    	mflo	$11
	    lw	$11, 0($11)
    	addiu 	$12,$zero,8
	    mult	$13,$12
    	mflo	$13
    	srlv 	$1,$11,$13
    	andi 	$1,$1,255

	sll	$1, $1, 24
	lw	$2, 76($30)
	sll	$2, $2, 2
	addiu	$3, $30, 120
	addu	$2, $3, $2
	sw	$1, 0($2)
	lw	$1, 636($30)
	lw	$2, 72($30)
	addu	$1, $1, $2
    

        addiu   $1,$1,1
    	addiu 	$12,$zero,4
    	div 	$1,$12
    	mflo 	$11
    	mfhi	$13
    	mult 	$11,$12
    	mflo	$11
	    lw	$11, 0($11)
    	addiu 	$12,$zero,8
	    mult	$13,$12
    	mflo	$13
    	srlv 	$1,$11,$13
    	andi 	$1,$1,255

	sll	$1, $1, 16
	lw	$2, 76($30)
	sll	$2, $2, 2
	addu	$2, $3, $2
	lw	$4, 0($2)
	or	$1, $4, $1
	sw	$1, 0($2)
	lw	$1, 636($30)
	lw	$2, 72($30)
	addu	$1, $1, $2
    
        addiu   $1,$1,2
    	addiu 	$12,$zero,4
    	div 	$1,$12
    	mflo 	$11
    	mfhi	$13
    	mult 	$11,$12
    	mflo	$11
	    lw	$11, 0($11)
    	addiu 	$12,$zero,8
	    mult	$13,$12
    	mflo	$13
    	srlv 	$1,$11,$13
    	andi 	$1,$1,255

	sll	$1, $1, 8
	lw	$2, 76($30)
	sll	$2, $2, 2
	addu	$2, $3, $2
	lw	$4, 0($2)
	or	$1, $4, $1
	sw	$1, 0($2)
	lw	$1, 636($30)
	lw	$2, 72($30)
	addu	$1, $1, $2
    
        addiu   $1,$1,3
    	addiu 	$12,$zero,4
    	div 	$1,$12
    	mflo 	$11
    	mfhi	$13
    	mult 	$11,$12
    	mflo	$11
	    lw	$11, 0($11)
    	addiu 	$12,$zero,8
	    mult	$13,$12
    	mflo	$13
    	srlv 	$1,$11,$13
    	andi 	$1,$1,255

	lw	$2, 76($30)
	sll	$2, $2, 2
	addu	$2, $3, $2
	lw	$3, 0($2)
	or	$1, $3, $1
	sw	$1, 0($2)
	lw	$1, 72($30)
	addiu	$1, $1, 4
	sw	$1, 72($30)
	j	BB5_4
	nop
BB5_4:                                 #   in Loop: Header=BB5_1 Depth=1
	lw	$1, 76($30)
	addiu	$1, $1, 1
	sw	$1, 76($30)
	j	BB5_1
	nop
BB5_5:
	addiu	$1, $zero, 16
	sw	$1, 76($30)
	j	BB5_6
	nop
BB5_6:                                 # =>This Inner Loop Header: Depth=1
	lw	$1, 76($30)
	slti	$1, $1, 64
	beq	$1,$zero, BB5_10
	nop
	j	BB5_8
	nop
BB5_8:                                 #   in Loop: Header=BB5_6 Depth=1
	lw	$1, 76($30)
	sll	$1, $1, 2
	addiu	$2, $30, 120
	addu	$1, $2, $1
	lw	$4, -8($1)
	addiu	$5, $zero, 17
	sw	$2, 60($30)             # 4-byte Folded Spill
	jal	ROTR
	nop
	lw	$1, 76($30)
	sll	$1, $1, 2
	lw	$4, 60($30)             # 4-byte Folded Reload
	addu	$1, $4, $1
	lw	$4, -8($1)
	addiu	$5, $zero, 19
	sw	$2, 56($30)             # 4-byte Folded Spill
	jal	ROTR
	nop
	lw	$1, 56($30)             # 4-byte Folded Reload
	xor	$2, $1, $2
	lw	$4, 76($30)
	sll	$4, $4, 2
	lw	$5, 60($30)             # 4-byte Folded Reload
	addu	$4, $5, $4
	lw	$4, -8($4)
	addiu	$5, $zero, 10
	sw	$2, 52($30)             # 4-byte Folded Spill
	jal	func_end0
	nop
	lw	$1, 52($30)             # 4-byte Folded Reload
	xor	$1, $1, $2
	lw	$2, 76($30)
	sll	$2, $2, 2
	lw	$4, 60($30)             # 4-byte Folded Reload
	addu	$2, $4, $2
	sw	$1, 0($2)
	lw	$1, 76($30)
	sll	$1, $1, 2
	addu	$1, $4, $1
	lw	$2, -28($1)
	lw	$5, 0($1)
	addu	$2, $5, $2
	sw	$2, 0($1)
	lw	$1, 76($30)
	sll	$1, $1, 2
	addu	$1, $4, $1
	lw	$4, -60($1)
	addiu	$5, $zero, 7
	jal	ROTR
	nop
	lw	$1, 76($30)
	sll	$1, $1, 2
	lw	$4, 60($30)             # 4-byte Folded Reload
	addu	$1, $4, $1
	lw	$4, -60($1)
	addiu	$5, $zero, 18
	sw	$2, 48($30)             # 4-byte Folded Spill
	jal	ROTR
	nop
	lw	$1, 48($30)             # 4-byte Folded Reload
	xor	$2, $1, $2
	lw	$4, 76($30)
	sll	$4, $4, 2
	lw	$5, 60($30)             # 4-byte Folded Reload
	addu	$4, $5, $4
	lw	$4, -60($4)
	addiu	$5, $zero, 3
	sw	$2, 44($30)             # 4-byte Folded Spill
	jal	func_end0
	nop
	lw	$1, 44($30)             # 4-byte Folded Reload
	xor	$1, $1, $2
	lw	$2, 76($30)
	sll	$2, $2, 2
	lw	$4, 60($30)             # 4-byte Folded Reload
	addu	$2, $4, $2
	lw	$5, 0($2)
	addu	$1, $5, $1
	sw	$1, 0($2)
	lw	$1, 76($30)
	sll	$1, $1, 2
	addu	$1, $4, $1
	lw	$2, -64($1)
	lw	$5, 0($1)
	addu	$2, $5, $2
	sw	$2, 0($1)
	j	BB5_9
	nop
BB5_9:                                 #   in Loop: Header=BB5_6 Depth=1
	lw	$1, 76($30)
	addiu	$1, $1, 1
	sw	$1, 76($30)
	j	BB5_6
	nop
BB5_10:
	lw	$1, 632($30)
	lw	$1, 0($1)
	sw	$1, 116($30)
	lw	$1, 632($30)
	lw	$1, 4($1)
	sw	$1, 112($30)
	lw	$1, 632($30)
	lw	$1, 8($1)
	sw	$1, 108($30)
	lw	$1, 632($30)
	lw	$1, 12($1)
	sw	$1, 104($30)
	lw	$1, 632($30)
	lw	$1, 16($1)
	sw	$1, 100($30)
	lw	$1, 632($30)
	lw	$1, 20($1)
	sw	$1, 96($30)
	lw	$1, 632($30)
	lw	$1, 24($1)
	sw	$1, 92($30)
	lw	$1, 632($30)
	lw	$1, 28($1)
	sw	$1, 88($30)
	sw	$zero, 76($30)
	j	BB5_11
	nop
BB5_11:                                # =>This Inner Loop Header: Depth=1
	lw	$1, 76($30)
	slti	$1, $1, 64
	beq	$1,$zero, BB5_15
	nop
	j	BB5_13
	nop
BB5_13:                                #   in Loop: Header=BB5_11 Depth=1
	lw	$1, 88($30)
	lw	$4, 100($30)
	addiu	$5, $zero, 6
	sw	$1, 40($30)             # 4-byte Folded Spill
	jal	ROTR
	nop
	lw	$4, 100($30)
	addiu	$5, $zero, 11
	sw	$2, 36($30)             # 4-byte Folded Spill
	jal	ROTR
	nop
	lw	$1, 36($30)             # 4-byte Folded Reload
	xor	$2, $1, $2
	lw	$4, 100($30)
	addiu	$5, $zero, 25
	sw	$2, 32($30)             # 4-byte Folded Spill
	jal	ROTR
	nop
	lw	$1, 32($30)             # 4-byte Folded Reload
	xor	$1, $1, $2
	lw	$2, 40($30)             # 4-byte Folded Reload
	addu	$1, $2, $1
	lw	$4, 100($30)
	lw	$5, 96($30)
	lw	$6, 92($30)
	sw	$1, 28($30)             # 4-byte Folded Spill
	jal	CHX
	nop
	lw	$1, 28($30)             # 4-byte Folded Reload
	addu	$1, $1, $2
	lw	$2, 76($30)
	sll	$2, $2, 2
	addiu	$4, $30, 376
	addu	$4, $4, $2
	lw	$4, 0($4)
	addu	$1, $1, $4
	addiu	$4, $30, 120
	addu	$2, $4, $2
	lw	$2, 0($2)
	addu	$1, $1, $2
	sw	$1, 84($30)
	lw	$4, 116($30)
	addiu	$5, $zero, 2
	jal	ROTR
	nop
	lw	$4, 116($30)
	addiu	$5, $zero, 13
	sw	$2, 24($30)             # 4-byte Folded Spill
	jal	ROTR
	nop
	lw	$1, 24($30)             # 4-byte Folded Reload
	xor	$2, $1, $2
	lw	$4, 116($30)
	addiu	$5, $zero, 22
	sw	$2, 20($30)             # 4-byte Folded Spill
	jal	ROTR
	nop
	lw	$1, 20($30)             # 4-byte Folded Reload
	xor	$1, $1, $2
	lw	$4, 116($30)
	lw	$5, 112($30)
	lw	$6, 108($30)
	sw	$1, 16($30)             # 4-byte Folded Spill
	jal	MAJ
	nop
	lw	$1, 16($30)             # 4-byte Folded Reload
	addu	$1, $1, $2
	sw	$1, 80($30)
	lw	$1, 92($30)
	sw	$1, 88($30)
	lw	$1, 96($30)
	sw	$1, 92($30)
	lw	$1, 100($30)
	sw	$1, 96($30)
	lw	$1, 104($30)
	lw	$2, 84($30)
	addu	$1, $1, $2
	sw	$1, 100($30)
	lw	$1, 108($30)
	sw	$1, 104($30)
	lw	$1, 112($30)
	sw	$1, 108($30)
	lw	$1, 116($30)
	sw	$1, 112($30)
	lw	$1, 84($30)
	lw	$2, 80($30)
	addu	$1, $1, $2
	sw	$1, 116($30)
	j	BB5_14
	nop
BB5_14:                                #   in Loop: Header=BB5_11 Depth=1
	lw	$1, 76($30)
	addiu	$1, $1, 1
	sw	$1, 76($30)
	j	BB5_11
	nop
BB5_15:
	lw	$1, 116($30)
	lw	$2, 632($30)
	lw	$3, 0($2)
	addu	$1, $3, $1
	sw	$1, 0($2)
	lw	$1, 112($30)
	lw	$2, 632($30)
	lw	$3, 4($2)
	addu	$1, $3, $1
	sw	$1, 4($2)
	lw	$1, 108($30)
	lw	$2, 632($30)
	lw	$3, 8($2)
	addu	$1, $3, $1
	sw	$1, 8($2)
	lw	$1, 104($30)
	lw	$2, 632($30)
	lw	$3, 12($2)
	addu	$1, $3, $1
	sw	$1, 12($2)
	lw	$1, 100($30)
	lw	$2, 632($30)
	lw	$3, 16($2)
	addu	$1, $3, $1
	sw	$1, 16($2)
	lw	$1, 96($30)
	lw	$2, 632($30)
	lw	$3, 20($2)
	addu	$1, $3, $1
	sw	$1, 20($2)
	lw	$1, 92($30)
	lw	$2, 632($30)
	lw	$3, 24($2)
	addu	$1, $3, $1
	sw	$1, 24($2)
	lw	$1, 88($30)
	lw	$2, 632($30)
	lw	$3, 28($2)
	addu	$1, $3, $1
	sw	$1, 28($2)
	addiu	$2, $zero, 0
	addu	$29,$zero,$30
	lw	$30, 640($29)           # 4-byte Folded Reload
	lw	$ra, 644($29)           # 4-byte Folded Reload
	addiu	$29, $29, 648
	jr	$ra
	nop
func_end5:
                nop                        # -- End function
	

