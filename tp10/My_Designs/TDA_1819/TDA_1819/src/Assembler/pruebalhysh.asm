		.data
valor:		.hword	5000
offset:		.word	-4
resultado:	.hword	0
		.code
		daddi r1, r0, 5000
		daddi r10, r0, 30000
		nop
		nop
		nop
		sh r1, -2(sp)
		nop
		nop
		lh r2, -2(sp)
		nop
		nop
		halt
	