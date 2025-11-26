		.data
SUMA:		.hword	0
MAYOR:		.hword	0
MENOR:		.hword	0
		.code
		daddi r15, r0, 4096
		daddi r1, r0, 38665
		daddi r2, r0, 6738
		nop	
		slt r3, r1, r2
		nop
		andi r3, r3, 1
		dadd r4, r1, r2
		nop
		beq r3, r0, A_MAY
		nop
		daddi r6, r1, 0
		daddi r7, r2, 0
		jmp CONT
A_MAY:		daddi r6, r2, 0
		daddi r7, r1, 0
CONT:		nop
		pushh r4
		andi r5, r4, 1
		nop
		beq r5, r0, SUM_PAR
		nop
		nop
		pushh r6
		nop
		nop
		nop
		pushh r7
		nop
		nop
		nop
		jmp LEER
SUM_PAR:	nop
		pushh r7
		nop
		nop
		nop
		pushh r6
		nop
		nop
LEER:		nop
		lh r10, 4(sp)
		nop
		lh r11, 2(sp)
		lh r12, 0(sp)
		sh r10, 0(r15)
		slt r13, r11, r12
		nop
		nop
		nop
		andi r13, r13, 1
		nop
		nop
		nop
		beq r13, r0, L_MAYOR
		nop
		sh r12, 2(r15)
		sh r11, 4(r15)
		jmp SIGUE
L_MAYOR:	nop
		sh r11, 2(r15)
		sh r12, 4(r15)
SIGUE:		nop
		beq r5, r0, PAR2
		nop
		sh r5, 4(sp)
		jmp POP
PAR2:		nop
		sh r0, 4(sp)
POP:		nop
		beq r5, r0, PP
		nop
		poph r7
		nop
		nop
		nop
		poph r6
		nop
		nop
		nop
		jmp FIN
PP:		nop
		poph r6
		nop
		nop
		nop
		poph r7
		nop
		nop
		nop
FIN:		nop
		nop
		nop
		poph r4
		nop
		nop
		nop
		halt
	