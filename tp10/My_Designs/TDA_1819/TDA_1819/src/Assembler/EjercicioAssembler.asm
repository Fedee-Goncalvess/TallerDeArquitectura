		.data
SUMA:		.hword	0
MAYOR:		.hword	0
MENOR:		.hword	0
		.code
		daddi r1, r0, 38665
		daddi r2, r0, 6738
		nop
		slt r3, r1, r2
		nop
		dadd r4, r1, r2
		nop
		beq r3, r0, A_MAYOR
		nop
		daddi r6, r1, 0
		daddi r7, r2, 0
		jmp CONT
A_MAYOR:	daddi r6, r2, 0
		daddi r7, r1, 0
CONT:		pushh r4
		andi r5, r4, 1
		nop
		beq r5, r0, SUMA_PAR
		nop
SUMA_IMPAR:	pushh r6
		nop
		nop
		nop
		pushh r7
		nop
		nop
		nop
		jmp LEER
SUMA_PAR:	pushh r7
		nop
		nop
		nop
		pushh r6
		nop
		nop
		nop
LEER:		lh r10, 4(sp)
		lh r11, 2(sp)
		lh r12, 0(sp)
		sh r10, SUMA(r0)
		slt r13, r11, r12
		beq r13, r0, L_MAYOR
		nop
		sh r11, MAYOR(r0)
		sh r12, MENOR(r0)
		jmp SIGUE
L_MAYOR:	sh r12, MAYOR(r0)
		sh r11, MENOR(r0)
SIGUE:		beq r5, r0, SUMA_PAR2
		nop
		sh r5, 4(sp)
		jmp POP
SUMA_PAR2:	sh r0, 4(sp)
POP:		beq r5, r0, POP_PAR
		nop
POP_IMPAR:	poph r7
		nop
		nop
		nop
		poph r6
		nop
		nop
		nop
		jmp FIN
POP_PAR:	poph r6
		nop
		nop
		nop
		poph r7
		nop
		nop
		nop
FIN:		poph r4
		nop
		nop
		nop
		halt
	