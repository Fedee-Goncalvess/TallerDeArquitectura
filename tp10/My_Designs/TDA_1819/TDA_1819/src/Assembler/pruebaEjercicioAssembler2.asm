		.data
SUMA:		.hword	0
		.code
		daddi r1, r0, 10
		daddi r2, r0, 20
		daddi r3, r0, 30
		daddi r4, r0, 40
		nop
		nop
		pushh r1
		nop
		nop
		nop
		pushh r2
		nop
		nop
		nop
		pushh r3
		nop
		nop
		nop
		pushh r4
		nop
		nop
		nop
		lh r5, 0(sp)
		lh r6, 2(sp)
		lh r7, 4(sp)
		lh r8, 6(sp)
		nop
		nop
		nop
		sh r0, 0(sp)
		sh r0, 2(sp)
		sh r0, 4(sp)
		sh r0, 6(sp)
		nop
		nop
		nop
		poph r1
		nop
		nop
		nop
		poph r2
		nop
		nop
		nop
		poph r3
		nop
		nop
		nop
		poph r4
		nop
		halt
	