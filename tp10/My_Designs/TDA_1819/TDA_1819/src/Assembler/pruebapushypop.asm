		.data
val1:		.word	100
val2:		.word	200
val3:		.word	300
		.code
		lw r1, val1(r0)
		nop
		lw r2, val2(r0)
		nop
		lw r3, val3(r0)
		nop
		pushh r1
		halt
		